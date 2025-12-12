class Projectile { 
  PVector center;   
  PVector velocity; 
  int size;
  int lives;
  color colour;
  
  Projectile(PVector c, PVector v, int s, color col, int l) {
    center = c.copy(); //copying over
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
    if (lives != 0) {
      center.add(velocity);  // move the ball
    
      // bounce off left/right walls
      if (center.x < size/2 || center.x > width - size/2) {
        velocity.x *= -1;
      }
    
      //bounce off top
      if (center.y < size/2) {
        velocity.y *= -1;
      }
    
      // lose a life if ball goes off bottom (don't bounce)
      if (center.y > height + size/2) {
        // reset ball to center (-1 life)
        lives--;
        if (lives <= 0) {
          playing = false;   // GAME OVER
          return;
        }
        center = new PVector(width/2, 300);
        velocity = new PVector(5, -5);
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
