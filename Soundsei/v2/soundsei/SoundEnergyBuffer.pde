class SoundEnergyBuffer {
  float[] soundEnergyBuffer;
  int index;
  float avg, var;
  
  public SoundEnergyBuffer(int bufferSize) {
    soundEnergyBuffer = new float[bufferSize];
    for (int i = 0; i < bufferSize; i++) {
      soundEnergyBuffer[i] = 0f;
    }
    index = 0;
    avg = var = 0;
  }
  
  public void write(float val) {
    soundEnergyBuffer[index] = val;
    index = (index >= soundEnergyBuffer.length - 1) ? 0 : index + 1;
  }
  
  public float getAverage() {
    float retVal = 0.0f;
    for (int i = 0; i < soundEnergyBuffer.length; i++) {
      retVal += soundEnergyBuffer[i];
    }
    retVal /= soundEnergyBuffer.length;
    avg = retVal;
    return retVal;
  }
  
  public float getVariance() {
    float retVal = 0.0f;
    for (int i = 0; i < soundEnergyBuffer.length; i++) {
      retVal += pow(avg - soundEnergyBuffer[i], 2);
    }
    retVal /= soundEnergyBuffer.length;
    var = retVal;
    return retVal;
  }
  
  public float getConstant() {
    return -0.0005714 * var + 1.5142857;
  }
}