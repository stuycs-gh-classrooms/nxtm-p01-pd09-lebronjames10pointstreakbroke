class Blocks {
  int size;
  color colour;
  PVector center;
  boolean isDestroyed;
  
  Blocks(PVector p, int s,color c)
  {
    size = s;
    colour = c;
    center = new PVector(p.x,p.y);
  }
  
  void display() {
    fill(colour);
    circle(center.x,center.y, size);
  }
  
 
  void destroy() {
  }
}
