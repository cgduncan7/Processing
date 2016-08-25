class Scene1_Beatboxes extends Scene {
  public BoxRow[] boxRows;
  private int minColor, maxColor;
  private float min, max, minLow, minMid, minHigh, maxLow, maxMid, maxHigh;
  
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
    if (energy > max) energy = max;
    else if (energy < min) energy = min;
    
    if (lowFreq > maxLow) lowFreq = maxLow;
    else if (lowFreq < minLow) lowFreq = minLow;
    
    if (midFreq > maxMid) midFreq = maxMid;
    else if (midFreq < minMid) midFreq = minMid;
    
    if (highFreq > maxMid) highFreq = maxMid;
    else if (highFreq < minHigh) highFreq = minHigh;
    
    // TODO: Add the border and fill colors by using map() with min<x>/max<x> to create an even fill
    // Box b = new Box(dim, borderC, fillC);
    // boxRow.push(b);
    // boxRow.draw();
  }
}

class BoxRow {
  private Box[] boxes;
  private int index, xVal;
  
  public BoxRow(int length, int xVal) {
    boxes = new Box[length];
    this.xVal = xVal;
    index = 0;
  }
  
  public void push(Box box) {
    boxes[index] = box;
    boxes[index].x = xVal;
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
  
  public Box(int dim, color border, color fill) {
    this.w = dim;
    this.h = dim;
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