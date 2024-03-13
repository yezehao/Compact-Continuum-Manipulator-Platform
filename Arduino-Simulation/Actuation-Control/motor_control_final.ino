#include "AccelStepper.h"
#include <Wire.h> //调用wire库
#include <LiquidCrystal_I2C.h> //调用LiquidCrystal_I2C库

#define FULLSTEP 4      //fullstep means 2048 steps per revolution

#define motor1Pin1  22     // define the pins of motor 1
#define motor1Pin2  24     
#define motor1Pin3  26    
#define motor1Pin4  28    

#define motor2Pin1  30     // define the pins of motor 2
#define motor2Pin2  32     
#define motor2Pin3  34    
#define motor2Pin4  36    

#define motor3Pin1  38     // define the pins of motor 3
#define motor3Pin2  40     
#define motor3Pin3  42    
#define motor3Pin4  44    

#define motor4Pin1  46     // define the pins of motor 4
#define motor4Pin2  48     
#define motor4Pin3  50    
#define motor4Pin4  52    

#define motor5Pin1  23     // define the pins of motor 5
#define motor5Pin2  25     
#define motor5Pin3  27    
#define motor5Pin4  29    

#define motor6Pin1  31     // define the pins of motor 6
#define motor6Pin2  33     
#define motor6Pin3  35    
#define motor6Pin4  37    

#define motor7Pin1  39     // define the pins of motor 7
#define motor7Pin2  41     
#define motor7Pin3  43    
#define motor7Pin4  45    

#define motor8Pin1  47     // define the pins of motor 8
#define motor8Pin2  49     
#define motor8Pin3  51    
#define motor8Pin4  53    

#define d 10              //define the diameter of the rotor, unit:mm

AccelStepper stepper1(FULLSTEP, motor1Pin1, motor1Pin3, motor1Pin2, motor1Pin4);
AccelStepper stepper2(FULLSTEP, motor2Pin1, motor2Pin3, motor2Pin2, motor2Pin4);
AccelStepper stepper3(FULLSTEP, motor3Pin1, motor3Pin3, motor3Pin2, motor3Pin4);
AccelStepper stepper4(FULLSTEP, motor4Pin1, motor4Pin3, motor4Pin2, motor4Pin4);
AccelStepper stepper5(FULLSTEP, motor5Pin1, motor5Pin3, motor5Pin2, motor5Pin4);
AccelStepper stepper6(FULLSTEP, motor6Pin1, motor6Pin3, motor6Pin2, motor6Pin4);
AccelStepper stepper7(FULLSTEP, motor7Pin1, motor7Pin3, motor7Pin2, motor7Pin4);
AccelStepper stepper8(FULLSTEP, motor8Pin1, motor8Pin3, motor8Pin2, motor8Pin4);

String string = "";

int steps = 0;

float s1 = 0;            //8 variables stores the 8 different delta S
float s2 = 0;
float s3 = 0;
float s4 = 0;
float s5 = 0;
float s6 = 0;
float s7 = 0;
float s8 = 0;

float prev_s1 = 0;            //8 variables stores the 8 different delta S
float prev_s2 = 0;
float prev_s3 = 0;
float prev_s4 = 0;
float prev_s5 = 0;
float prev_s6 = 0;
float prev_s7 = 0;
float prev_s8 = 0;

int step1 = 0;
int step2 = 0;
int step3 = 0;
int step4 = 0;
int step5 = 0;
int step6 = 0;
int step7 = 0;
int step8 = 0;

bool input1 = true;          //decide which angle shoule be input currently
bool input2 = false;
bool input3 = false;
bool input4 = false;
bool input5 = false;
bool input6 = false;
bool input7 = false;
bool input8 = false;
bool ready = false;         //decide if input is finished, and the program is ready to pass the angle values to the motor.
bool moveFinished = false;


