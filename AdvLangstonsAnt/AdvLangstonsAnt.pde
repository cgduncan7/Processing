class Ant
{
  int direction; //0 north, 1 east, 2 south, 3 west
  int xloc, yloc, size;
  
  public Ant(int x, int y, int size)
  {
    direction = 0;
    this.xloc = x;
    this.yloc = y;
    this.size = size;
  }
  
  void turnRight()
  {
    direction = (direction + 1) % 4;
  }
  
  void turnLeft()
  {
    int temp = direction - 1;
    if (temp >= 0)
      direction = temp;
    else
      direction = 3;
  }
  
  void move()
  {
    switch (direction)
    {
      case 0: yloc = (yloc == 0) ? height - size : yloc - size; break;
      case 1: xloc = (xloc == width-size) ? 0 : xloc + size; break;
      case 2: yloc = (yloc == height-size) ? 0 : yloc + size; break;
      case 3: xloc = (xloc == 0) ? width - size : xloc - size; break;
    }
  }
  
  void drawMe()
  {
    fill(255,0,0);
    rect(xloc,yloc,size,size);
  }
}

class Cell
{
  int state, maxState;
  
  public Cell(int maxState)
  {
    this.maxState = maxState;
    this.state = 0;
  }
  
  void incrementState()
  {
    if (state < maxState-1)
    {
      this.state = state + 1;
    }
    else
    {
      this.state = 0;
    }
  }
  
  int getState()
  {
    return this.state;
  }
}

class Field
{
  Cell[][] cells;
  Ant ant;
  char[] cmds;
  int x, y, size;
  
  public Field(int x, int y, int size, int states, char[] cmds)
  {
    this.x = x;
    this.y = y;
    this.size = size;
    this.cmds = cmds;
    ant = new Ant((x/2)*size,(y/2)*size, size);
    cells = new Cell[x][y];
    for (int i = 0; i < y; i++)
    {
      for (int j = 0; j < x; j++)
      {
        cells[j][i] = new Cell(states);
      }
    }
  }
  
  void tick()
  {
    if (cmds[cells[ant.xloc/size][ant.yloc/size].state] == 'R')
    {
      ant.turnRight();
    }
    else
    {
      ant.turnLeft();
    }
    cells[ant.xloc/size][ant.yloc/size].incrementState();
    ant.move();
  }
}

Field f;
char[] cmds;
color[] clrs;
int size;

void setup()
{
  noStroke();
  rectMode(CORNER);
  colorMode(RGB);
  size(500,500);
  background(0);
  cmds = "RLLRLRLLR".toCharArray();
  size = 5;
  f = new Field(width/size,height/size,size,cmds.length,cmds);
  clrs = new color[cmds.length];
  for (int i = 0 ; i < clrs.length; i++)
  {
    clrs[i] = color(random(255),random(255),random(255));
  }
}

void draw()
{
  f.tick();
  for (int y = 0; y < f.y; y++)
  {
    for (int x = 0; x < f.x; x++)
    {
      fill(clrs[f.cells[x][y].getState()]);
      rect(x*size,y*size,size,size);
    }
  }
  f.ant.drawMe();
}
