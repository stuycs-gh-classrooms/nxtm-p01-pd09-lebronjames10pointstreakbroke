class Blocks {
  PVector center;
  int w, h;
  color colour;

  Blocks(PVector c, int w, int h, color col) {
    center = c.copy();
    this.w = w;
    this.h = h;
    colour = col;
  }

  void display() {
    fill(colour);
    rectMode(CENTER); // center-based drawing
    rect(center.x, center.y, w, h);
  }
}
