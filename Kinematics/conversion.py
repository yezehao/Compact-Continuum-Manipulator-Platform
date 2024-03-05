import numpy as np
import argparse

#### Input the parameters here ###
# The length of the single segment
Sr = 150
# The distance between the connector centroid and cable connecting place
r = np.array([[17.5], [17.5], [15], [15]]) 
# The bending angles of segments
alpha = np.array([[120], [120], [120], [120]])
###################################

# Input the angles for the target
parser = argparse.ArgumentParser(description='Process angle values.')
# The default angles are [0, 0, 90, 0], and the arguments is optional
parser.add_argument('mode', type=float, nargs='?', help='the mode of conversion')
args = parser.parse_args()
mode = args.mode
if mode == 0:
    print("MODE 0: Convert α into ∆S.")
elif mode == 1:
    print("MODE 1: Convert ∆S into α.")
else:
    print(f"Please select the mode for conversion:\n MODE 0: α ==> ∆S \n MODE 1: ∆S ==> α")
    exit()

def conversion(alpha, r, mode):
    if mode == 0: # angles to dS
        # convert angles to rads
        radians = np.deg2rad(alpha)

        # Define the dS variables
        dS = np.zeros((8, 1))

        # Matrix used for calculate dS
        char = np.array([[1, 0, 0, 0],
                        [-1, 0, 0, 0],
                        [0, 1, 0, 0],
                        [0, -1, 0, 0],
                        [1, 0, 1, 0], 
                        [-1, 0, -1, 0],
                        [0, 1, 0, 1],
                        [0, -1, 0, -1]])
        H = char * r.T
        dS = H.dot(radians)
        deltaS = np.round(dS, decimals=3)
        print(f"The increment of cables:")
        print(f"{deltaS[0]},{deltaS[1]},")
        print(f"{deltaS[2]},{deltaS[3]},")
        print(f"{deltaS[4]},{deltaS[5]},")
        print(f"{deltaS[6]},{deltaS[7]}]")

_ = conversion(alpha,r,mode=mode)