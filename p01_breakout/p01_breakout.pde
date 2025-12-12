Blocks[][] grid;
Platform platform;
Projectile ball;

boolean playing = true;
boolean paused = false;
int score = 0;
color colors[] = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)};



void setup() {

  size(960, 540);
  grid = new Blocks[5][6];
  makeGrid(grid);
  platform = new Platform(new PVector(width/2, 500), new PVector(150, 20));
  // create the ball

  ball = new Projectile(new PVector(width/2, 300), new PVector(5, -5), 20, color(0, 0, 255), 3);
}

void draw() {

  background(255);
  

  // update platform
  platform.display();
  platform.update();
  // update and display grid
  drawGrid(grid);

  fill(0);
  textAlign(LEFT, TOP);
  textSize(24);
  text("Lives: " + ball.lives, 20, 20);

  textAlign(RIGHT, TOP);
  text("Score: " + score, width - 20, 20);


  // CHECK FOR WIN CONDITION
  if (score >= 10000) {
    fill(0, 200, 0);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("YOU WIN!", width/2, height/2 - 30);
    textSize(32);
    text("ULTIMATE BLOCK BUSTER PRO", width/2, height/2 + 20);
    textSize(20);
    text("Press R to play again", width/2, height/2 + 60);
    return;  // stop the game
  }


  if (paused) {
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(48);
    text("PAUSED", width/2, height/2);
    textSize(20);
    text("Press SPACE to resume", width/2, height/2 + 50);
    return;   // stop updating game
  }


  if (!playing) {
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(64);
    text("YOU LOSE!", width/2, height/2);
  
    return;   // stop drawing anything else
  }

  if (playing) {
    // update and display projectile
    ball.move();
    collisionsBlock(ball, grid);
    collisionPlatform(ball, platform);  // CHECK PLATFORM COLLISION
    ball.display();

    checkAllBlocksDestroyed();
  }
}



void drawGrid(Blocks[][] g) {
  for (int r = 0; r < g.length; r++) {
    for (int c = 0; c < g[0].length; c++) {
      if (g[r][c] != null) {
        g[r][c].display(); //draw the grid
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
        g[r][c] = null; // remove the balls
        score += 50;
        ball.velocity.y *= -1;
        return;                  // stop checking after hit
      }
    }
  }
}


void collisionPlatform(Projectile b, Platform p) {
  // check if ball overlaps with platform
  float ballBottom = b.center.y + b.size/2;
  float platformTop = p.pos.y - p.size.y/2;

  // ball is at platform height and overlapping horizontally
  if (ballBottom >= platformTop &&
    b.center.x >= p.pos.x - p.size.x/2 &&
    b.center.x <= p.pos.x + p.size.x/2 &&
     b.center.y < height - p.size.y &&
    b.velocity.y > 0) {  // only bounce if moving downward

    // always bounce upward
    b.velocity.y = -abs(b.velocity.y);

    // adjust x velocity based on where it hits
    float hitPos = (b.center.x - p.pos.x) / (p.size.x/2);
    b.velocity.x += hitPos * 2;

    // ensure ball has some horizontal movement (not straight up/down)
    if (abs(b.velocity.x) < 2) {
      b.velocity.x = (b.velocity.x >= 0) ? 2 : -2;
    }

    // speed up the ball slightly (with a max speed limit)
    float maxSpeed = 12;  // maximum speed in each direction

    // increase speed by 5% but cap it
    if (abs(b.velocity.x) < maxSpeed) {
      b.velocity.x *= 1.05;
    }
    if (abs(b.velocity.y) < maxSpeed) {
      b.velocity.y *= 1.05;
    }
  }
}

void gameOver() {
  if (ball.lives == 0) {
    playing = false;
  } else {
    playing = true;
  }
}

void resetGame() {
  makeGrid(grid);  // rebuild blocks
  platform = new Platform(new PVector(width/2, 500), new PVector(150, 20));
  ball = new Projectile(new PVector(width/2, 300), new PVector(5, -5), 20, color(0, 0, 255), 3);
  playing = true;
  paused = false;
  score = 0;  // reset score
}

void checkAllBlocksDestroyed() {
  boolean anyBlocksLeft = false;

  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[0].length; c++) {
      if (grid[r][c] != null) { //if theres a block
        anyBlocksLeft = true; //then there are blocks left
        break; //break out the loop
      }
    }
    if (anyBlocksLeft) break; //and if there are any blocks left break out the loop.
  }

  // if no blocks left, create new set of blocks
  if (!anyBlocksLeft) {
    makeGrid(grid);
    // reset ball to center
    ball.center = new PVector(width/2, 300);
    ball.velocity = new PVector(5, -5);
  }
}

void keyPressed() {
  if (key == ' ') {
    if (playing) {  // only allow pause if game is still going
      paused = !paused;
    }
  }
  // R: reset the game
  if (key == 'r' || key == 'R') {
    resetGame();
  }
}
