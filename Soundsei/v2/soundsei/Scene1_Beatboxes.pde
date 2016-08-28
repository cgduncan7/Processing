class Scene1_Beatboxes extends Scene {
  public BoxRow boxRowE, boxRowL, boxRowM, boxRowH;
  private final int BOXROWS = 40;
  private int minColor, maxColor, DIM;
  private float min, max, minLow, minMid, minHigh, maxLow, maxMid, maxHigh;
  
  public Scene1_Beatboxes(PApplet parent) {
    this(parent, new Processor());
  }
  
  public Scene1_Beatboxes(PApplet parent, Processor processor) {
    super(parent, processor);
    boxRowE = new BoxRow(BOXROWS, 0*parent.width/4);
    boxRowL = new BoxRow(BOXROWS, 1*parent.width/4);
    boxRowM = new BoxRow(BOXROWS, 2*parent.width/4);
    boxRowH = new BoxRow(BOXROWS, 3*parent.width/4);
    minColor = 0;
    maxColor = 255;
    DIM = parent.width / 4;
    min = minLow = minMid = minHigh = 0;
    max = maxLow = maxMid = maxHigh = 1;
  }
  
  public void init(PApplet parent) {
    parent.background(0);
    parent.frameRate(60);
  }
  
  public void onBeat(PApplet parent, float val) {}
  
  public void onLowFreqBeat(PApplet parent, float val) {}
  
  public void onMidFreqBeat(PApplet parent, float val) {}
  
  public void onHighFreqBeat(PApplet parent, float val) {}
  
  public void draw(PApplet parent, float energy, float lowFreq, float midFreq, float highFreq) {
    background(0);
    if (energy > max) max = energy;
    else if (energy < min) min = energy;
    
    if (lowFreq > maxLow) maxLow = lowFreq;
    else if (lowFreq < minLow) minLow = lowFreq;
    
    if (midFreq > maxMid) maxMid = midFreq;
    else if (midFreq < minMid) minMid = midFreq;
    
    if (highFreq > maxHigh) maxHigh = highFreq;
    else if (highFreq < minHigh) minHigh = highFreq;
    
    Box eBox = new Box(DIM, color((int)map(energy, min, max, minColor, maxColor)));
    boxRowE.push(eBox);
    
    Box lBox = new Box(DIM, color((int)map(lowFreq, minLow, maxLow, minColor, maxColor), 0, 0));
    boxRowL.push(lBox);
    
    Box mBox = new Box(DIM, color(0, (int)map(midFreq, minMid, maxMid, minColor, maxColor), 0));
    boxRowM.push(mBox);
    
    Box hBox = new Box(DIM, color(0, 0, (int)map(highFreq, minHigh, maxHigh, minColor, maxColor)));
    boxRowH.push(hBox);
    
    boxRowE.draw(parent);
    boxRowL.draw(parent);
    boxRowM.draw(parent);
    boxRowH.draw(parent);
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
    index = (index >= boxes.length - 1) ? 0 : index + 1;
  }
  
  public void draw(PApplet parent) {
    for (int i = 0; i < boxes.length - 1; i++) {
      Box b = boxes[(index + i) % (boxes.length - 1)];
      if (b != null) b.draw(parent, xVal, (parent.height / boxes.length) * i);
    }
  }
}

class Box {
  int w, h;
  color border, fill;
  
  public Box(int dim, color fill) {
    this.w = dim;
    this.h = dim;
    this.border = color(0,0,0);
    this.fill = fill;
  }
  
  public void draw(PApplet parent, int x, int y) {
    parent.colorMode(RGB);
    parent.stroke(fill);
    parent.fill(fill);
    parent.rect(x, y, w, h);
  }
}