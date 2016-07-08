import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;
import java.util.*;
import controlP5.*;

ControlP5 cp5;
Arduino arduino;

ArrayList<Tone> tl;
boolean active = false, initialized = false;
int curValue = 0, valvePin = 7, LEDpin = 8, startTime = 0;

void setup() {
  
  size(1024,440, P3D);
  smooth();
  
  // init arraylist
  tl = new ArrayList<Tone>();
  
  for(int i = 0; i < 20; i++) {
    tl.add(new Tone(i%2,(int)random(1000,5000)));
  }

  // init interface
  cp5 = new ControlP5(this);
  
  cp5.addToggle("active").setPosition(width-60, 20).setSize(40, 20).setValue(active).setLabel("ON / OFF");
  cp5.addScrollableList("serialList").setPosition(width-300, 20).setSize(200, 100).setBarHeight(20).setItemHeight(20).addItems(Arrays.asList(Arduino.list())).setLabel("Arduino Port");
  
}

void draw() {
  
  background(0);
  noStroke();
  fill(255);
  
  for(Tone t : tl) {
    
    t.update();
    
  }
    
}

int getMillis() {
  
  return millis()-startTime;
  
}

void serialList(int n) {
  
  arduino = new Arduino(this, Arduino.list()[n], 57600);  
  
  // init arduino
  arduino.pinMode(valvePin, Arduino.OUTPUT);
  arduino.digitalWrite(valvePin, Arduino.LOW);
  
  initialized = true;
  
  println("*** initialized");
  
}

void active(boolean state) {
  
  if(initialized) {
  
    if(state) {
      arduino.digitalWrite(valvePin, Arduino.HIGH);
      arduino.digitalWrite(LEDpin, Arduino.HIGH);
    }else {
      arduino.digitalWrite(valvePin, Arduino.LOW);
      arduino.digitalWrite(LEDpin, Arduino.LOW);
    }
    
  }else {
    println("*** arduino not initialized");
  }
  
}