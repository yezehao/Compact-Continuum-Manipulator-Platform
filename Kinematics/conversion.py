import numpy as np

#### Input the parameters here ###
# The length of the single segment
Sr = 150
# The distance between the connector centroid and cable connecting place
r = np.array([[17.5], [17.5], [15], [15]]) 
# The bending angles of segments
alpha = np.array([[120], [120], [120], [120]])
###################################

def conversion(alpha, r):
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

def inv_conversion(dS, r):
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
    radians, residuals, _, _ = np.linalg.lstsq(H, dS, rcond=None)
    radians = np.round(np.rad2deg(radians), decimals=3)
    print(f"The bending angles of manipulator:")
    print(f"{radians}")

# # Uncommnet this code for test programme
# while True:
#     mode = input(f"Please enter mode (0 or 1): \nMode 0: θ ==> ΔS\nMode 1: ΔS ==> θ\n")
#     # Checking the chosen mode
#     if mode == "0": # mode 0 for test, using target angles as input
#         while True:    
#             target_angle = input(f"Mode 0: θ ==> ΔS \nPlease input angles θ in degree: ")
#             try:
#                 angles_str = target_angle.split()
#                 target_angle = np.array([float(angle_str) for angle_str in angles_str])
#                 if len(target_angle) != 4:
#                     raise ValueError("Expected 4 values as input.")
#                 break 
#             except ValueError as e:
#                 print(f"Warming: {e}")

#         _ = conversion(alpha=target_angle, r=r)
#         break

#     elif mode == "1":
#         print("User mode selected.")
#         while True: # the position of target 
#             deltaS = input(f"Mode 1: ΔS ==> θ \nPlease input ΔS in mm: ")
#             try:
#                 deltaS_str = deltaS.split()
#                 deltaS = np.array([float(target_str) for target_str in deltaS_str]).T
#                 if len(deltaS) != 8:
#                     raise ValueError("Expected 8 values as input.")
#                 break 
#             except ValueError as e:
#                 print(f"Warming: {e}")
       

#         # Record the start time        
#         _ = inv_conversion(dS=deltaS, r=r)
#         break

#     else:
#         print("Invalid mode. Please enter either 0 or 1.")
