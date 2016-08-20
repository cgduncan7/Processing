import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioInput audioInput;
Processor processor;

float radius, lRadius, mRadius, hRadius, lHigh, mHigh, hHigh, lcmHigh;

void setup() {
  size(400,400,P3D);
  minim = new Minim(this);
  audioInput = minim.getLineIn(Minim.STEREO);
  processor = new Processor(audioInput);
  
  frameRate(90);
  rectMode(CORNERS);
  
  radius = 20;
  lRadius = 20;
  mRadius = 20;
  hRadius = 20;
  lHigh = 0;
  mHigh = 0;
  hHigh = 0;
}

void draw() {
  background(0);
  
  ProcessorData data = processor.step();
  
  float a = map(radius, 20, 80, 60, 255);
  fill(60, 255, 0, a);
  if (data.beat) {
    radius = 80;
  }
  if (data.lBeat) {
    lRadius = 50;
  }
  if (data.mBeat) {
    mRadius = 50;
  }
  if (data.hBeat) {
    hRadius = 50;
  }
  ellipse(width/2, height/2, radius, radius);
  ellipse(width/4,height/4, lRadius, lRadius);
  ellipse(width/2,height/4, mRadius, mRadius);
  ellipse(3*width/4,height/4, hRadius, hRadius);
  
  if (data.lowFreq > lHigh) lHigh = data.lowFreq;
  if (data.midFreq > mHigh) mHigh = data.midFreq;
  if (data.highFreq > hHigh) hHigh = data.highFreq;
  
  rect(0, height, width/3, height - map(data.lowFreq, 0, lHigh, 0, height/4));
  rect(width/3, height, 2*width/3, height - map(data.midFreq, 0, mHigh, 0, height/4));
  rect(2*width/3, height, width, height - map(data.highFreq, 0, hHigh, 0, height/4));
  
  radius *= .95;
  if (radius < 20) radius = 20;
  lRadius *= .85;
  if (lRadius < 20) lRadius = 20;
  mRadius *= .85;
  if (mRadius < 20) mRadius = 20;
  hRadius *= .85;
  if (hRadius < 20) hRadius = 20;
}