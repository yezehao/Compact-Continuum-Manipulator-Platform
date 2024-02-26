# Module Import
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

Sr = 150 # unit: mm
# Virtual Node Initial Define
virtual_node = np.zeros((4,3))
# Node Initial Define
node = np.zeros((4,3))
# Virtual Link Length Define
l = np.array([0, 0, 0, 0])

def forward_reaching_phase(target, orientation, cita, l, virtual_node, node):
    # Iteration 1
    virtual_node[3,:] = target - l[3]*orientation[2,:]
    virtual = virtual_node[3,:] - virtual_node[2,:]
    vector = orientation @ virtual
    cita[3] = -np.arctan2(vector[0],vector[2])
    # vector = (virtual) + (virtual) * orientation[1,:]
    # cita[3] = np.arccos(vector @ orientation[2,:]/(np.linalg.norm(vector)*np.linalg.norm(orientation[2,:])))
    if cita[3]==0:
        l[3] = Sr/2
    else:
        l[3] = Sr/cita[3]*np.tan(cita[3]/2)
    virtual_node[3,:] = target - l[3]*orientation[2,:]
    R_y = np.array([[np.cos(cita[3]), 0, np.sin(cita[3])], 
                    [0, 1, 0], 
                    [-np.sin(cita[3]), 0, np.cos(cita[3])]])
    orientation = R_y @ orientation
    node[3,:] = virtual_node[3,:] - l[3] * orientation[2,:]

    # Iteration 2
    virtual_node[2,:] = node[3,:] - l[2]*orientation[2,:]
    virtual = virtual_node[2,:] - virtual_node[1,:]
    vector = orientation @ virtual
    cita[2] = -np.arctan2(vector[1],vector[2])
    # vector = virtual + virtual * orientation[0,:]
    # cita[2] = np.arccos(vector @ orientation[2,:]/(np.linalg.norm(vector)*np.linalg.norm(orientation[2,:])))
    if cita[2]==0:
        l[2] = Sr/2
    else:
        l[2] = Sr/cita[2]*np.tan(cita[2]/2)
    virtual_node[2,:] = node[3,:] - l[2]*orientation[2,:]
    R_x = np.array([[1, 0, 0], 
                    [0, np.cos(cita[2]), np.sin(cita[2])], 
                    [0, -np.sin(cita[2]), np.cos(cita[2])]])
    orientation = R_x @ orientation
    node[2,:] = virtual_node[2,:] - l[2]*orientation[2,:]

    # Iteration 3
    virtual_node[1,:] = node[2,:] - l[1]*orientation[2,:]
    virtual = virtual_node[1,:] - virtual_node[0,:]
    vector = orientation @ virtual
    cita[1] = -np.arctan2(vector[0],vector[2])
    # vector = virtual + virtual * orientation[1,:]
    # cita[1] = np.arccos(vector @ orientation[2,:]/(np.linalg.norm(vector)*np.linalg.norm(orientation[2,:])))
    if cita[1]==0:
        l[1] = Sr/2
    else:
        l[1] = Sr/cita[1]*np.tan(cita[1]/2)
    virtual_node[1,:] = node[2,:] - l[1]*orientation[2,:]
    R_y = np.array([[np.cos(cita[1]), 0, np.sin(cita[1])], 
                    [0, 1, 0], 
                    [-np.sin(cita[1]), 0, np.cos(cita[1])]])
    orientation = R_y @ orientation
    node[1,:] = virtual_node[1,:] - l[1]*orientation[2,:]

    # Iteration 4
    cita[0] = np.arccos(np.array([0, 0, 1]) @ orientation[2,:])/(np.linalg.norm(orientation[2,:]))
    if cita[0]==0:
        l[0] = Sr/2
    else:
        l[0] = Sr/cita[0]*np.tan(cita[0]/2)
    virtual_node[0,:] = node[1,:] - l[0]*orientation[2,:]
    node[0,:] = virtual_node[0,:] - l[0]*np.array([0, 0, 1])
    print(np.rad2deg(cita))

    # Plot_3D(target, node,virtual_node)
    
    return cita

def forward_kinematics (radians):
    M = [{'bend': np.eye(3), 'bend_inv': np.eye(3), 'displacement': np.zeros((3, 1)), 
        'B': np.eye(3)} for _ in range(5)]
    nodes = np.zeros((5,3))

    d = 0

    # Orientation Calculation
    for i in range(4):
        alpha = radians[i]
        if np.sign(alpha) == 0:
            Dhorz = 0
            Dvert = Sr + d
        else:
            R = Sr / alpha
            Dhorz = R * (1 - np.cos(alpha)) + d * np.sin(alpha)
            Dvert = R * np.sin(alpha) + d * np.cos(alpha)
        if i % 2 == 0:
            Mt = np.array([[1, 0, 0],
                           [0, np.cos(alpha), np.sin(alpha)],
                           [0, -np.sin(alpha), np.cos(alpha)]])
            Mt_inv = np.transpose(Mt)
            M[i]['displacement'] = np.array([[0],[Dhorz],[Dvert]])
        else:
            Mt = np.array([[np.cos(alpha), 0, np.sin(alpha)],
                           [0, 1, 0],
                           [-np.sin(alpha), 0, np.cos(alpha)]])
            Mt_inv = np.transpose(Mt)
            M[i]['displacement'] = np.array([[Dhorz],[0],[Dvert]])
        M[i+1]['bend'] = np.round(Mt * 1e5) / 1e5
        M[i+1]['bend_inv'] = np.round(np.dot(Mt_inv, M[i]['bend_inv']) * 1e5) / 1e5

    for i in range(len(M)):
        for j in range(i + 1):
            M[i]['B'] = np.dot(M[i]['B'], M[j]['bend'])

    # Node position calculation
    for i in range(1, 5):
        nodes[i,:] = np.dot(M[i-1]['B'], M[i-1]['displacement']).T + nodes[i-1,:]

    for i in range(4):
        if radians[i]==0:
            l[i] = Sr/2
        else:
            l[i] = Sr/radians[i]*np.tan(radians[i]/2)
        virtual_node[i,:] = nodes[i,:] + l[i]*M[i]['bend_inv'][2,:]

    orientation = M[4]['bend_inv']
    target = nodes[4,:]
    node = nodes[0:4,:]

    return target, orientation, node, virtual_node,l

## MAIN ##
# Generate the target through forward kinematics for test
target_angle = np.array([0, 0, 0, 90])
target_cita = np.deg2rad(target_angle)
target, orientation, node, virtual_node, l  = forward_kinematics(target_cita)
print(f"The target position of end effector: \n{target}\n")
print(f"The orientation of end effector: \n{orientation}\n")

# The initial position of manipulator
cita = np.array([0,0,0,0], dtype=np.float64)
l = np.array([Sr/2, Sr/2, Sr/2, Sr/2])
virtual_node = np.array([[0, 0, 1*Sr/2], 
                        [0, 0, 3*Sr/2], 
                        [0, 0, 5*Sr/2], 
                        [0, 0, 7*Sr/2]])
node = np.array([[0, 0, 0*Sr], 
                [0, 0, 1*Sr], 
                [0, 0, 2*Sr], 
                [0, 0, 3*Sr]])

# LOOP
for i in range(5):
    cita = forward_reaching_phase(target, orientation, cita, l, virtual_node, node)
    target_, orientation_, node, virtual_node, l = forward_kinematics(cita)
    error = np.linalg.norm(target-target_)
    print(error)