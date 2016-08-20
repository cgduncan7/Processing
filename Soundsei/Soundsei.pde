//import processing.sound.*;

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
FFT fft;
AudioInput source;

float[] ranges = new float[]{0, 500, 1000, 4000, 6000, 16000};

float[] buffer = new float[1024];
int index = 0;

SoundEnergyBuffer seb;
SoundFrequencyBuffer sfb;

void setup() {
  minim = new Minim(this);
  source = minim.getLineIn();
  seb = new SoundEnergyBuffer(1024);
  fft = new FFT(1024, source.sampleRate());
  println((source.sampleRate() / 2) / fft.getBandWidth());
  size(1024,800);
  background(0);
  frameRate(60);
}

void draw() {
  background(0);
  
  rect(600, 550, 5, -1*source.left.level() * 500);
  rect(605, 550, 5, -1*source.right.level() * 500);
  
  boolean beat = seb.addCurrent(source.left.toArray(), source.right.toArray());
  
  //println(seb.getCurrentEnergy() + "\t" + seb.getMaxEnergy() + "\t" + seb.getMinEnergy());
  
  float energy = map(seb.getCurrentEnergy(), seb.getMinEnergy(), seb.getMaxEnergy(), 0 , 200);
  buffer[index] = energy;
  index = (index + 1) % 1024;
  
  stroke(255);
  for (int i = 0; i < 1024; i++) {
    line(i, 0, i, buffer[(index + i) % 1024]);
  }
  
  fill(255);
  if (beat) {
    ellipse(100,200,100,100);
  } else {
    ellipse(200,200,100,100);
  }
}

class SoundFrequencyBuffer {
  private float[][] buffer;
  private int startIndex;
  private int size;
  
  public SoundFrequencyBuffer(float[] ranges, int size) {
    this.size = size;
    buffer = new float[ranges.length][size];
    startIndex = 0;
  }
  
  public float[] addCurrent(float[] current) {
    float[] vals = new float[current.length-1];
    
    for (int i = 0 ; i < current.length - 1; i++) {
      float avg = 0.0f;
      for (int j = 0; j < buffer[i].length; j++) {
        avg += buffer[i][j];
      }
      avg = avg / buffer[i].length;
      vals[i] = current[i] / avg;
      buffer[i][startIndex] = current[i];
    }
    startIndex = (startIndex+1) % size;
    return vals;
  }
  
  public float[][] getBuffer() {
    return buffer;
  }
  
  public int getStartIndex() {
    return startIndex;
  }
}

class SoundEnergyBuffer {
  private float[] buffer;
  private int startIndex;
  private float currentEnergy, averageEnergy, minEnergy = 1000, maxEnergy = 0;
 
  public SoundEnergyBuffer(int size) {
    this.startIndex = 0;
    buffer = new float[size];
  }
  
  public float[] getBuffer() {
    return buffer;
  }
  
  public int getStartIndex() {
    return startIndex;
  }
  
  public float getCurrentEnergy() {
    return currentEnergy;
  }
  
  public float getAverageEnergy() {
    return averageEnergy;
  }
  
  public float getMinEnergy() {
    return minEnergy;
  }
  
  public float getMaxEnergy() {
    return maxEnergy;
  }
  
  public float getMinMaxConstant(float x) {
    return (getMaxEnergy() - getMinEnergy()) * x;
  }
  
  public boolean addCurrent(float[] left, float[] right) {
    currentEnergy = computeCurrentEnergy(left, right);
    
    if (currentEnergy > getMaxEnergy()) {
      maxEnergy = currentEnergy;
    }
    
    if (currentEnergy < getMinEnergy()) {
      minEnergy = currentEnergy;
    }
    
    averageEnergy = computeAverageEnergy(buffer);
    float sensitivity = computeSensitivity(averageEnergy, buffer);
    
    buffer[startIndex++] = currentEnergy;
    
    startIndex = startIndex % buffer.length;
    
    return (currentEnergy > (sensitivity*averageEnergy));
  }
  
  private float computeCurrentEnergy(float[] left, float[] right) {
    float currentEnergy = 0.0f;
    
    for (int i = 0; i < left.length; i++) {
      currentEnergy += (pow(left[i], 2) + pow(right[i], 2)); 
    }
    
    return currentEnergy;
  }
  
  private float computeAverageEnergy(float[] buffer) {
    float averageEnergy = 0.0f;
    
    for (int i = 0; i < buffer.length; i++) {
      averageEnergy += buffer[i];
    }
    
    return (averageEnergy / buffer.length);
  }
  
  private float computeSensitivity(float avg, float[] buffer) {
    float variance = 0.0f, sensitivity = 0.0f;
    
    for (int i = 0; i < buffer.length; i++) {
      variance = pow((buffer[i] - avg), 2);
    }
    variance = variance / buffer.length;
    sensitivity = (-0.0025714 * variance) + 1.5142857;
    
    return sensitivity;
  }
}