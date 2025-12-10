Blocks[][] grid;
Platform platform;
Projectile ball;
int size = 40;



void setup() {
  size(960, 540);
  grid = new Blocks[5][24];
  makeGrid(grid);
  platform = new Platform(new PVector(width/2, 500), new PVector(150, 20));
   // Create the ball
  ball = new Projectile(new PVector(width/2, 300), new PVector(5, -5), 20, color(0, 0, 255), 3);
}

void draw() {
  background(255);

  // Update platform
  platform.display();
  platform.update();

  // Update and display grid
  drawGrid(grid);

  // Update and display projectile
  ball.move();
  ball.display();
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

void collisionsBlock(Projectile b, Blocks[][] g) {
    // check each grid ball
  for (int r = 0; r < g.length; r++) {
    for (int c = 0; c < g[0].length; c++) {

      Blocks d = g[r][c];

      // if projectile hits a ball
      if (d != null && b.collisionCheck(d)) {
        g[r][c] = null;          // remove the ball
        ball.velocity.x *= -1;
        ball.velocity.y *= -1; // reset projectile
        return;                  // stop checking after hit
      }
    }
  }
}

void keyPressed() {
  /* SCRAPPED (for now)
  if (key == 'A' || key == 'a') {
    platform.pos.x -= 10;  // move left
  } else if (key == 'D' || key == 'd') {
    platform.pos.x += 10;  // move right
  }
  */
}
