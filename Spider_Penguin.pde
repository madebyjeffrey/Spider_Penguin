
import ddf.minim.*;
import processing.opengl.*;

Enemy enemy;
Ship ship;

float r = 30;

int rotated = 0;
float timer = 0;

float circleradius = 150;
float circleoscillation = 20;
float circletime = 0;

boolean turnLeft = false;
boolean turnRight = false;
float turnRate = PI;  // how much to turn per second

Minim minim;
AudioPlayer player;


ArrayList shots;

void setup() {
  size(640, 480, OPENGL);
  hint(ENABLE_OPENGL_4X_SMOOTH);
//  hint(DISABLE_DEPTH_TEST);
  


  colorMode(RGB, 1.0);
  
  timer = millis();
  
  shots = new ArrayList();
  
  minim = new Minim(this);
  player = minim.loadFile("Chase Pulse Faster.mp3");
  
  player.play();
  
  gl = ((PGraphicsOpenGL)g).gl;
  
  enemy = new Enemy();  
}

void draw() {
  background(51);

  // calculate velocity change from impulse
  float newtime = millis();
  float delta = newtime - timer;
  timer = newtime;
  
  
  for (int i = 0; i < shots.size(); i++)
  {
    Shot shot = (Shot) shots.get(i);
    
    shot.update(delta);
    shot.draw();
    
    if (!shot.valid())
     {
       shots.remove(i);
       i--;
       continue;
     }
  }  
  
  enemy.update(delta/1000.0);

  // turn ship
  if (turnLeft ^ turnRight)
  {
     theta += (turnLeft ? -1 : 1) * turnRate * delta/1000.0;
  }

 // draw ship
  translate(xpos, ypos);
  
  noFill();
   // add engine!
  rotate(theta - PI/2);
  fill(0);
  stroke(1);
 /* triangle(0, -r, 
        cos(-PI/6)*r/2, -sin(-PI/6)*r/2, 
        cos(7*PI/6)*r/2, -sin(7*PI/6)*r/2);
*/
  noFill();
  
  circletime += delta / 10000; // half time rate
  if (circletime > 1.0) circletime -= 1;
  float cr = circleradius + circleoscillation * sin(circletime * 2*PI);
//  println(circletime);
  stroke(1, 1, 1);
  arc(0, 0, cr*2, cr*2, 0, 2*PI);
  
//  translate(-16, -32);

//  scale(0.5);

  enemy.draw();
  
}


void keyPressed() {
  int keyIndex = -1;

  if (key == ' ')
  {
    shots.add(new Shot(xpos+-cos(theta)*r, ypos-sin(theta)*r, cos(theta)*80, sin(theta)*80));
/*    if (!shot)  {
        shot = true;
        
        sx = xpos;
        sy = ypos;
        
        svx = cos(theta)*80; // 20 m/s
        svy = sin(theta)*80;
    }*/
  }

  if (key == CODED)
  {
    switch (keyCode)
    {
    case UP: 
//        ypos -= drag;
      impulse = 50;
      break; 
    case DOWN:
//      ypos += drag;
      impulse = 0;
      break;
    case LEFT:
//        theta -= PI/16;
        turnLeft = true;
      break;
    case RIGHT:
//        theta += PI/16;
        turnRight = true;
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
/*    case UP: 
//        ypos -= drag;
      impulse = 50;
      break; 
    case DOWN:
//      ypos += drag;
      impulse = 0;
      break;  */
    case LEFT:
//        theta -= PI/16;
        turnLeft = false;
      break;
    case RIGHT:
//        theta += PI/16;
        turnRight = false;
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

