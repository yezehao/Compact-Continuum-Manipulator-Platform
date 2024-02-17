from numpy import *

# Input the parameters here------------
Sr = 1

r1 = 0.2
r2 = 0.2
r3 = 0.2
r4 = 0.2

a1 = 10
a2 = 10
a3 = -10
a4 = -10
#---------------------------------------
# convert angles to rads
a1_rad = a1 * (pi / 180)
a2_rad = a2 * (pi / 180)
a3_rad = a3 * (pi / 180)
a4_rad = a4 * (pi / 180)

# Matrix form of input variables
r = array([[r1], [r2], [r3], [r4]])
a = array([[a1], [a2], [a3], [a4]])
a_rad = array([[a1_rad], [a2_rad], [a3_rad], [a4_rad]])

# Define the dS variables
dS = zeros((8, 1))

# Matrix used for calculate dS
H = array([[r1, 0, 0, 0],[-r1, 0, 0, 0],[0, r2, 0, 0],[0, -r2, 0, 0],[r1, 0, r3, 0], [-r1, 0, -r3, 0],
           [0, r2, 0, r4],[0, -r2, 0, -r4]])

if __name__ == '__main__':
    # Calculate dS
    dS = H.dot(a_rad)

    print("The input parameters:\n")
    print("Sr=", Sr, "\n")
    print("the r matrix:\n", r)
    print("the angle matrix:\n", a)
    print("the output dS matrix:\n", dS)