#include <Wire.h> //Calling the wire library
#include <LiquidCrystal_I2C.h> //Calling the LiquidCrystal_I2C library

LiquidCrystal_I2C lcd(0x3F,16,2); //Setting the LCD1_602A device address 
 String myString = ""; //Receive the value sent from the serial port

 float x = 0;//Integer x to store led_flash(x)


void setup()
{
  Serial.begin(9600);
  lcd.init();                  // Initialise LCD_1602A
  lcd.backlight();             //Setting the LCD background equal brightness
}
 
void loop()
{
   if (Serial.available() > 0)//If there is data on the serial port
  {
    lcd.clear();
    myString = Serial.readString();//Retrieve String
    x = myString.toFloat();//Convert the string xstr to the number x
  
  }
  lcd.setCursor(0,0); 
            //The first line shows
  lcd.print("x:");     	//output character
  //lcd.setCursor(0,1);			//The second line shows
  lcd.print(x);
}

