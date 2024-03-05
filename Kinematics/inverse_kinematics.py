# Module Import
import numpy as np
import argparse
import time

# Funtion Import
from FABRIKc import backward_reach
from FABRIKc import FABRIKc
from conversion import conversion

# The length of segment
Sr = 150 # unit: mm
# The distance between the connector centroid and cable connecting place
r = np.array([[17.5], [17.5], [15], [15]]) # unit: °

# Input the angles for the target
parser = argparse.ArgumentParser(description='Process angle values.')
# The default angles are [0, 0, 90, 0], and the arguments is optional
parser.add_argument('theta1', type=float, nargs='?', help='segment 1 bending angle')
parser.add_argument('theta2', type=float, nargs='?', help='segment 2 bending angle')
parser.add_argument('theta3', type=float, nargs='?', help='segment 3 bending angle')
parser.add_argument('theta4', type=float, nargs='?', help='segment 4 bending angle')
parser.add_argument('alpha1', type=float, nargs='?', help='segment 1 initialization')
parser.add_argument('alpha2', type=float, nargs='?', help='segment 2 initialization')
parser.add_argument('alpha3', type=float, nargs='?', help='segment 3 initialization')
parser.add_argument('alpha4', type=float, nargs='?', help='segment 4 initialization')
args = parser.parse_args()

# put the angles in Numpy
target_angle = np.array([args.theta1, args.theta2, args.theta3, args.theta4])
initialization = np.array([args.alpha1, args.alpha2, args.alpha3, args.alpha4])
# The target bending angle theta
if None in target_angle:
    if all(value is None for value in target_angle):
        target_angle = np.array([0, 0, 90, 0]) # the default angles are [0, 0, 90, 0]
        print("The defualt angles of manipulator segments: ", target_angle)
    else:
        print("Error: Insufficient number of values provided. Expected 4 values.")
        exit()
else:
    print("The angles of manipulator segments: ", target_angle)
# The initialization bending angles alpha
if None in initialization:
    if all(value is None for value in initialization):
        initialization = np.array([0, 0, 0, 0]) # the initialization is initial posture
        print("The defualt initialization of manipulator segments: ", initialization)
    else: 
        print("Error: Insufficient number of values provided. Expected 4 values.")
        exit()
else:
    print("The initialization of manipulator segments: ", initialization)

# Generate the target
target_cita = np.deg2rad(target_angle)
target, orientation, _, _, _  = backward_reach(target_cita,Sr)
print(f"The target position of end effector: \n{target}\n")
print(f"The orientation of end effector: \n{orientation}\n")

## MAIN ###
start = time.time()
cita, _ = FABRIKc(target, orientation,Sr,disp=1,cita=initialization)
target_, _, _, _, _  = backward_reach(np.deg2rad(cita),Sr)
print(target_)
_ = conversion(cita,r,mode=0)
end = time.time()
print(f"The programme execute for {np.round(end-start,decimals=5)} seconds")