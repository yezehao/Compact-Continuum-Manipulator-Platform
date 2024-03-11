# Module Import
import numpy as np
import argparse
import time

# Funtion Import
from FABRIKc import backward_reach
from FABRIKc import FABRIKc
from conversion import conversion

## PARAMETER DEFINE IN MANIPULATOR
# The length of segment
Sr = 150 # unit: mm
# The distance between the connector centroid and cable connecting place
r = np.array([[17.5], [17.5], [15], [15]]) # unit: °

while True:
    # Taking input for mode
    mode = input("Please enter mode (0 for TEST, 1 for USER): ")

    # Checking the chosen mode
    if mode == "0": # mode 0 for test, using target angles as input
        while True:    
            target_angle = input(f"Mode 0 == TEST \nPlease input target angles θ in degree: ")
            try:
                angles_str = target_angle.split()
                target_angle = np.array([float(angle_str) for angle_str in angles_str])
                if len(target_angle) != 4:
                    raise ValueError("Expected 4 values as input.")
                break 
            except ValueError as e:
                print(f"Warming: {e}")

        # Record the start time        
        start = time.time()

        # Generate the target information
        target_cita = np.deg2rad(target_angle)
        target, orientation, _, _, _  = backward_reach(target_cita,Sr)
        print(f"The target position of end effector: \n{target}\n")
        print(f"The orientation of end effector: \n{orientation}\n")

        # Initialized at initial posture
        initialization = np.array([0, 0, 0, 0])
        max_loop = 60
        # Loop for inverse kinematics initialization updating
        for loop in range(max_loop):
            cita, error = FABRIKc(target, orientation, Sr, disp=1, cita=initialization)
            # Exit while lower than error threshold
            if error <= 0.05:
                break
            # Update initialization
            initialization = (initialization + cita) / 2  

        _ = conversion(cita,r)
        end = time.time()
        print(f"The programme execute for {np.round(end-start,decimals=5)} seconds")
        break

    elif mode == "1":
        print("User mode selected.")
        while True: # the position of target 
            target_position = input(f"Mode 1 == USER \nPlease input target position [x y z]: ")
            try:
                target_str = target_position.split()
                target = np.array([float(target_str) for target_str in target_str])
                if len(target) != 3:
                    raise ValueError("Expected 3 values as input.")
                break 
            except ValueError as e:
                print(f"Warming: {e}")
        while True: # the orientation of target along X-axis
            orien_x = input(f"Please input orientation about X-axis: ")
            try:
                orien_x_str  = orien_x.split()
                orien_x = np.array([float(orien_x_str) for orien_x_str in orien_x_str])
                if len(orien_x) != 3:
                    raise ValueError("Expected 3 values as input.")
                break 
            except ValueError as e:
                print(f"Warming: {e}")
        while True: # the orientation of target along Y-axis
            orien_y = input(f"Please input orientation about Y-axis: ")
            try:
                orien_y_str  = orien_y.split()
                orien_y = np.array([float(orien_y_str) for orien_y_str in orien_y_str])
                if len(orien_y) != 3:
                    raise ValueError("Expected 3 values as input.")
                break 
            except ValueError as e:
                print(f"Warming: {e}")
        while True: # the orientation of target along Z-axis
            orien_z = input(f"Please input orientation about Z-axis: ")
            try:
                orien_z_str  = orien_z.split()
                orien_z = np.array([float(orien_z_str) for orien_z_str in orien_z_str])
                if len(orien_z) != 3:
                    raise ValueError("Expected 3 values as input.")
                break 
            except ValueError as e:
                print(f"Warming: {e}")

        # Record the start time        
        start = time.time()

        # Target Defination
        orientation = np.array([orien_x,orien_y,orien_z])
        print(f"The target position of end effector: \n{target}\n")
        print(f"The orientation of end effector: \n{orientation}\n")

        # Initialized at initial posture
        initialization = np.array([0, 0, 0, 0])
        max_loop = 60
        # Loop for inverse kinematics initialization updating
        for loop in range(max_loop):
            cita, error = FABRIKc(target, orientation, Sr, disp=1, cita=initialization)
            # Exit while lower than error threshold
            if error <= 0.05:
                break
            # Update initialization
            initialization = (initialization + cita) / 2    

        _ = conversion(cita,r)
        end = time.time()
        print(f"The programme execute for {np.round(end-start,decimals=5)} seconds")
        break

    else:
        print("Invalid mode. Please enter either 0 or 1.")