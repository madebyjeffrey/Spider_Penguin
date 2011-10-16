
import ddf.minim.*;
import processing.opengl.*;

Enemy enemy;
Ship ship;

float timer = 0;

Minim minim;
AudioPlayer player;


ArrayList shots;

void setup() {
  size(800, 600, OPENGL);
  hint(ENABLE_OPENGL_4X_SMOOTH);
  hint(ENABLE_DEPTH_TEST);

  colorMode(RGB, 1.0);
  
  timer = millis();
  
  minim = new Minim(this);
  player = minim.loadFile("Chase Pulse Faster.mp3");
  
  player.play();
  
  enemy = new Enemy(width/4, height/4);  
  ship = new Ship();
}

void draw() {
  background(51);

  // calculate velocity change from impulse
  float newtime = millis();
  float delta = (newtime - timer) / 1000.0; 
  timer = newtime;
  
  ship.update(delta);
  enemy.update(delta);

  enemy.draw();
  ship.draw();
  ship.draw_circle();
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
        ship.impulse = 50;
      break; 
    case DOWN:
        ship.impulse = 0;
      break;
    case LEFT:
        ship.turnLeft = true;
      break;
    case RIGHT:
        ship.turnRight = true;
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
    case LEFT:
        ship.turnLeft = false;
      break;
    case RIGHT:
        ship.turnRight = false;
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

