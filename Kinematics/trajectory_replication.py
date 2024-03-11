# Module Import
import numpy as np
import argparse
import time

# Self-defined Function Import
from FABRIKc import FABRIKc
from FABRIKc import backward_reach

# Record starting time
start = time.time()

# The length of segment
Sr = 150 # unit: mm

# Overwrite the files for datasaving at the beginning
with open('circle/target_.txt', 'w') as f1, open('circle/cita.txt', 'w') as f2:
    f1.write('')
    f2.write('')
with open('circle/target.txt', 'w') as f3, open('circle/error.txt', 'w') as f4:
    f3.write('')
    f4.write('')

# Get the data about the critical path
target_angle_path = 'circle/alpha.txt'
# Put the angles in Numpy
target_angles = np.loadtxt(target_angle_path)

# Inverse kinematics for every points on the critical path
for i in range(target_angles.shape[1]):
    target_angle = target_angles[:,i].T

    # Generate the target 
    # The postion and orientation of end effector can also be given by users
    target_cita = np.deg2rad(target_angle)
    target, orientation, _, _, _  = backward_reach(target_cita,Sr)
    print(f"The target angles: \n{target_angle}\n")

    # Initialized at initial posture
    initialization = np.array([0, 0, 0, 0])
    max_loop = 50
    # Loop for inverse kinematics initialization updating
    for loop in range(max_loop):
        cita, error = FABRIKc(target, orientation, Sr, disp=1, cita=initialization)
        # Exit while lower than error threshold
        if error <= 0.5:
            break
        # Update initialization
        initialization = (initialization + cita) / 2  
    
    radian = np.deg2rad(cita)     
    target_, _, _, _, _= backward_reach(radian,Sr) # target_ is the end effector position by "θ"

    # Save the data in .txt files
    cita_T = np.array(cita)
    target_T = target_.T
    targetT = target.T
    with open('circle/cita.txt', 'a') as f:
        f.write(' '.join(map(str, cita_T)) + '\n')
    with open('circle/target_.txt', 'a') as f:
        f.write(' '.join(format(x, '.5f') for x in target_T) + '\n')
    with open('circle/target.txt', 'a') as f:
        f.write(' '.join(format(x, '.5f') for x in targetT) + '\n')
    with open('circle/error.txt', 'a') as f:
        f.write(str(error) + '\n')

# Display the running time of the programme
end = time.time()
print(f"The programme execute for {np.round(end-start,decimals=5)} seconds")