import cc.arduino.*;
import org.firmata.*;
import processing.serial.*;
import java.util.*;
import controlP5.*;

ControlP5 cp5;
Arduino arduino;

boolean active = false, initialized = false;
int curValue = 0, pin = 7;
boolean status = false;

void setup() {
  
  size(1024,440, P3D);
  smooth();

  // init interface
  cp5 = new ControlP5(this);
  
  // add interface elements
  cp5.addToggle("active").setPosition(width-60, 20).setSize(40, 20).setValue(active).setLabel("ON / OFF");
  cp5.addScrollableList("serialList").setPosition(width-300, 20).setSize(200, 100).setBarHeight(20).setItemHeight(20).addItems(Arrays.asList(Arduino.list())).setLabel("Serial Source");
  
}

void draw() {
  
  background(0);
  noStroke();
  fill(255);
  
}

void serialList(int n) {
  
  arduino = new Arduino(this, Arduino.list()[n], 57600);  
  
  // init arduino
  arduino.pinMode(pin, Arduino.OUTPUT);
  println("*** initialized");
  
  initialized = true;
  
}

void active(boolean state) {
  
  if(initialized) {
  
    if(state) {
      arduino.digitalWrite(pin, Arduino.HIGH);
    }else {
      arduino.digitalWrite(pin, Arduino.LOW);
    }
    
  }else {
    println("*** arduino not initialized");  
  }
  
}