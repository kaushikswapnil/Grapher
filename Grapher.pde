int resolution = 10;
float pointWidth = 10;

ArrayList<PVector> keyPoints;

void setup()
{
  size(800, 800);
  
  keyPoints = new ArrayList<PVector>();
  
}

void draw()
{
  background(255);
  
  stroke(0, 0, 255);
  for (float y = 0.0f; y < height; y += (height)/resolution)
  {
      line(0, y, width, y);
  }
  
  for (float x = 0.0f; x < width; x += (width)/resolution)
  {
      line(x, 0, x, height);
  }
  
  if (keyPoints.size() > 0)
  {
      stroke (255,0,0);
      ellipse(keyPoints.get(0).x, keyPoints.get(0).y, pointWidth, pointWidth);
      
      for (int iter = 1; iter < keyPoints.size(); ++iter)
      {
           PVector prevPoint = keyPoints.get(iter-1);
           PVector point = keyPoints.get(iter);
           stroke(0, 255, 0);
           line(prevPoint.x, prevPoint.y, point.x, point.y);
           stroke(255, 0, 0);
           ellipse(point.x, point.y, pointWidth, pointWidth); //<>//
      } 
  }
}

void mouseClicked()
{
  PVector mousePos = new PVector(mouseX, mouseY);
  if (mouseButton == LEFT)
  {
    float yMove = height/resolution;
    float xMove = width/resolution;
    mousePos.x = round(mousePos.x/xMove) * xMove;
    mousePos.y = round(mousePos.y/yMove) * yMove;
    
    keyPoints.add(mousePos); //<>//
  } //<>//
  else if (mouseButton == RIGHT)
  {
    for (int iter = 0; iter < keyPoints.size(); ++iter)
    {
      if (IsLesserOrEqualWithEpsilon(PVector.dist(mousePos, keyPoints.get(iter)), 8))
      {
        keyPoints.remove(iter);
        break;
      }
    }
  }
}

boolean IsNullWithEpsilon(float value)
{
  return abs(value - 0.0) <= EPSILON;
}

boolean IsGreaterWithEpsilon(float a, float b)
{
  return (a - b) > EPSILON;
}

boolean IsLesserWithEpsilon(float a, float b)
{
  return (a - b) < EPSILON;
}

boolean IsEqualWithEpsilon(float a, float b)
{
  return IsNullWithEpsilon(a-b); 
}

boolean IsGreaterOrEqualWithEpsilon(float a, float b)
{
   return IsGreaterWithEpsilon(a, b) || IsEqualWithEpsilon(a, b); 
}

boolean IsLesserOrEqualWithEpsilon(float a, float b)
{
   return IsLesserWithEpsilon(a, b) || IsEqualWithEpsilon(a, b); 
}
