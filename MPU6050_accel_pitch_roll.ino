/*
    MPU6050 Triple Axis Gyroscope & Accelerometer. Pitch & Roll Accelerometer Example.
    Read more: http://www.jarzebski.pl/arduino/czujniki-i-sensory/3-osiowy-zyroskop-i-akcelerometr-mpu6050.html
    GIT: https://github.com/jarzebski/Arduino-MPU6050
    Web: http://www.jarzebski.pl
    (c) 2014 by Korneliusz Jarzebski
*/

#include <Wire.h>
#include <MPU6050.h>

const int CompAddress=0x1E;

int x, y , z;
MPU6050 mpu;

void setup() 
{
  Serial.begin(9600);

  Serial.println("Initialize MPU6050");

  while(!mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G))
  {
    Serial.println("Could not find a valid MPU6050 sensor, check wiring!");
    delay(500);
  }
  
  //Start-up Compass
    Wire.beginTransmission(CompAddress);
    Wire.write(0x02); //select mode register
    Wire.write(0x00); //Continuous Measurement Mode
    Wire.endTransmission(); //  Free's I2C Lines
}

void loop()
{
  // Read normalized values 
  Vector normAccel = mpu.readNormalizeAccel();
  getCompassData();

  // Calculate Pitch & Roll
  int pitch = -(atan2(normAccel.XAxis, sqrt(normAccel.YAxis*normAccel.YAxis + normAccel.ZAxis*normAccel.ZAxis))*180.0)/M_PI;
  int roll = (atan2(normAccel.YAxis, normAccel.ZAxis)*180.0)/M_PI;
  int yaw = atan2(y, x)/M_PI * 180;
  
  //float Mx = x * cos(pitch)+z * sin(pitch);
  //float My = x * sin(roll) * sin(pitch)+y * cos(roll)-z*sin(roll)*cos(pitch);
  //float yaw = atan2(My,Mx)/M_PI * 180;
  
  

  // Output
  //Serial.print(" Pitch = ");
  
  //Serial.print(" Roll = ");
  //Serial.print(" Yaw = ");
  //Serial.print(yaw);
  //Serial.print(" , ");
  Serial.print(pitch);
  Serial.print(roll);
  Serial.print(yaw);
  delay(1000);
}

void getCompassData()
{
Wire.beginTransmission(CompAddress);
Wire.write(0x03); // Write to the MSB register to start data stream
Wire.endTransmission(false); //Free up I2C communication Line

Wire.requestFrom(CompAddress, 6, true); //Request(Address, #bytes, stop_flag)

if(6<=Wire.available())
  {
  x = Wire.read()<<8|Wire.read(); //2 Bytes for X Magnetometer (High and Low)
  z = Wire.read()<<8|Wire.read(); //2 Bytes for Z Magnetometer (High and Low)
  y = Wire.read()<<8|Wire.read(); //2 Bytes for Y Magnetometer (High and Low)
  }
}
