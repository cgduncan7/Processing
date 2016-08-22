class Scene1_Beatboxes extends Scene {
  public BoxRow[] boxRows;
  
  public Scene1_Beatboxes(PApplet parent) {
    super(parent, new Processor());
  }
  
  public Scene1_Beatboxes(PApplet parent, Processor processor) {
    super(parent, processor);
    boxRows = new BoxRow[5];
  }
  
  public void init(PApplet parent) {
    parent.background(0);
    frameRate(60);
  }
  
  public void onBeat(PApplet parent, float val) {
    
  }
  
  public void onLowFreqBeat(PApplet parent, float val) {
    
  }
  
  public void onMidFreqBeat(PApplet parent, float val) {
    
  }
  
  public void onHighFreqBeat(PApplet parent, float val) {
    
  }
  
  public void draw(PApplet parent, float energy, float lowFreq, float midFreq, float highFreq) {
    parent.background(0);
  }
}

class BoxRow {
  private Box[] boxes;
  private int index;
  
  public BoxRow(int length) {
    boxes = new Box[length];
    index = 0;
  }
  
  public void push(Box box) {
    boxes[index] = box;
    index = (index >= boxes.length - 1) ? 0 : index + 1;
  }
  
  public void draw(PApplet parent) {
    for (int i = 0; i < boxes.length - 1; i++) {
      Box b = boxes[i];
      b.draw(parent);
      b.y += parent.height / boxes.length;
    }
  }
}

class Box {
  int x, y, w, h;
  color border, fill;
  
  public Box(int x, int y, int w, int h, color border, color fill) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.border = border;
    this.fill = fill;
  }
  
  public void draw(PApplet parent) {
    parent.colorMode(RGB);
    parent.stroke(border);
    parent.fill(fill);
    parent.rect(x, y, w, h);
  }
}