class Scene3_Walkers extends Scene {
  Walker hiWalker, midWalker, loWalker, eWalker;
  
  public Scene3_Walkers(PGraphics parent) {
    this(parent, new Processor());
  }
  
  public Scene3_Walkers(PGraphics parent, Processor processor) {
    super(parent, processor);
  }
  
  public void init(PGraphics parent) {
    println(parent);
    parent.background(0);
    hiWalker = new Walker(parent, color(255,128,128), 50, 5);
    midWalker = new Walker(parent, color(255,128,128), 50, 5);
    loWalker = new Walker(parent, color(255,128,128), 50, 5);
    eWalker = new Walker(parent, color(255,128,128), 50, 5);
  }
  
  public void onBeat(PGraphics parent, float val) {}
  
  public void onLowFreqBeat(PGraphics parent, float val) {}
  
  public void onMidFreqBeat(PGraphics parent, float val) {}
  
  public void onHighFreqBeat(PGraphics parent, float val) {}
  
  public void draw(PGraphics parent, float energy, float lfenergy, float mfenergy, float hfenergy) {
    parent.background(0, 85);
    
    hiWalker.update();
    midWalker.update();
    loWalker.update();
    eWalker.update();
    
    hiWalker.draw();
    midWalker.draw();
    loWalker.draw();
    eWalker.draw();
  }
}

class Walker {
  PVector[] history;
  PVector current;
  int index, step;
  color c;
  PGraphics parent;
  
  public Walker(PGraphics parent, color c, int historySize, int step) {
    this.parent = parent;
    this.c = c;
    this.step = step;
    history = new PVector[historySize];
    current = new PVector(parent.width/2, parent.height/2, 10);
    index = 0;
  }
  
  public void update() {
    update(step);
  }
  
  public void update(int stepSize) {
    history[index] = current;
    this.step = stepSize;
    int instruction = floor(random(4));
    switch (instruction) {
      case 0: //left
        current = new PVector(current.x - step, current.y, current.z);
        current.x = (current.x > parent.width ? 0 : (current.x < 0 ? parent.width : current.x));
        break;
      case 2: //right
        current = new PVector(current.x + step, current.y, current.z);
        current.x = (current.x > parent.width ? 0 : (current.x < 0 ? parent.width : current.x));
        break;
      case 1: //up
        current = new PVector(current.x, current.y - step, current.z);
        current.y = (current.y > parent.height ? 0 : (current.y < 0 ? parent.height : current.y));
        break;
      case 3: //down
        current = new PVector(current.x, current.y + step, current.z);
        current.y = (current.y > parent.height ? 0 : (current.y < 0 ? parent.height : current.y));
        break;
      //case 4: //forward (z)
      //  current = new PVector(current.x, current.y, current.z + 1);
      //  current.z = min(15, current.z);
      //  break;
      //case 5: //backward (z)
      //  current = new PVector(current.x, current.y, current.z - 1);
      //  current.z = max(1, current.z);
      //  break;
    }
    index = (index+1) % history.length;
  }
  
  public void draw() {
    
    for (int i = history.length; i > 0; i--) {
      color cc = lerpColor(color(0), c, map(i, 0, history.length, 1, 0));
      parent.stroke(cc);
      int ind = index - i;
      ind = (ind < 0) ? history.length + ind : ind;
      PVector p = history[ind];
      if (p != null) {
        parent.strokeWeight(p.z);
        parent.point(p.x, p.y);
      }
    }
    parent.stroke(c);
    parent.strokeWeight(current.z);
    parent.point(current.x, current.y);
  }
}