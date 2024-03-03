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

_ = conversion(alpha,r)