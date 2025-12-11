Blocks[][] grid;
Platform platform;
Projectile ball;

boolean playing = true;
color colors[] = {color(255,0,0), color(0,255,0), color(0,0,255)};

void setup() {
  size(960, 540);
  grid = new Blocks[5][6];
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
  if (playing) {
  // Update and display projectile
  ball.move();
  collisionsBlock(ball,grid);
  ball.display();
  }

}

void drawGrid(Blocks[][] g) {
  for (int r = 0; r < g.length; r++) {
    for (int c = 0; c < g[0].length; c++) {
      if (g[r][c] != null) {
        g[r][c].display(); // just draw, DO NOT recreate
      }
    }
  }
}


void makeGrid(Blocks[][] g) {
  int blockWidth = 160;  // rectangle width
  int blockHeight = 40; // rectangle height

  for (int r = 0; r < g.length; r++) {
    for (int c = 0; c < g[0].length; c++) {
      float x = c * blockWidth + blockWidth / 2;
      float y = r * blockHeight + blockHeight / 2;

      color col = colors[int(random(colors.length))];

      g[r][c] = new Blocks(new PVector(x, y), blockWidth, blockHeight, col);
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
void gameOver() {
  if (ball.lives == 0 )
  {
    playing = false;
  }
 else {
   playing = true;
    
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

/**
 * Mouse 2D. 
 * 
 * Moving the mouse changes the position and size of each box. 
 */
 
