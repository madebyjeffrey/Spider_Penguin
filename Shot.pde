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
     _sx -= _svx * delta;
     _sy -= _svy * delta;
  }
  
  public void draw()
  {
    pushMatrix();
   
    translate(_sx, _sy);
    fill(1,0,0);
    stroke(1, 0, 0);
    arc(0, 0, 5, 5, 0, 2*PI); 
    
   
    popMatrix(); 

  }
  
  public boolean valid()
  {
     return !((_sx < 0 || _sx > width) || (_sy < 0 || _sy > height));
  }  
   
   
   
  
}

