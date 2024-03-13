# Discription
### [MPU6050](MPU6050)
This section shows the code and wiring schematic for testing the MPU6050. Since Proteus does not support the simulation function of MPU6050, the code has been verified successfully by physical verification, and the measured results can be displayed through the serial monitor. For physical control, this code needs to be ported to the Tof ranging code and the detected structures displayed through the OLED screen.

### [OLED & ToF](OLED+ToF)
This part of the code and simulation implements the detection of the distance between the end-effector and the object to be measured by means of an ultrasonic sensor and displays it on an OLED screen.
After the completion of the code compilation, the generated .Hex file needs to be embedded as embedded code on Arduino Uno on Proteus.

### [Upper Computer Command](Upper-computer-command-communication)
This code implements the input of a string through the serial monitor and displays the contents on the LCD screen. This code has been physically verified. This code needs to be written in conjunction with the stepper motor control code.