void setup() {

  Serial.begin(9600);                                                  //initialization process
  Serial.println("\n----------------------------------------------------\n");
  Serial.println("Welcome to Arduino control panel!");
  Serial.println("Please input the 8 angles in order");
  Serial.println("type 'clear' to re-input\n");
  Serial.println("----------------------------------------------------\n");
  Serial.println("Now, please input the 1st angle:\n");

  stepper1.setMaxSpeed(300.0);    // 1号电机最大速度600 
  stepper1.setSpeed(300.0);  // 1号电机加速度150.0
  stepper1.setAcceleration(150);
  stepper1.setCurrentPosition(0);

  stepper2.setMaxSpeed(300.0);    // 1号电机最大速度600 
  stepper2.setSpeed(300.0);  // 1号电机加速度150.0
  stepper2.setAcceleration(150);
  stepper2.setCurrentPosition(0);

  stepper3.setMaxSpeed(300.0);    // 1号电机最大速度600 
  stepper3.setSpeed(300.0);  // 1号电机加速度150.0
  stepper3.setAcceleration(150);
  stepper3.setCurrentPosition(0);

  stepper4.setMaxSpeed(300.0);    // 1号电机最大速度600 
  stepper4.setSpeed(300.0);  // 1号电机加速度150.0
  stepper4.setAcceleration(150);
  stepper4.setCurrentPosition(0);

  stepper5.setMaxSpeed(557.0);    // 1号电机最大速度600 
  stepper5.setSpeed(557.0);  // 1号电机加速度150.0
  stepper5.setAcceleration(150);
  stepper5.setCurrentPosition(0);

  stepper6.setMaxSpeed(557.0);    // 1号电机最大速度600 
  stepper6.setSpeed(557.0);  // 1号电机加速度150.0
  stepper6.setAcceleration(150);
  stepper6.setCurrentPosition(0);

  stepper7.setMaxSpeed(557.0);    // 1号电机最大速度600 
  stepper7.setSpeed(557.0);  // 1号电机加速度150.0
  stepper7.setAcceleration(150);
  stepper7.setCurrentPosition(0);

  stepper8.setMaxSpeed(557.0);    // 1号电机最大速度600 
  stepper8.setSpeed(557.0);  // 1号电机加速度150.0
  stepper8.setAcceleration(150);
  stepper8.setCurrentPosition(0);
}

