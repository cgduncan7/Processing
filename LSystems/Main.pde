import java.util.*;

LSystem lSys;
  char[] vars = {'F'};
  char[] constants = {'+','-'};
  String start = "F";
  Rule rule1 = new Rule('F', "+F--F+");
  Rule[] rules = {rule1};

Turtle turtle;

int index;

void setup()
{
  size(500,500);
  turtle = new Turtle(3*width/4, height/4, 180, new Pen(5, color(0,0,0)));
  lSys = new LSystem(vars, constants, start, rules, 12);
  index = 0;
}

void draw()
{
  //background(255);
  step(0);
  //full();
}

void delay(int delay)
{
  int time = millis();
  while (millis() - time <= delay) ;
}

void step(int delay)
{ 
  if (index < lSys.sequence.length())
  {
    char c = lSys.sequence.charAt(index);
    if (c == 'F')
    {
      turtle.startPen();
      turtle.moveTurtle(5);
    }
    else if (c == '+')
    {
      turtle.rotateTurtle(-45);
    }
    else if (c == '-')
    {
      turtle.rotateTurtle(45);
    }
    else if (c == '[')
    {
      turtle.pushInfo();
      turtle.rotateTurtle(45);
    }
    else if (c == ']')
    {
      turtle.popInfo();
      turtle.rotateTurtle(-45);
    }
    
    if (delay > 0)
      delay(delay);
    index++;
  }
  else
  {
    stop();
  }
}

void full()
{
  for (char c : lSys.sequence.toCharArray())
  {
    if (c == '0' || c == '1')
    {
      turtle.startPen();
      turtle.moveTurtle(5);
    }
    else if (c == '+')
    {
      turtle.rotateTurtle(-25);
    }
    else if (c == '-')
    {
      turtle.rotateTurtle(25);
    }
    else if (c == '[')
    {
      turtle.pushInfo();
      turtle.rotateTurtle(45);
    }
    else if (c == ']')
    {
      turtle.popInfo();
      turtle.rotateTurtle(-45);
    }
  }
  stop();
}
