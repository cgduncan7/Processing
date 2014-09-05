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
    {
      fill(0);
    }
    else
      fill(255);
    rect(x,y,x+size,y+size);
  }
  
  public void fillNeighbor()
  {
    fill(255,0,0);
    rect(x,y,x+size,y+size);
  }
  
  public void switchState()
  {
    state = nextState;
    nextState = false;
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
int WIDTH = 500;
int HEIGHT = 500;
int GENERATIONS = 0;
boolean play = false;
Cell[][] cells;

void setup()
{
  size(WIDTH,HEIGHT + 100);
  background(255);
  noStroke();
  cells = new Cell[WIDTH/SIZE][HEIGHT/SIZE];
  
  for (int x = 0; x < (WIDTH/SIZE); x++)
  {
    for (int y = 0; y < (HEIGHT/SIZE); y++)
    {
      cells[x][y] = new Cell(x,y,SIZE);
    }
  }
}

void mouseDragged()
{
  if (mouseY <= (height-(height/10)))
  {
    int x = mouseX/SIZE;
    int y = mouseY/SIZE;
    if (x >= 0 && x < (WIDTH/SIZE) && y >= 0 && y < (HEIGHT/SIZE))
    {
      cells[x][y].setState(true);
    }
  }
}

void mouseClicked()
{
  if (mouseY <= (height-(height/10)))
  {
    int x = mouseX/SIZE;
    int y = mouseY/SIZE;
    if (x >= 0 && x < (WIDTH/SIZE) && y >= 0 && y < (HEIGHT/SIZE))
    {
      cells[x][y].setState(!cells[x][y].getState());
    }
  }
  else
  {
    play = !play;
  }
}

void draw()
{
  int w = WIDTH/SIZE;
  int h = HEIGHT/SIZE;
  rectMode(CORNER);
  fill(0);
  rect(0,height-(height/10), width, height/10);
  rectMode(CORNERS);
  colorMode(RGB);
  fill(0);
  
  if (play)
  {
    for (int x = 0; x < w; x++)
    {
      for (int y = 0; y < h; y++)
      {
        int neg_x = (x == 0) ? w - 1 : (x - 1);
        int neg_y = (y == 0) ? h - 1 : (y - 1);
        int pos_x = (x == (w-1)) ? 0 : (x + 1);
        int pos_y = (y == (h-1)) ? 0 : (y + 1);
        
        int count = 0;
        
        if (cells[x][y].getState())
        {
          cells[neg_x][neg_y].fillNeighbor();
          cells[x][neg_y].fillNeighbor();
          cells[pos_x][neg_y].fillNeighbor();
          
          cells[neg_x][y].fillNeighbor();
          cells[pos_x][y].fillNeighbor();
          
          cells[neg_x][pos_y].fillNeighbor();
          cells[x][pos_y].fillNeighbor();
          cells[pos_x][pos_y].fillNeighbor();
        }
        
        if (cells[neg_x][neg_y].getState())
        {
          count = count + 1;
        }
        if (cells[x][neg_y].getState())
        {
          count = count + 1;
        }
        if (cells[pos_x][neg_y].getState())
        {
          count = count + 1;
        }
        
        if (cells[neg_x][y].getState())
        {
          count = count + 1;
        }
        if (cells[pos_x][y].getState())
        {
          count = count + 1;
        }
        
        if (cells[neg_x][pos_y].getState())
        {
          count = count + 1;
        }
        if (cells[x][pos_y].getState())
        {
          count = count + 1;
        }
        if (cells[pos_x][pos_y].getState())
        {
          count = count + 1;
        }
        
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
      }
    }
    GENERATIONS++;
  }
    
  boolean alive = !play;
  for (int x = 0; x < w; x++)
  {
    for (int y = 0; y < h; y++)
    {
      if (play) cells[x][y].switchState();
      if (cells[x][y].getState()) alive = true;
      cells[x][y].drawMe();
    }
  }
  fill(255,0,0);
  text("Gens: " + GENERATIONS, 5, 15);
  if (!alive)
  {
    stop();
  }
  delay(100);
}
