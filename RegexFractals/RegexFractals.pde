class CartesianField
{
  int x, y, i = 0;
  String[][] cells;
  
  public CartesianField(int x, int y)
  {
    this.x = x;
    this.y = y;
    cells = new String[x][y];
    
    subdivide(0,0,x-1,y-1,"");
  }
  
  public void subdivide(int x1, int y1, int x2, int y2, String curString)
  {
    if (x1 == x2 && y1 == y2)
    {
      cells[x2][y2] = curString;
      return;
    }
    else
    {
      int x_mid = floor((x2-x1)/2)+x1;
      int y_mid = floor((y2-y1)/2)+y1;
      subdivide(x_mid+1, y1, x2, y_mid, curString + "1");
      subdivide(x1, y1, x_mid, y_mid, curString + "2");
      subdivide(x1, y_mid+1, x_mid, y2, curString + "3");
      subdivide(x_mid+1, y_mid+1, x2, y2, curString + "4");
    }
  }
}

boolean draw, draw_t;
String temp, regex;
CartesianField cf;

void setup()
{
  size(1024,1024);
  cf = new CartesianField(1024, 1024);
  regex = "";
  temp = "";
  draw = false;
  noStroke();
  fill(0,0,0);
}

void draw()
{
  background(255);
  if (!temp.equals(""))
  {
    text(temp,50,50);
  }
  else if (!regex.equals(""))
  {
    //text(regex,50,50);
    
    for (int y = 0; y < cf.y; y++)
    {
      for (int x = 0; x < cf.x; x++)
      {
        String[] match = match(cf.cells[x][y], regex);
        if (match != null)
        {
          fill(match[1].length()*15,0,0);
          rect(x,y,1,1);
        }
      }
    }
  }
}

void keyPressed()
{
  if (key == '\n')
  {
    draw = true;
    regex = temp;
    temp = "";
  }
  else if (key == (char) 8)
  {
    temp = temp.substring(0,temp.length()-1);
  }
  else if (key != CODED)
  {
    temp = temp + key;
  }
}
