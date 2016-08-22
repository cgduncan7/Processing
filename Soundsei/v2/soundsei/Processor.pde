import ddf.minim.*;
import ddf.minim.analysis.*;

class Processor {
  Minim minim;
  AudioInput input;
  FFT fft;
  int bufferSize, windowSize;
  float sampleRate;
  SoundEnergyBuffer seb, lfeb, mfeb, hfeb;
  
  public Processor() {
    minim = new Minim(this);
    input = minim.getLineIn(Minim.STEREO);
    sampleRate = input.sampleRate();
    bufferSize = input.bufferSize();
    windowSize = floor(sampleRate / bufferSize);
    fft = new FFT(bufferSize, sampleRate);
    fft.logAverages(5096, 1);
    seb = new SoundEnergyBuffer(windowSize);
    lfeb = new SoundEnergyBuffer(windowSize);
    mfeb = new SoundEnergyBuffer(windowSize);
    hfeb = new SoundEnergyBuffer(windowSize);
  }
  
  ProcessorData step() {
    fft.forward(input.mix);
    float lowFreq = fft.getAvg(0)*2;
    float lAvg = lfeb.getAverage();
    float lCons = lfeb.getConstant();
    boolean lBeat = isBeat(lowFreq, lAvg, lCons);
    lfeb.write(lowFreq);
    
    float midFreq = fft.getAvg(1)*2;
    float mAvg = mfeb.getAverage();
    float mCons = mfeb.getConstant();
    boolean mBeat = isBeat(midFreq, mAvg, mCons);
    mfeb.write(midFreq);
    
    float highFreq = fft.getAvg(2)*2;
    float hAvg = hfeb.getAverage();
    float hCons = hfeb.getConstant();
    boolean hBeat = isBeat(highFreq, hAvg, hCons);
    hfeb.write(highFreq);
    
    float current = calcSoundEnergy(input.left.toArray(), input.right.toArray());
    float avg = seb.getAverage();
    float cons = seb.getConstant();
    boolean beat = isBeat(current, avg, cons);
    seb.write(current);
    return new ProcessorData(beat, lBeat, mBeat, hBeat, current, lowFreq, midFreq, highFreq);
  }
  
  float calcSoundEnergy(float[] left, float[] right) {
    float bufferSize = left.length;
    float Ej = 0;
    for (int i = 0; i < bufferSize; i++) {
      Ej += (pow(left[i],2) + pow(right[i],2));
    }
    return Ej;
  }
  
  boolean isBeat(float current, float average, float cons) {
    return current > cons * average;
  }
}

class ProcessorData {
  boolean beat, lBeat, mBeat, hBeat;
  float energy, lowFreq, midFreq, highFreq;
  
  public ProcessorData(boolean beat, boolean lBeat, boolean mBeat, boolean hBeat,
                        float energy, float lowFreq, float midFreq, float highFreak) {
    this.beat = beat;
    this.lBeat = lBeat;
    this.mBeat = mBeat;
    this.hBeat = hBeat;
    this.energy = energy;
    this.lowFreq = lowFreq;
    this.midFreq = midFreq;
    this.highFreq = highFreak;
  }
}