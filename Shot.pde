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