void loop(){

if (Serial.available() > 0 && input1 == true){                          //input angle 1
  
  string = Serial.readString();
  s1 = string.toFloat();
  if ( s1<= -36.65 || s1>= 36.65){
    Serial.print("delta s not in range! Please re-input\n");
  }
  else{
  input1 = false;
  input2 = true;
  input3 = false;
  input4 = false;
  input5 = false;
  input6 = false;
  input7 = false;
  input8 = false;
  Serial.print("delta s1 is:");
  Serial.print(s1);
  Serial.println("\nNow, please input the 2nd delta s:\n");
  }
}

if (Serial.available() > 0 && input2 == true){                          //input angle 2
  
  string = Serial.readString();
  s2 = string.toFloat();
   if ( s2<= -36.65 || s2>= 36.65){
    Serial.print("delta s not in range! Please re-input\n");
  }
  else{
  input1 = false;
  input2 = false;
  input3 = true;
  input4 = false;
  input5 = false;
  input6 = false;
  input7 = false;
  input8 = false;
  Serial.print("delta s2 is:");
  Serial.print(s2);
  Serial.println("\nNow, please input the 3rd delta s:\n");
  }
}

if (Serial.available() > 0 && input3 == true){                          //input angle 3
  
  string = Serial.readString();
  s3 = string.toFloat();
   if ( s3<= -36.65 || s3>= 36.65){
    Serial.print("delta s not in range! Please re-input\n");
  }
  else{
  input1 = false;
  input2 = false;
  input3 = false;
  input4 = true;
  input5 = false;
  input6 = false;
  input7 = false;
  input8 = false;
  Serial.print("delta s3 is:");
  Serial.print(s3);
  Serial.println("\nNow, please input the 4th delta s:\n");
  }
}

if (Serial.available() > 0 && input4 == true){                          //input angle 4
  
  string = Serial.readString();
  s4 = string.toFloat();
   if ( s4<= -36.65 || s4>= 36.65){
    Serial.print("delta s not in range! Please re-input\n");
  }
  else{
  input1 = false;
  input2 = false;
  input3 = false;
  input4 = false;
  input5 = true;
  input6 = false;
  input7 = false;
  input8 = false;
  Serial.print("delta s4 is:");
  Serial.print(s4);
  Serial.println("\nNow, please input the 5th delta s:\n");
  }
}

if (Serial.available() > 0 && input5 == true){                          //input angle 5
  
  string = Serial.readString();
  s5 = string.toFloat();
   if ( s5<= -68.07 || s5>= 68.07){
    Serial.print("delta s not in range! Please re-input\n");
  }
  else{
  input1 = false;
  input2 = false;
  input3 = false;
  input4 = false;
  input5 = false;
  input6 = true;
  input7 = false;
  input8 = false;
  Serial.print("delta s5 is:");
  Serial.print(s5);
  Serial.println("\nNow, please input the 6th delta s:\n");
  }
}

if (Serial.available() > 0 && input6 == true){                          //input angle 6
  
  string = Serial.readString();
  s6 = string.toFloat();
   if ( s6<= -68.07 || s6>= 68.07){
    Serial.print("Angle not in range! Please re-input\n");
  }
  else{
  input1 = false;
  input2 = false;
  input3 = false;
  input4 = false;
  input5 = false;
  input6 = false;
  input7 = true;
  input8 = false;
  Serial.print("delta s6 is:");
  Serial.print(s6);
  Serial.println("\nNow, please input the 7th delta:\n");
  }
}

if (Serial.available() > 0 && input7 == true){                          //input angle 7
  
  string = Serial.readString();
  s7 = string.toFloat();
   if ( s7<= -68.07 || s7>= 68.07){
    Serial.print("Angle not in range! Please re-input\n");
  }
  else{
  input1 = false;
  input2 = false;
  input3 = false;
  input4 = false;
  input5 = false;
  input6 = false;
  input7 = false;
  input8 = true;
  Serial.print("delta s7 is:");
  Serial.print(s7);
  Serial.println("\nNow, please input the 8th delta s:\n");
  }
}

if (Serial.available() > 0 && input8 == true){                          //input angle 8
  
  string = Serial.readString();
  s8 = string.toFloat();
   if ( s8<= -68.07 || s8>= 68.07){
    Serial.print("delta s not in range! Please re-input\n");
  }
  else{
  input1 = false;
  input2 = false;
  input3 = false;
  input4 = false;
  input5 = false;
  input6 = false;
  input7 = false;
  input8 = false;
  ready = true;
  Serial.print("delta s8 is:");
  Serial.print(s8);
  Serial.println("\nInput complete!\n");
  }
}

if (ready == true){
  step1 = (s1 - prev_s1) / (3.1415*d/2048);
  stepper1.moveTo(step1);
  step2 = (s2 - prev_s2) / (3.1415*d/2048);
  stepper2.moveTo(step2);
  step3 = (s3 - prev_s3) / (3.1415*d/2048);
  stepper3.moveTo(step3);
  step4 = (s4 - prev_s4) / (3.1415*d/2048);
  stepper4.moveTo(step4);
  step5 = (s5 - prev_s5) / (3.1415*d/2048);
  stepper5.moveTo(step5);
  step6 = (s6 - prev_s6) / (3.1415*d/2048);
  stepper6.moveTo(step6);
  step7 = (s7 - prev_s7) / (3.1415*d/2048);
  stepper7.moveTo(step7);
  step8 = (s8 - prev_s8) / (3.1415*d/2048);
  stepper8.moveTo(step8);
  

  if (stepper1.distanceToGo() == 0){
    moveFinished = true;
    ready = false;
    Serial.print("\nMovement Complete!\n");

    Serial.print("The steps motor 1 took is: " );
    Serial.print(stepper1.currentPosition());
    Serial.print(", corresponding to a cable length change of ");
    Serial.print(s1);

    Serial.print("\nThe steps motor 2 took is: " );
    Serial.print(stepper2.currentPosition());
    Serial.print(", corresponding to a cable length change of ");
    Serial.print(s2);

    Serial.print("\nThe steps motor 3 took is: " );
    Serial.print(stepper3.currentPosition());
    Serial.print(", corresponding to a cable length change of ");
    Serial.print(s3);

    Serial.print("\nThe steps motor 4 took is: " );
    Serial.print(stepper4.currentPosition());
    Serial.print(", corresponding to a cable length change of ");
    Serial.print(s4);

    Serial.print("\nThe steps motor 5 took is: " );
    Serial.print(stepper5.currentPosition());
    Serial.print(", corresponding to a cable length change of ");
    Serial.print(s5);

    Serial.print("\nThe steps motor 6 took is: " );
    Serial.print(stepper6.currentPosition());
    Serial.print(", corresponding to a cable length change of ");
    Serial.print(s6);

    Serial.print("\nThe steps motor 7 took is: " );
    Serial.print(stepper7.currentPosition());
    Serial.print(", corresponding to a cable length change of ");
    Serial.print(s7);

    Serial.print("\nThe steps motor 8 took is: " );
    Serial.print(stepper8.currentPosition());
    Serial.print(", corresponding to a cable length change of ");
    Serial.print(s8);

    Serial.print("Please type 'reset' to restore the motor to initial state, or type 'newpos' to make the motors step to a new position based on current location\n");
  }

}

if (Serial.available() > 0 && moveFinished == true){
  string = Serial.readStringUntil('\n');
  Serial.print(string);

  if (string == "reset"){
    Serial.print("\nResetting motors!");
    stepper1.moveTo(0);
    stepper2.moveTo(0);
    stepper3.moveTo(0);
    stepper4.moveTo(0);
    stepper5.moveTo(0);
    stepper6.moveTo(0);
    stepper7.moveTo(0);
    stepper8.moveTo(0);
    Serial.print("After resetting, please input a new set of parameters, starting from delta s1\n");
    moveFinished = false;
    input1 = true;
  }

  else if (string == "newpos"){
    prev_s1 = s1;
    prev_s2 = s2;
    prev_s3 = s3;
    prev_s4 = s4;
    prev_s5 = s5;
    prev_s6 = s6;
    prev_s7 = s7;
    prev_s8 = s8;

    moveFinished = false;
    input1 = true;
    Serial.print("Now, please input the 8 delta s of the new position\n");
  }

  else{
    Serial.print("\nWrong input! Please type again\n");
  }
}
//stepper1.run();
stepper2.run();
stepper3.run();
//stepper4.run();
//stepper5.run();
//stepper6.run();
//stepper7.run();
//stepper8.run();
}