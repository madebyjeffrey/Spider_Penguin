
class Ship
{
  PImage ship;
  ArrayList shots;

  float xpos, ypos;
  float r = 30;
  
  float dv = 4;     // delta v per second

  float theta = PI/2;  // PI/2 is up
  
  float circleradius = 150;
  float circleoscillation = 20;
  float circletime = 0;

  boolean goLeft = false;
  boolean goRight = false;
  boolean goForward = false;
  boolean goBackward = false;

  float turnRate = PI;  // how much to turn per second

  Ship(float x, float y)
  {
    ship = loadImage("ship3.png"); // 64x128

    xpos = x;
    ypos = y;
    
    shots = new ArrayList();
  }  
  
  void fire() 
  {
    shots.add(new Shot(xpos+-cos(theta)*r, ypos-sin(theta)*r, cos(theta)*160, sin(theta)*160));
  }
  
  void update(float delta)
  {

    // ship position
    xpos += dv * delta * (goLeft ? -1 : (goRight ? 1 : 0));
    ypos += dv * delta * (goBackward ? -1 : (goForward ? 1 : 0));
    
    if (xpos < 1) xpos = 1;
    if (xpos > (screen._w)) xpos = screen._w;
    
    if (ypos < 2) ypos = 2;
    if (ypos > 4.5) ypos = 4.5;


    // shots
    
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
    
    // circle
    
    circletime += delta / 10.0; // half time rate
    if (circletime > 1.0) circletime -= 1;

  }
  
  void draw()
  {
    pushMatrix();
   
     println("ship("+xpos+", " + ypos + ")");

    translate(xpos, ypos);
    
//    scale(0.5);
//    rotate(theta + PI/2);
    
  //  image(ship, -ship.width/2, -ship.height/2);
    scale(1/64.0);
    rotate(PI);
  
    image(ship, 0, 0);
    
   
    popMatrix(); 
  }
  
  void draw_circle()
  {
    pushMatrix();
   
    translate(xpos, ypos);

    noFill();
  
    float cr = circleradius + circleoscillation * sin(circletime * 2*PI);
//  println(circletime);
    stroke(1, 1, 1);
    arc(0, 0, cr*2, cr*2, 0, 2*PI);
    
   
    popMatrix(); 
  }
}
