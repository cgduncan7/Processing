class Scene {
  private Processor processor;
  private PApplet parent;
  
  public Scene(PApplet parent, Processor processor) {
    this.processor = processor;
    this.parent = parent;
  }
  
  public void onLowFreqBeat(PApplet parent, float val) {
    /* IMPLEMENT */
  }
  
  public void onMidFreqBeat(PApplet parent, float val) {
    /* IMPLEMENT */
  }
  
  public void onHighFreqBeat(PApplet parent, float val) {
    /* IMPLEMENT */
  }
  
  public void onBeat(PApplet parent, float val) {
    /* IMPLEMENT */
  }
  
  public void draw(PApplet parent, float energy, float lowFreq, float midFreq, float highFreq) {
    /* IMPLEMENT */
  }
  
  private void step() {
    ProcessorData pData = processor.step();
    
    if(pData.beat) onBeat(parent, pData.energy);
    if (pData.lBeat) onLowFreqBeat(parent, pData.lowFreq);
    if (pData.mBeat) onMidFreqBeat(parent, pData.midFreq);
    if (pData.hBeat) onHighFreqBeat(parent, pData.highFreq);
    draw(parent, pData.energy, pData.lowFreq, pData.midFreq, pData.highFreq);
  }
}