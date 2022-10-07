/**
   Name: Zhihao Deng
   Last modify: Oct. 5
   A college project
*/

#include<Servo.h>

short MEH[][8] = {
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 1, 1, 0, 0, 1, 1, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 1, 1, 1, 1, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0}
};


short SMILING[][8] = {
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 1, 1, 0, 0, 1, 1, 0},
  {0, 1, 1, 0, 0, 1, 1, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 1, 0, 0, 1, 0, 0},
  {0, 0, 0, 1, 1, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0}
};

short PLAYFUL[][8] = {
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 1, 0, 0, 0, 0, 1, 0},
  {0, 0, 1, 0, 0, 1, 0, 0},
  {0, 1, 0, 0, 0, 0, 1, 0},
  {0, 0, 0, 0, 0, 0, 0, 0},
  {0, 0, 1, 1, 1, 1, 0, 0},
  {0, 0, 0, 1, 1, 0, 0, 0},
  {0, 0, 0, 0, 0, 0, 0, 0}
};

short ALL_ON[][8] = {
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1},
  {1, 1, 1, 1, 1, 1, 1, 1}
};

/**
   specify Arduino pin to control LED dot matrix, detail matrix pin configuration refer to
   @func set8x8DotMatrix

   Setup
   ---
   Use jumpwire connect dot matrix from pin A to P. Use the Pin configuration look-up table in
   @func set8x8DotMatrix to identify functionality of each pin, plug them into the Arduino board.
   Save Adruino pin number as follow
*/
int rowPins[] = {
  // Arduino pin controls matrix row 0 to 7
  // but since we don't need row 0 and 7, just replace with -1
  -1, 15, 9, 13, 2, 8, 3, -1   
};
int colPins[] = {
  // control from column 0 to 7
  // but since we don't need 0 and 7, just replace with -1
  -1, 4, 5, 11, 7, 12, 16, -1
};

int echo = 18;
int trig = 19;
double FRAC_OF_SOUND_SPEED = 29.1; // in microsecond/cm
double distance = 9999;
int HEAD_SERVO_PIN = 6;
int btm = 17;

Servo headServo;
//Servo tail_servo;

void setup() {
  Serial.begin(9600); // serial communication to USB

  //  set pin mode
  for (int i = 1; i < 7; ++i) {
    pinMode(rowPins[i], OUTPUT);
    pinMode(colPins[i], OUTPUT);
    digitalWrite(rowPins[i], LOW);
    digitalWrite(colPins[i], LOW);
  }
  pinMode(trig, OUTPUT);
  pinMode(echo, INPUT);
  pinMode(btm, INPUT);
  headServo.attach(HEAD_SERVO_PIN);
}
void loop() {
  if (digitalRead(btm)) {
    trigSensor();
    distance = readSensor();
  }

  if (distance < 10) {
    set8x8DotMatrix(PLAYFUL, 40, 20);
  } else if (distance < 30) {
    set8x8DotMatrix(SMILING, 40, 20);
  } else {
    set8x8DotMatrix(MEH, 40, 20);
  }

  headServo.write(random(0, 320));

  Serial.println(analogRead(btm)); // view distance in Tools -> Serial Monitor
}



/**
   control logic for 1588BS LED dot matrix

   Intro.
   ---
   1588BS is eight by eight LED dot matrix display ("BS" indicat it's common anode),
   16 pins on the back of the matrix controls these LEDs. Each pin is either the common
   ground of a column of LEDs, or the common source of a row of LEDs. Thus, we need two
   pins to control one LED, one of the pin specify its row, the other pin specify its
   column.

   Identify pins configuration
   ---
   We identify the positive oriantation as follows: metal pins pointing downward, LEDs
   facing upward, the side with text or small bump facing toward us.
   With positive oriantation, mark row of pins closer to you as A to H from left to right,
   mark row of pins away from you as I to P from right to left. As shown below:

    P O N M L K J I
   -----------------
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   |O O O O O O O O|
   -------u-1588BS--
    A B C D E F G H

   Follwing the coding convension, identify upper left corner as row 0 column 0, lower
   right corner as row 7 column 7. Pin configuration look-up table (LUT) shown below:
   Common VCC of row 0 is pin I; Common GND of column 0 is pin M;
   Common VCC of row 1 is pin N; Common GND of column 1 is pin C;
   Common VCC of row 2 is pin H; Common GND of column 2 is pin D;
   Common VCC of row 3 is pin L; Common GND of column 3 is pin J;
   Common VCC of row 4 is pin A; Common GND of column 4 is pin F;
   Common VCC of row 5 is pin G; Common GND of column 5 is pin K;
   Common VCC of row 6 is pin B; Common GND of column 6 is pin O;
   Common VCC of row 7 is pin E; Common GND of column 7 is pin P;

   Control logic
   ---
   1588BS doesn't have internal memory to "save" LEDs' state, thus
   we need to apply multiplexing technique. Multiplexing is the technique
   employed to operate LED matrices. By multiplexing, only one row
   of the LED matrix is activated at any time. [1] By flashing leds
   fast in sequence, human proceed as continuous pixel arts.

  [1] (2013, July 11). https://docs.broadcom.com/doc/AV02-3697EN. Docs.
        https://docs.broadcom.com/doc/AV02-3697EN#:~:text=Multiplexing%
        20is%20the%20technique%20employed,tied%20to%20a%20single%20row.
   ---
   @param value      an 8 by 8 2D array. 0 is OFF, anything else is ON
   @param frameRate  frame per second
   @param frameCount amount of frame will be display
*/
bool set8x8DotMatrix(short value[8][8], int frameRate, int frameCount) {
  int dTime = (int)(1000 / 8 / (double)frameRate); // lit up time per line in microsecond
  while (frameCount > 0) {
    for (int y = 1; y < 7; ++y) {

      // set up which led to turn on
      // turn off the led by provides 5V to cathode
      for (int x = 1; x < 7; ++x) {
        digitalWrite(colPins[x], value[y][x] ^ 0b1);
      }

      // provide power to entire row
      digitalWrite(rowPins[y], HIGH);
      delay(dTime); // lit up time

      // reset row
      digitalWrite(rowPins[y], LOW);
    }
    --frameCount;
  }
}

void trigSensor() {
  digitalWrite(trig, HIGH);
}
double readSensor() {
  digitalWrite(trig, LOW);

  // read wave travel time in microseconds
  return pulseIn(echo, HIGH) / 2 / FRAC_OF_SOUND_SPEED;;
}
