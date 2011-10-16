
class Ship
{
  PImage ship;
  ArrayList shots;

  float xpos, ypos;
  float xvel, yvel;
  float mass = 100;
  float impulse = 0;
  float r = 30;

  float theta = PI/2;  // PI/2 is up
  
  float circleradius = 150;
  float circleoscillation = 20;
  float circletime = 0;

  boolean turnLeft = false;
  boolean turnRight = false;

  float turnRate = PI;  // how much to turn per second

  Ship()
  {
    ship = loadImage("ship3.png");
    xpos = width/2;
    ypos = height/2;
    
    shots = new ArrayList();
  }  
  
  void fire() 
  {
    shots.add(new Shot(xpos+-cos(theta)*r, ypos-sin(theta)*r, cos(theta)*160, sin(theta)*160));
  }
  
  void update(float delta)
  {
    float deltaV = impulse / mass;

    xvel += cos(theta) * deltaV;  // metres / second
    yvel += sin(theta) * deltaV;
  
    xpos -= xvel * (delta);
    ypos -= yvel * (delta);

    if (turnLeft ^ turnRight)
    {
      println("Turn!");
      theta += (turnLeft ? -1 : 1) * turnRate * delta;
    }


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
   
    translate(xpos, ypos);
    
    scale(0.5);
    rotate(theta - PI/2);
    
    image(ship, -ship.width/2, -ship.height/2);
    
   
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
