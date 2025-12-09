Blocks[][] grid;
Platform platform;
int size = 40;

void setup() {
size(960,540);
grid = new Blocks[5][24];
makeGrid(grid);

}

void draw() {
  background(255,255,255);
  drawPlatform();
  drawGrid(grid);
}
//heavily sourced from grid.pde

void drawPlatform() {
  platform = new Platform((mouseX,500),(150,200))
}
void makeGrid(Blocks[][] g) {
  

  float startX = 0;
  float startY = 0;

  // place each ball in its centered position
  for (int r = 0; r < g.length; r++) {
    for (int c = 0; c < g[0].length; c++) {

      // compute the center position of each ball
      float x = startX + c * size + size / 2;
      float y = startY + r * size + size / 2;

      // create the ball
      g[r][c] = new Blocks(new PVector(x, y), size, color(255,0,255));
      
    }
  }
}

void drawGrid(Blocks[][] g) {
  // draw every ball in the grid
  for (int r = 0; r < g.length; r++) {
    for (int c = 0; c < g[0].length; c++) {
      if (g[r][c] != null) {
        g[r][c].display();
      }
    }
  }
}

void collisions() {
}

void keyPressed() {
  if (key == 'A') {
    
  }
}
