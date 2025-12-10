class Projectile { 
  PVector center;   
  PVector velocity; 
  int size;
  color colour;
  
  Projectile(PVector c, PVector v, int s, color col) {
    center = c.copy();
    velocity = v.copy();
    size = s;
    colour = col;
  }
  
  void display() {
    fill(colour);
    circle(center.x, center.y, size);
  }
  
  void move() {
    center.add(velocity);  // move the ball
    
    // bounce off left/right walls
    if (center.x < size/2 || center.x > width - size/2) {
      velocity.x *= -1;
    }
    
    // bounce off top wall
    if (center.y < size/2) {
      velocity.y *= -1;
    }
    
    // bounce off bottom (reset)
    if (center.y > height - size/2) {
      // reset ball to center
      center = new PVector(width/2, 300);
      velocity = new PVector(5, -5);
    }
    
    // bounce off platform
    if (center.y + size/2 >= platform.pos.y && 
        center.y - size/2 <= platform.pos.y + platform.size.y &&
        center.x + size/2 >= platform.pos.x &&
        center.x - size/2 <= platform.pos.x + platform.size.x) {
      velocity.y *= -1;

      
      float hitPos = (center.x - platform.pos.x) / platform.size.x - 0.5;
      velocity.x += hitPos * 5;  // adjust x velocity
    }
  }
}
