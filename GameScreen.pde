
GameScreen newGame(int w, int d, float cx, float cy)
{
   GameScreen g;
  try
  {
   g = new GameScreen(w, d, cx, cy);
  }
  catch (IllegalArgumentException e)
  {
    return null; 
  }
  
  return g;
  
}

class GameScreen
{
  float _w, _d;
  float _cx, _cy;
  
  float left;
  
  PFont font;
  
  float bottom = 0;
  float rate = 1; // move up at a rate of 2 per second
  
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
    
    font = loadFont("Monospaced-16.vlw");
    
    
    left = width/2 - w1/2;
  }
  
  void update(float dt)
  {
    bottom += rate * dt;
  }
  
  void drawGrid()
  {
    pushMatrix();
    
    setMatrix();
    translate(0, 0, -10);
    stroke(0.35);


    for (int i = 0; i <= _w; i++)
    {
      line (i, 0, i, _d);
    }  
    
    for (int i = 0; i <= _d; i++)
    {
      line (0, i, _w, i);
      drawText("" + i, _w+0.25, i);
    }
    
    popMatrix(); 
  }
  
  void setMatrix()
  {
    translate(left, 0);

    scale(_cx, _cy);    
    translate(0, -bottom); // bottom is in grid units
  }

  void drawText(String s, float x, float y)
  {
    pushMatrix();
    
    translate(x, y);
    scale(1, -1);
    textFont(font, 0.33);
    text(s, 0, 0); 
    
    popMatrix();
  }
}


