import processing.serial.*;
import processing.opengl.*;
import toxi.math.waves.*;
import controlP5.*;
import java.util.*;

ControlP5 cp5;
Serial serial;


ArrayList<Wave> wl;
boolean active = false, initialized = false;
int mult_factor = 10;

void setup() {
  
  size(1024,440, P3D);
  
  smooth();
  frameRate(40);
  textFont(createFont("SansSerif", 10));

  // init wave
  wl = new ArrayList<Wave>();
  
  // add elements
  wl.add(new Wave(new FMSineWave(0, .02, mult_factor, 0)));
  wl.add(new Wave(new FMSawtoothWave(0, .02, mult_factor, 0)));
  wl.add(new Wave(new FMSquareWave(0, .02, mult_factor, 0)));
  wl.add(new Wave(new FMHarmonicSquareWave(0, .02, mult_factor, 0)));
  wl.add(new Wave(new FMTriangleWave(0, .02, mult_factor, 0)));
  
  // init interface
  cp5 = new ControlP5(this);
  
  // add interface elements
  cp5.addSlider("freq").setPosition(20,40).setRange(.01, .1).setValue(.02).setLabel("Frequency");
  cp5.addButtonBar("bar").setPosition(20, height-60).setSize(200, 20).addItems(split("0 1 2 3 4"," ")).setLabel("Curves");
  cp5.addToggle("active").setPosition(width-60, 20).setSize(40, 20).setValue(active).setLabel("ON / OFF");
  cp5.addScrollableList("serialList").setPosition(width-300, 20).setSize(200, 100).setBarHeight(20).setItemHeight(20).addItems(Arrays.asList(Serial.list())).setLabel("Serial Source");

}

void draw() {
  
  background(0);
  
  for(Wave w : wl) {
  
    w.update();    
    w.draw();
    
    // send to arduino
    if(w.status) {
      if(active) {
        sendSerial(w.getConvertedValue());
      }else {
        sendSerial(0);
      }
    }
     
  }
  
}

void serialList(int n) {
  String portName = Serial.list()[n];
  
  serial = new Serial(this, portName, 9600);
  serial.bufferUntil('\n');
  
  initialized = true;
}

void sendSerial(int v) {
  if(initialized) {
    serial.write(v);
  }
}

void freq(float v) {
  for(Wave w : wl) {
    w.wave.frequency = v;
  }
}

void bar(int n) {
  for(int i = 0; i < wl.size(); i++) {
    wl.get(i).status = false;
  }
  wl.get(n).status = true;
}

void motor() {
  active = !active;
  println("send signal: "+active);
}