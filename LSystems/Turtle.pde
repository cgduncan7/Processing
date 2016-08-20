
class Turtle
{ 
  ArrayDeque<PVector> prev_locations;
  ArrayDeque<Float> prev_angles;
  PVector location;
  float angle; //assume 0 deg is right, 90 deg is up, etc..
  Pen pen;
  
  public Turtle(float x, float y, float angle, Pen pen)
  {
    prev_locations = new ArrayDeque<PVector>();
    prev_angles = new ArrayDeque<Float>();
    location = new PVector(x,y);
    this.angle = angle;
    this.pen = pen;
    strokeWeight(pen.penWidth);
    
    //print("Created turtle at " + x + ", " + y + "\n");
  }
  
  void moveTurtle(float distance)
  {
    float x = (float)distance*sin(radians(90-angle));
    float y = (float)distance*sin(radians(angle));
    if (pen.drawing)
    {
      fill(pen.c);
      line(location.x, location.y, location.x + x, location.y + y);
      //print("Drawing line from " + location.x + ", " + location.y + " to " + (location.x + x) + ", " + (location.y + y) + "\n");
    }
    location.set(location.x + x, location.y + y);
    //print("Turtle is now at " + location.x + ", " + location.y + "\n");
  }
  
  void rotateTurtle(float deg)
  {
    angle += deg;
    //print("Turtle is now rotated " + angle + " degrees.\n");
  }
  
  void startPen()
  {
    pen.drawing = true;
  }
  
  void stopPen()
  {
    pen.drawing = false;
  }
  
  void pushInfo()
  {
    prev_locations.addLast(location.get());
    prev_angles.addLast(angle);
  }
  
  void popInfo()
  {
    location.set(prev_locations.removeLast());
    angle = (Float) prev_angles.removeLast();
  }
}
