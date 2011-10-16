
import ddf.minim.*;
import processing.opengl.*;

PImage ship;
PImage satBody;
PImage satWings;
float satTheta;

float r = 30;
float xpos, ypos;
float xvel, yvel;
float mass = 100;
float impulse = 0;

float theta = PI/2;  // PI/2 is up

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

class Shot
{
  public float _sx, _sy, _svx, _svy;    
  
  public Shot(float sx, float sy, float svx, float svy) 
  {
    _sx = sx;
    _sy = sy;
    _svx = svx;
    _svy = svy;
  }  
  
  public void update(float delta)
  {
     _sx -= _svx * (delta / 1000.0);
     _sy -= _svy * (delta / 1000.0);
  }
  
  public void draw()
  {
     arc(_sx, _sy, 5, 5, 0, 2*PI); 
  }
  
  public boolean valid()
  {
     return !((_sx < 0 || _sx > width) || (_sy < 0 || _sy > height));
  }  
   
     

}

ArrayList shots;

void setup() {
  size(640, 480, OPENGL);
  hint(ENABLE_OPENGL_4X_SMOOTH);
  
  ship = loadImage("ship3.png");
  xpos = width/2;
  ypos = height/2;

  colorMode(RGB, 1.0);
  
  timer = millis();
  
  satBody = loadImage("satelliteBody.png");
  satWings = loadImage("satelliteWings.png");
  
//  satBody = loadShape("satelliteBody.svg");
//  satWings = loadShape("satelliteWings.svg");  
  
  satTheta = 0.0;
//    satWings.rotateX(PI/16);
//  shot = false;
  shots = new ArrayList();
  
  minim = new Minim(this);
  player = minim.loadFile("Chase Pulse Faster2.mp3");
  
  player.play();
}

void draw() {
  background(51);

  // calculate velocity change from impulse
  float newtime = millis();
  float delta = newtime - timer;
  timer = newtime;
  
  float deltaV = impulse / mass;
  xvel += cos(theta) * deltaV;  // metres / second
  yvel += sin(theta) * deltaV;
  
  xpos -= xvel * (delta / 1000.0);
  ypos -= yvel * (delta / 1000.0);
  
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
  
  satTheta += PI * delta/1000.0;
  
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
  translate(-satBody.width/2, 0);
  scale(0.5);
  
  //image(ship, 0, 0);
  
  
  //smooth();
  image(satBody, 0, 0, 80, 80);
  rotateY(satTheta);
  image(satWings, 0, 0, 80, 80);
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

