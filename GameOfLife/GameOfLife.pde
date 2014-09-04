class Cell
{
  int x, y, size;
  boolean state = false, nextState = false;
  
  public Cell(int x, int y, int size)
  {
    this.x = x * size;
    this.y = y * size;
    this.size = size;
  }
  
  public void drawMe()
  {
    if (state)
      fill(0);
    else
      fill(255);
    rect(x,y,x+size,y+size);
  }
  
  public void switchState()
  {
    state = nextState;
  }
  
  public boolean getState()
  {
    return state;
  }
  
  public void setState(boolean s)
  {
    state = s;
  }
  
  public void setNextState(boolean ns)
  {
    nextState = ns;
  }
}

int SIZE = 5;
Cell[][] cells;

void setup()
{
  size(2000,2000);
  background(255);
  noStroke();
  cells = new Cell[width/SIZE][height/SIZE];
  
  //print(height/SIZE + "\n");
  
  for (int x = 0; x < (width/SIZE); x++)
  {
    for (int y = 0; y < (height/SIZE); y++)
    {
      //print("Creating new cell @ (" + x + ", " + y + ").\n");
      cells[x][y] = new Cell(x,y,SIZE);
      if (x%2 == 0) cells[x][y].setState(true);
    }
  }
}

void draw()
{
  int w = width/SIZE;
  int h = height/SIZE;
  rectMode(CORNERS);
  fill(0);
  for (int x = 0; x < w; x++)
  {
    for (int y = 0; y < h; y++)
    {
      cells[x][y].switchState();
      cells[x][y].drawMe();
      
      int neg_x = (x == 0) ? w - 1 : x - 1;
      int neg_y = (y == 0) ? h - 1 : y - 1;
      int pos_x = (x == (w-1)) ? 0 : x + 1;
      int pos_y = (y == (h-1)) ? 0 : y + 1;
      
      int count = 0;
      
      if (cells[neg_x][neg_y].getState()) count++;
      if (cells[x][neg_y].getState()) count++;
      if (cells[pos_x][neg_y].getState()) count++;
      
      if (cells[neg_x][y].getState()) count++;
      if (cells[pos_x][y].getState()) count++;
      
      if (cells[neg_x][pos_y].getState()) count++;
      if (cells[x][pos_y].getState()) count++;
      if (cells[pos_x][pos_y].getState()) count++;
      
      if (cells[x][y].getState() && count <= 3 && count >= 2)
      {
        cells[x][y].setNextState(true);
      }
      else if (cells[x][y].getState() && (count > 3 || count < 2))
      {
        cells[x][y].setNextState(false);
      }
      else if (!cells[x][y].getState() && count == 3)
      {
        cells[x][y].setNextState(true);
      }
      else
      {
        cells[x][y].setNextState(false);
      }
    }
  }
  delay(100);
}
