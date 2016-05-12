#include <AccelStepper.h>
#include <AFMotor.h>

/*
 * STEPPER
 */

AF_Stepper motor(48, 2);

// you can change these to DOUBLE or INTERLEAVE or MICROSTEP!
void forwardstep() {  
  motor.onestep(FORWARD, DOUBLE);
}

void backwardstep() {  
  motor.onestep(BACKWARD, DOUBLE);
}

AccelStepper stepper(forwardstep, backwardstep);

int motorValRaw;

/*
 * ACC SETTINGS
 */

#define accPinX A8
#define accPinY A9
#define accPinZ A10

void setup() {

  // init serial com
  Serial.begin(9600);

  // init stepper
  stepper.setMaxSpeed(50);  
  stepper.setAcceleration(50);
  stepper.setSpeed(50);
  
}

void loop() {

  while (Serial.available()) { // If data is available to read,
    
    motorValRaw = Serial.read(); // read it and store it in val

    int newPos = map(motorValRaw, 0, 100, 0, 100);
    stepper.moveTo(newPos);
    
  }
    
  /*
   * STEPPER
   */
  
  stepper.run();

  /*
   * ACCECLORATOR
   */

  //acc.update();

  // calibtrate
  //Serial.println( acc.getX() );
 
}


