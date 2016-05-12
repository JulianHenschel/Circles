class Wave {
  
  boolean status = false;
  int id, amp = 20;
  float value;
  
  AbstractWave wave;
  
  Wave(AbstractWave w) {

    this.wave = w;
    this.id = wl.size();
    
  }

  void draw() {
    
    this.value = this.wave.update();
    
    stroke(255);
    strokeWeight(1);
    noFill();
    
    if(this.status) {
      this.wave.push();
              
        pushMatrix();
        translate(width/2,height/2);
          beginShape();

          for(int x = -width/2; x < width/2; x += width/100) {
            vertex(x, (this.wave.update() * this.amp));
          }
          
          endShape();
        popMatrix();
      this.wave.pop();  

    }
  }
  
  int getConvertedValue() {
    return parseInt(map(this.value, -mult_factor, mult_factor, 0, 100));
  }
  
}