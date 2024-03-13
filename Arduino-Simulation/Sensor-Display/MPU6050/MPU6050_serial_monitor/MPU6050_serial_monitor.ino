#include <Adafruit_MPU6050.h>
#include <Adafruit_Sensor.h>
#include <Wire.h>
 
Adafruit_MPU6050 mpu;
 
void setup(void) {
	Serial.begin(115200);       //Select baud rate
 
	// Try to initialize!
	if (!mpu.begin()) {
		Serial.println("Failed to find MPU6050 chip");
		while (1) {
		  delay(10);
		}
	}
	Serial.println("MPU6050 Found!");
 
// set accelerometer range to +-8G
	mpu.setAccelerometerRange(MPU6050_RANGE_8_G);
  // This setAccelerometerRange() function sets the measurement range of the accelerometer. The function accepts the following values:
    //MPU6050_RANGE_2_G - for ±2g range (default)
    //MPU6050_RANGE_4_G - for ±4g range
    //MPU6050_RANGE_2_G - ±2g range (default) //MPU6050_RANGE_4_G - Applies to ±4g range
    //MPU6050_RANGE_16_G - for ±16g range
    //The smaller the range, the more sensitive the accelerometer reading will be.

// set gyro range to +- 500 deg/s
	mpu.setGyroRange(MPU6050_RANGE_500_DEG);
 // This setGyroRange() function sets the gyro measurement range. The function accepts the following values:
    //MPU6050_RANGE_250_DEG - for a range of 250 degrees per second (default)
    //MPU6050_RANGE_500_DEG - for a range of 500 degrees per second
    //MPU6050_RANGE_1000_DEG - applies to a range of 1000 degrees per second
    //MPU6050_RANGE_2000_DEG - for a range of 2000 degrees per second
    //Smaller degrees per second ranges result in more sensitive outputs


// set filter bandwidth to 21 Hz
	mpu.setFilterBandwidth(MPU6050_BAND_21_HZ);
 // This setFilterBandwidth() function sets the bandwidth of the digital low-pass filter. The function accepts the following values:
    //MPU6050_BAND_260_HZ - applies to the 260 Hz bandwidth (according to the documentation, this disables the filter)
    //MPU6050_BAND_184_HZ - applies to the 184 Hz bandwidth
    //MPU6050_BAND_94_HZ - applies to 94 Hz bandwidth
    //MPU6050_BAND_44_HZ - for 44 Hz bandwidth
    //MPU6050_BAND_21_HZ - for 21 Hz bandwidth
    //MPU6050_BAND_10_HZ - applies to 10 Hz bandwidth
    //MPU6050_BAND_5_HZ - for 5 Hz bandwidths
    The ///Bandwidth selection allows you to change the cutoff frequency of the low-pass filter to smooth the signal by removing high-frequency noise.

	delay(100);
}
 
void loop() {
	/* Get new sensor events with the readings */
	sensors_event_t a, g, temp;
	mpu.getEvent(&a, &g, &temp);
 
  
	/* Print out the values */
	/*
  Serial.print("Acceleration X: ");
	Serial.print(a.acceleration.x);
	Serial.print(", Y: ");
	Serial.print(a.acceleration.y);
	Serial.print(", Z: ");
	Serial.print(a.acceleration.z);
	Serial.println(" m/s^2");
  */

	Serial.print("Rotation X: ");
	Serial.print(g.gyro.x);
	Serial.print(", Y: ");
	Serial.print(g.gyro.y);
	Serial.print(", Z: ");
	Serial.print(g.gyro.z);
	Serial.println(" rad/s");
 
  /*
	Serial.print("Temperature: ");
	Serial.print(temp.temperature);
	Serial.println(" degC");
 */

 
	Serial.println("");
	delay(500);
}