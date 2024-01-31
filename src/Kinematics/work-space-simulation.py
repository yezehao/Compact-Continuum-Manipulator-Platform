# Module Import
import torch
import json
import time
import sys
import numpy as np
import scipy.constants as phy
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

# GPU check
device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
print(f'Using device: {device}')
print(f'Pytorch version: {torch.__version__}')
print(f'CUDA version: {torch.version.cuda}')
torch.cuda.set_device(0)

class FK:
    def __init__(self, parameter, rad_random):
        self.device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
        self.Sr = parameter['Sr']
        self.d = parameter['d']
        self.radians = rad_random
        self.M = [{'Mt': torch.eye(3).to('cuda'), 
                   'Mt_inv': torch.eye(3).to('cuda'), 
                   'disp': torch.zeros(3, 1).to('cuda')} 
                   for _ in range(5)]
        self.node = [{'position': torch.zeros(3,1).to('cuda'), 
                   'orientation': torch.eye(3).to('cuda')} 
                   for _ in range(5)]
    # FUNCTION: round to specific decimal
    def Round (self, Num, decimal):
        Num_round = torch.round(Num*(10**decimal))/(10**decimal)
        return Num_round
    
    # FUNCTION: calculate the orientation of joints
    def Orientation(self,alpha,i): 
        if i % 2 == 0: # the backbone parallel with X axis
            Mt = torch.tensor(
                [[1, 0, 0],
                [0, torch.cos(alpha), torch.sin(alpha)],
                [0, -torch.sin(alpha), torch.cos(alpha)]]).to(self.device)
        else: # the backbone parallel with Y axis
            Mt = torch.tensor(
                [[torch.cos(alpha), 0, torch.sin(alpha)],
                [0, 1, 0],
                [-torch.sin(alpha), 0, torch.cos(alpha)]]).to(self.device)
        Mt_inv = torch.transpose(Mt, 0, 1)
        self.M[i+1]['Mt'] = self.Round(torch.mm(self.M[i]['Mt'], Mt), 6)
        self.M[i+1]['Mt_inv'] = self.Round(torch.mm(Mt_inv, self.M[i]['Mt_inv']), 6)
    
    # FUNCTION: calculate relative displacement
    def Displacement (self, alpha,i): 
        Sr = self.Sr[i]
        d = self.d[i]
        if torch.sign(alpha) == 0:
            Dhorz = 0
            Dvert = Sr + d
        else:
            R = Sr / alpha
            Dhorz = R * (1 - np.cos(alpha)) + d * np.sin(alpha)
            Dvert = R * np.sin(alpha) + d * np.cos(alpha)
        if i % 2 == 0: # the backbone parallel with X axis
            disp = torch.tensor([[0],[Dhorz],[Dvert]]).to(self.device)
        else: # the backbone parallel with Y axis
            disp = torch.tensor([[Dhorz],[0],[Dvert]]).to(self.device)
        self.M[i+1]['disp'] = self.Round(disp,6)
        return disp

    # FUNCTION: calculate node information of manipulator
    def Node (self): 
        for i in range(1,5):
            self.node[i]['position'] = torch.mm(self.M[i-1]['Mt'], self.M[i]['disp']) + self.node[i-1]['position']
            self.node[i]['orientation'] = self.M[i]['Mt_inv']
    
    # FUNCTION: forward kinematics function
    def forward_kinematics (self):
        for i in range(4):
            alpha = self.radians[i]  # Replace with your actual value
            self.Orientation(alpha, i)
            self.Displacement(alpha, i)
        self.Node()



##### Manipulator Parameter Define #####
# Sr:  the arc length of the bending curve                                 
# r:   the distance between the central axis of cable guiding hole and the central axis of connector                 
# d:   the thickness of the cross-shaped sheet 
# n:   the number of cross-shaped sheet
# MBA: the maximum bending angle = Sr/R = (Sr-n*d)/r
parameter = {} # create the dictionary 'parameter'
parameter['Sr']  = torch.tensor([150,150,150,150])
parameter['n']   = torch.tensor([5,5,5,5]) 
parameter['d']   = 0.05 * parameter['Sr']
parameter['r']   = torch.tensor([50,50,40,40]) 
parameter['MBA'] = (parameter['Sr'] - parameter['n'] * parameter['d']) / parameter['r']

T_start = time.time()
loop_count = int(sys.argv[1])
data = []
for j in range(loop_count):
    rad_random = 2 * parameter['MBA'] * torch.rand((1, 4)) - parameter['MBA']
    render = FK(parameter, rad_random.squeeze())
    render.forward_kinematics()

    x = render.node[4]['position'][0].item()
    y = render.node[4]['position'][1].item()
    z = render.node[4]['position'][2].item()
    # print(f"Loop {j}: The end effector of manipulator is [{x:.6f} {y:.6f} {z:.6f}].")
    if j % 1000 == 0:
        print(f"LOOP {j} | {100*j/loop_count:.2f}%")
    # Save data to list
    data.append({'angles': rad_random.squeeze().tolist(), 'position': [x, y, z]})

    # Delete variables to free up memory
    del x, y, z

# Save the list to a JSON file
with open('workspace.json', 'w') as json_file:
    json.dump(data, json_file, indent=2)
    json_file.write('\n')

T_end = time.time()
print(f"The elapsed time: {T_end-T_start} seconds")



