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
int pic_x, pic_y;
String temp, regex;
CartesianField cf;

void setup()
{
  size(1024,1024);
  cf = new CartesianField(1024, 1024);
  regex = "";
  temp = "";
  draw = false;
  pic_x = 5;
  pic_y = 5;
  noStroke();
  fill(0,0,0);
}

void draw()
{

  background(255);
  if (!temp.equals(""))
  {
    fill(0);
    text(temp,50,50);
  }
  else if (!regex.equals(""))
  {
    regex = regex.trim();
    for (int y = 0; y < cf.y; y++)
    {
      for (int x = 0; x < cf.x; x++)
      {
        String[] match = match(cf.cells[x][y], regex);
        if (match != null)
        {
          int s = 0;
          for (int i = 1; i < match.length; i++)
          {
            if (match[i] != null)
              s += match[i].length();
          }
          fill(255*((float)s/10),0,0);
          rect(x,y,1,1);
        }
      }
    }
    float tw = textWidth(regex);
    float ta = textAscent();
    float td = textDescent();
    rectMode(CORNER);
    fill(0,0,0,128);
    rect(pic_x,pic_y,10+tw,10+ta+td);
    fill(255,255,255,128);
    text(regex,pic_x+5,pic_y+5,tw,ta+td);
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
    if (temp.length() > 0)
      temp = temp.substring(0,temp.length()-1);
  }
  else if (key != CODED)
  {
    temp = temp + key;
  }
  else if (key == CODED)
  {
    if (keyCode == UP)
    {
      save("regex-" + day() + "-" + month() + "-" + year() + "_" + millis() +".png");
    }
  }
}

void mousePressed()
{
    pic_x = mouseX-2;
    pic_y = mouseY-2;
}
