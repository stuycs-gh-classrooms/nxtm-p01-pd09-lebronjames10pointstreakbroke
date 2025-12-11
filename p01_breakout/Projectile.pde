class Projectile { 
  PVector center;   
  PVector velocity; 
  int size;
  int lives;
  color colour;
  
  Projectile(PVector c, PVector v, int s, color col, int l) {
    center = c.copy();
    velocity = v.copy();
    size = s;
    colour = col;
    lives = l;
  }
  
  void display() {
    fill(colour);
    circle(center.x, center.y, size);
  }
  
  void move() {
    if (lives != 0)
    {
    center.add(velocity);  // move the ball
    
    // bounce off left/right walls
    if (center.x < size/2 || center.x > width - size/2) {
      velocity.x *= -1;
    }
    
    //bounce off top
   
  
    if (center.y == 0) {
      velocity.y *= -1;
      
    }
    
    // bounce off bottom (reset)
    if (center.y > height - size/2) {
      // reset ball to center (-1 life)
      center = new PVector(width/2, 300);
      velocity = new PVector(5, -5);
      lives--;
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
  boolean collisionCheck(Blocks other) {
  
  float dx = abs(center.x - other.center.x);
  float dy = abs(center.y - other.center.y);

 
  if (dx <= other.w/2 + size/2 && dy <= other.h/2 + size/2) {
    return true;
  } 
  return false;
}

}
