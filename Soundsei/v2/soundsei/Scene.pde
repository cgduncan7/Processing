public abstract class Scene {
  private Processor processor;
  private PGraphics parent;
  public boolean initialized;
  
  public Scene(PGraphics parent, Processor processor) {
    this.processor = processor;
    this.parent = parent;
    this.initialized = false;
  }
  
  public abstract void onLowFreqBeat(PGraphics parent, float val);
  public abstract void onMidFreqBeat(PGraphics parent, float val);
  public abstract void onHighFreqBeat(PGraphics parent, float val);
  public abstract void onBeat(PGraphics parent, float val);
  public abstract void draw(PGraphics parent, float energy, float lowFreq, float midFreq, float highFreq);
  public abstract void init(PGraphics parent);
  
  public void init() {
    parent.beginDraw();
    init(parent);
    parent.endDraw();
    this.initialized = true;
  }
  
  public void step() {
    if (this.initialized) {
      ProcessorData pData = processor.step();
      
      parent.beginDraw();
      draw(parent, pData.energy, pData.lowFreq, pData.midFreq, pData.highFreq);
      if (pData.beat) onBeat(parent, pData.energy);
      if (pData.lBeat) onLowFreqBeat(parent, pData.lowFreq);
      if (pData.mBeat) onMidFreqBeat(parent, pData.midFreq);
      if (pData.hBeat) onHighFreqBeat(parent, pData.highFreq);
      parent.endDraw();
    }
  }
}