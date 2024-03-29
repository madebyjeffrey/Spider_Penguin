
import ddf.minim.*;
import processing.opengl.*;

Enemy enemy;
Ship ship;

float timer = 0;

Minim minim;
AudioPlayer player;

GameScreen screen;

float frames;
float time;
float mean_frames;

void setup() {
  size(800, 600, OPENGL);
  hint(ENABLE_OPENGL_4X_SMOOTH);
  hint(ENABLE_DEPTH_TEST);

  colorMode(RGB, 1.0);

  timer = millis();

  minim = new Minim(this);
  player = minim.loadFile("Chase Pulse Faster.mp3");

  player.play();

  // game screen is 12 x 64
  screen = newGame(12, 64, 48, 48);

  // ship starts at 5.5x2
  ship = new Ship(5.5, 2);
  
  enemy = new Enemy(4.5, 4.5);  
//  ship = new Ship();

  frames = 0;
  time = millis()/1000.0;
  mean_frames = 0;
}

void draw() {
  float frametime = millis();
  
  background(51);

  // calculate velocity change from impulse
  float newtime = millis();
  float delta = (newtime - timer) / 1000.0; 
  timer = newtime;

  ship.update(delta);
  enemy.update(delta);
  screen.update(delta);
  


  translate(0, height);
  scale(1.0, -1.0);

  screen.drawGrid();
  screen.setMatrix();
  ship.draw();
  
  enemy.draw();
  

  screen.drawText("fps: " + nf(frameRate, 3, 1), 0, screen.bottom + 1);

  float frametime2 = millis() - frametime;

  
  mean_frames = (mean_frames * frames + frametime2) / (frames + 1);
  
  frames++;  
  println("Length of Frame in ms: " + nf(frametime2 - frametime, 0, 2));
}


void keyPressed() {
  int keyIndex = -1;

  if (key == ' ')
  {
    ship.fire();
  }

  if (key == CODED)
  {
    switch (keyCode)
    {
    case UP: 
      ship.goForward = true;
      break; 
    case DOWN:
      ship.goBackward = true;
      break;
    case LEFT:
      ship.goLeft = true;
      break;
    case RIGHT:
      ship.goRight = true;
      break;
    }
  }
}

void keyReleased() 
{
  if (key == CODED)
  {
    switch (keyCode)
    {
    case UP: 
      ship.goForward = false;
      break; 
    case DOWN:
      ship.goBackward = false;
      break;
    case LEFT:
      ship.goLeft = false;
      break;
    case RIGHT:
      ship.goRight = false;
      break;
    }
  }
}

void stop()
{
  player.close();
  minim.stop();

  super.stop();
}

