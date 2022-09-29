#include<Servo.h>

int trig = 6;   // trig pin
int echo = 7;   // echo pin
int dt   = 1;   // 1 milliseconds
int flip = 0;   // ??
int btmPin = 8; // buttom pin
float fraction_of_speed_of_sound = 29.1; // in microsecond/cm

Servo head_servo;
Servo tail_servo;

//init distance,duration;
void setup() {
  Serial.begin(9600); // serial communication to USB
  
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  pinMode(btmPin, INPUT);
  head_servo.attach(9);
  tail_servo.attach(10);

  // clear state
  digitalWrite(trig, LOW);
}

void loop() {
  if (calc_dis() > 10 || digitalRead(btmPin) == LOW) { // if object is greater than 10 cm
    return; // do not thing, run loop function again
  }
  
  flip = random(0, 2); // random integer, 0 or 1
  if (flip == 0) {
      servoRotate(head_servo); // move head
  }else{
      servoRotate(tail_servo); // move tail
  }
}

void servoRotate(Servo motor) {
    for (int i = 0; i <= 540; i++) {
      motor.write(i);
      delay(1);
    }
    delay(100);
    
    for (int i = 540; i >= 0; i--){
      motor.write(i);
      delay(1);
    }    
    delay(100);
}

//This code is written to calculate the DISTANCE in centermeter 
//  using ULTRASONIC SENSOR
double calc_dis() {
  // send out us wave
  digitalWrite(trig, HIGH);
  delay(dt); // delay for dt milliseconds
  digitalWrite(trig, LOW);

  // read wave travel time in microseconds
  return pulseIn(echo, HIGH) / 2 / fraction_of_speed_of_sound;
}
