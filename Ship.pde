
class Ship
{
  PImage ship;

  float xpos, ypos;
  float xvel, yvel;
  float mass = 100;
  float impulse = 0;

  float theta = PI/2;  // PI/2 is up

  Ship()
  {
    ship = loadImage("ship3.png");
    xpos = width/2;
    ypos = height/2;
  }  
  
  void update(float delta)
  {
    float deltaV = impulse / mass;

    xvel += cos(theta) * deltaV;  // metres / second
    yvel += sin(theta) * deltaV;
  
    xpos -= xvel * (delta / 1000.0);
    ypos -= yvel * (delta / 1000.0);

    
  }
}
