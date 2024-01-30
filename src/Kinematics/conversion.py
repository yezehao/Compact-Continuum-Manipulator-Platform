import math

# Input the parameters here
Sr = 1
r1=0.2
r2=0.2
r3=0.2
r4=0.2
a1 = 90
a2 = 90
a3 = -90
a4 = -90

# convert angles to rads
a1_rad = a1*(math.pi / 180)
a2_rad = a2*(math.pi / 180)
a3_rad = a3*(math.pi / 180)
a4_rad = a4*(math.pi / 180)

# Get R
R1 = Sr/a1_rad
R2 = Sr/a2_rad
R3 = Sr/a3_rad
R4 = Sr/a4_rad

#Define the variables
dS1 = 0
dS2 = 0
dS3 = 0
dS4 = 0
dS5 = 0
dS6 = 0
dS7 = 0
dS8 = 0

if __name__ == '__main__':
    # Calculate cables on the first section
    if a1 >= 0:
        dS1 = (R1 + r1) * a1_rad - Sr
        dS2 = (R1 - r1) * a1_rad - Sr

    elif a1 < 0:
        dS1 = (R1 - r1) * a1_rad - Sr
        dS2 = (R1 + r1) * a1_rad - Sr

    # Calculate cables on the second section
    if a2 >= 0:
        dS3 = (R2 + r2) * a2_rad - Sr
        dS4 = (R2 - r2) * a2_rad - Sr

    elif a2 < 0:
        dS3 = (R2 - r2) * a2_rad - Sr
        dS4 = (R2 + r2) * a2_rad - Sr

    # Calculate cables on the third section
    if a3 >= 0:
        dS5 = dS1 + ((R3 + r3) * a3_rad - Sr)
        dS6 = dS2 + ((R3 - r3) * a3_rad - Sr)

    elif a3 < 0:
        dS5 = dS1 + ((R3 - r3) * a3_rad - Sr)
        dS6 = dS2 + ((R3 + r3) * a3_rad - Sr)

    # Calculate cables on the forth section
    if a4 >= 0:
        dS7 = dS3 + ((R4 + r4) * a4_rad - Sr)
        dS8 = dS4 + ((R4 - r4) * a4_rad - Sr)

    if a4 < 0:
        dS7 = dS3 + ((R4 - r4) * a4_rad - Sr)
        dS8 = dS4 + ((R4 + r4) * a4_rad - Sr)

    # Blit the result:
    print("Parameters:")
    print(f"Sr = {Sr}, r = {r}, Four angles are:{a1,a2, a3, a4} \n{round(a1_rad,5), round(a2_rad,5), round(a3_rad,5), round(a4_rad,5)} in radian")
    print( "Sr =" , Sr, ", r = ", r, ", Four angles are:", a1, a2, a3, a4, "(", a1_rad, a2_rad, a3_rad, a4_rad, " in rads)")
    print("R:", R1, R2, R3, R4,)
    print("\n Output:")
    print("Delta S1 = ", dS1)
    print("Delta S2 = ", dS2)
    print("Delta S3 = ", dS3)
    print("Delta S4 = ", dS4)
    print("Delta S5 = ", dS5)
    print("Delta S6 = ", dS6)
    print("Delta S7 = ", dS7)
    print("Delta S8 = ", dS8)