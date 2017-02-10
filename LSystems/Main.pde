import java.util.*;

LSystem lSys;
  char[] vars = {'X','F'};
  char[] constants = {'+','-','[',']'};
  String start = "X";
  Rule rule1 = new Rule('X', "[F+[X+FX]][F-[X+FX]]");
  Rule rule2 = new Rule('F', "FF");
  Rule[] rules = {rule1,rule2};

Turtle turtle;

int index;

void settings()
{
  size(800, 600);
}

void setup()
{
  turtle = new Turtle(width/2, height , 270, new Pen(10, color(0,0,0)));
  lSys = new LSystem(vars, constants, start, rules, 6);
  index = 0;
}

void draw()
{
  //background(255);
  //step(0);
  full();
}

void delay(int delay)
{
  int time = millis();
  while (millis() - time <= delay) ;
}

void schema(char c) {
  if (c == 'F')
  {
    turtle.startPen();
    turtle.moveTurtle(random(2,4));
  }
  else if (c == '+')
  {
    turtle.rotateTurtle(random(20,30));
  }
  else if (c == '-')
  {
    turtle.rotateTurtle(-1*(random(20,30)));
  }
  else if (c == '[')
  {
    turtle.pushInfo();
  }
  else if (c == ']')
  {
    turtle.popInfo();
  }
}

void step(int delay)
{ 
  if (index < lSys.sequence.length())
  {
    char c = lSys.sequence.charAt(index);
    schema(c);
    
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
    schema(c);
  }
  stop();
}