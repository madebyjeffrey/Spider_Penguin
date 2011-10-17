
class Enemy
{
  float satTheta;
  
  PImage wing_left;
  PImage wing_right;
  PImage body_front;
  PImage body_back;
  PImage body_mid;
  
  float _x, _y;
  
  Enemy(float x, float y)
  {
    wing_left = loadImage("enemy_wingleft.png");
    wing_right = loadImage("enemy_wingright.png");
    
    body_front = loadImage("enemy_bodyfront.png");
    body_back = loadImage("enemy_bodyback.png");
    body_mid = loadImage("enemy_bodymid.png");
    _x = x;
    _y = y;

    satTheta = 0.0;
  }
  
  void update(float delta)
  {
    satTheta += PI * delta;
  }
  
  void draw()
  {    pushMatrix();
    
    translate(_x, _y);
    
//    scale(0.25);

    scale(1/158.0);

    image(body_back, -22, -22);
    image(body_front, -27, 31);
    image(body_mid, -16, 22);
    
    rotateY(satTheta);
    image(wing_left, -80, -39);
    image(wing_right, 20, -39);
    


    
    popMatrix();
    
  }
  
}
