class Platform { 
  
  PVector size;
  PVector pos; 
  
  Platform(PVector s, PVector p) {
   size = new PVector(s.x,s.y);
   pos = new PVector(p.x,p.y);
  }
  void display() {
  fill(255,255,0);
  rect(mouseX, 500,150,20);
  rect(pos.x,pos.y,size.x,size.y);
  }
}
