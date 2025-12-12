class Platform { 
  PVector pos;  
  PVector size;
  color colour;
  
  Platform(PVector pos, PVector size) {
    this.pos = pos.copy(); //copys over the PVector, just a simple shortcut
    this.size = size.copy();
  }
  
  void update() {
    pos.x = mouseX;     // follow the mouse 
  }
  
  void display() {
    fill(255, 255, 0);
    rect(pos.x, pos.y, size.x, size.y);
  }
  
}
