

class GameScreen
{
  float _w, _d;
  float _cx, _cy;
  
  float left;
  
  GameScreen(int w, int d, float cx, float cy)
  {
    _w = (float)w;
    _d = (float)d;
   
    _cx = cx;
    _cy = cy;
   
    float w1 = (w * cx);
    
    if (w1 > width)
    {
      throw new IllegalArgumentException("Width too big for screen.");
    }
    
    left = width/2 - w1/2;
  }
  
  void drawGrid()
  {
    pushMatrix();
    translate(0, 0, -10);  
    stroke(0.35);
    
    for (int i = 0; i <= _w; i++)
    {
      line(left + i * _cx, 0, left + i * _cx, height);
    }
    
    for (int i = 0; i < _d; i++)
    {
       line(left, i * _cy,  left + _cx * _w, i * _cy);
    }
    
    popMatrix(); 
  }
  
  void setMatrix()
  {
    translate(left, 0);

    scale(_cx, _cy);    
  }

}


