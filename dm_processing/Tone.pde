class Tone {
  
  int mode;
  int millis;
  
  Tone(int m, int mi) {
    
    this.mode = m;
    
    if(tl.size() > 0) {
      
      Tone prevT = (Tone)tl.get(tl.size()-1);
      this.millis = mi+prevT.millis;
      
    }
            
  }
  
  void update() {
    
    
    
  }
  
  void check() {
  
    
    
  }

}