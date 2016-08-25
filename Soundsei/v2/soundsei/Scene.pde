public abstract class Scene {
  private Processor processor;
  private PApplet parent;
  public boolean initialized;
  
  public Scene(PApplet parent, Processor processor) {
    this.processor = processor;
    this.parent = parent;
    this.initialized = false;
  }
  
  public abstract void onLowFreqBeat(PApplet parent, float val);
  public abstract void onMidFreqBeat(PApplet parent, float val);
  public abstract void onHighFreqBeat(PApplet parent, float val);
  public abstract void onBeat(PApplet parent, float val);
  public abstract void draw(PApplet parent, float energy, float lowFreq, float midFreq, float highFreq);
  public abstract void init(PApplet parent);
  
  public void init() {
    init(parent);
    this.initialized = true;
  }
  
  public void step() {
    if (this.initialized) {
      ProcessorData pData = processor.step();
      
      draw(parent, pData.energy, pData.lowFreq, pData.midFreq, pData.highFreq);
      if (pData.beat) onBeat(parent, pData.energy);
      if (pData.lBeat) onLowFreqBeat(parent, pData.lowFreq);
      if (pData.mBeat) onMidFreqBeat(parent, pData.midFreq);
      if (pData.hBeat) onHighFreqBeat(parent, pData.highFreq);
    }
  }
}