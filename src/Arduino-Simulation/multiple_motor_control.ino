#include <Stepper.h>

const int buttonDownPin1 = 6;
const int buttonUpPin1 = 7;    //定义控制motor1的前后运动的两个按键引脚（一个按键命令电机正转，一个反转，分别用down和up来命名）

const int buttonDownPin2 = 14;
const int buttonUpPin2 = 15;  //同理，定义控制motor2的前后运动的两个按键引脚

int spr = 360;              //设定motor走360步转一圈
int motspeed = 30;          //设定motor速度为30RPM

Stepper motor1(spr, 2, 3, 4, 5);        //设定motor1占用的四个引脚
Stepper motor2(spr, 16, 17, 18, 19);    //设定motor2占用的四个引脚

int buttonDownState1 = 0;               
int buttonUpState1 = 0;                //这两个变量用于储存控制motor1的两个按键的电平

int buttonDownState2 = 0;
int buttonUpState2 = 0;                //这两个变量用于储存控制motor2的两个按键的电平
void setup() {
  // put your setup code here, to run once:
  pinMode(buttonDownPin1, INPUT);
  pinMode(buttonUpPin1, INPUT);        //设定motor1的俩按键的pinmode
  pinMode(buttonDownPin2, INPUT);
  pinMode(buttonUpPin2, INPUT);        //设定motor2的俩按键的pinmode
  motor1.setSpeed(motspeed);
  motor2.setSpeed(motspeed);           //设定俩motor的速度为motspeed
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
  buttonDownState1 = digitalRead(buttonDownPin1); 
  buttonUpState1 = digitalRead(buttonUpPin1);       //检测控制motor1的俩按键电平状态

  buttonDownState2 = digitalRead(buttonDownPin2); 
  buttonUpState2 = digitalRead(buttonUpPin2);       //检测控制motor2的俩按键电平状态

  if (buttonDownState1 == HIGH) {                   //若电机1收到反转按钮信号，逆时针转动一圈，延迟100ms后停止
    	motor1.step(-spr);
      delay(100); 
  	}
  if (buttonUpState1 == HIGH) {                     //若电机1收到正转按钮信号，顺时针转动一圈，延迟100ms后停止
    	motor1.step(spr);
      delay(100); 
  	}

  if (buttonDownState2 == HIGH) {                   //若电机2收到反转按钮信号，逆时针转动一圈，延迟100ms后停止
    	motor2.step(-spr);
      delay(100); 
  	}
  if (buttonUpState2 == HIGH) {                     //若电机2收到正转按钮信号，顺时针转动一圈，延迟100ms后停止
    	motor2.step(spr);
      delay(100); 
  	}
}

