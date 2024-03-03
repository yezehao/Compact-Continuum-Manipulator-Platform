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
parser.add_argument('seg1', type=float, nargs='?', help='segment 1 bending angle')
parser.add_argument('seg2', type=float, nargs='?', help='segment 2 bending angle')
parser.add_argument('seg3', type=float, nargs='?', help='segment 3 bending angle')
parser.add_argument('seg4', type=float, nargs='?', help='segment 4 bending angle')
args = parser.parse_args()

# put the angles in Numpy
target_angle = np.array([args.seg1, args.seg2, args.seg3, args.seg4])
if None in target_angle:
    if all(value is None for value in target_angle):
        target_angle = np.array([0, 0, 90, 0]) # the default angles are [0, 0, 90, 0]
        print("The defualt angles of manipulator segments: ", target_angle)
    else:
        print("Error: Insufficient number of values provided. Expected 4 values.")
        exit()
else:
    print("The angles of manipulator segments: ", target_angle)

# Generate the target
target_cita = np.deg2rad(target_angle)
target, orientation, _, _, _  = backward_reach(target_cita,Sr)
print(f"The target position of end effector: \n{target}\n")
print(f"The orientation of end effector: \n{orientation}\n")

## MAIN ###
start = time.time()
cita_before = np.array([0,0,20,20], dtype=np.float64)
cita, _ = FABRIKc(target, orientation,Sr,disp=1)
_ = conversion(cita,r)
end = time.time()
print(f"The programme execute for {np.round(end-start,decimals=5)} seconds")