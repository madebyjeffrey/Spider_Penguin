
class Enemy
{
  PImage satBody;
  PImage satWings;
  float satTheta;
  
  Enemy()
  {
    satBody = loadImage("satelliteBody.png");
    satWings = loadImage("satelliteWings.png");
    satTheta = 0.0;
  }
  
  void update(float delta)
  {
    satTheta += PI * delta/1000.0;
  }
  
  void draw()
  {
    translate(-satBody.width/2, -satBody.height/2);

    image(satBody, 0, 0);

    translate(satBody.width/2, satBody.height/2);
    rotateY(satTheta);
    translate(-satBody.width/2, -satBody.height/2);

    image(satWings, 0, 0);
    
  }
  
}
