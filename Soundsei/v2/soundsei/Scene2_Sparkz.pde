class Scene2_Sparkz extends Scene {
  Spark hiSpark, midSpark, loSpark, eSpark;
  
  public Scene2_Sparkz(PGraphics parent) {
    this(parent, new Processor());
  }
  
  public Scene2_Sparkz(PGraphics parent, Processor processor) {
    super(parent, processor);
  }
  
  public void init(PGraphics parent) {
    println(parent);
    parent.background(0);
    hiSpark = new Spark(20, 300, -.001, color(random(255),random(255),random(255)), 5);
    midSpark = new Spark(20, 200, .001, color(random(255),random(255),random(255)), 5);
    loSpark = new Spark(20, 100, -.001, color(random(255),random(255),random(255)), 5);
    eSpark = new Spark(20, 50, .001, color(random(255),random(255),random(255)), 5);
  }
  
  public void onBeat(PGraphics parent, float val) {}
  
  public void onLowFreqBeat(PGraphics parent, float val) {}
  
  public void onMidFreqBeat(PGraphics parent, float val) {}
  
  public void onHighFreqBeat(PGraphics parent, float val) {}
  
  public void draw(PGraphics parent, float energy, float lfenergy, float mfenergy, float hfenergy) {
    parent.background(0, 85);
    
    hiSpark.decreaseAll(.05);
    midSpark.decreaseAll(.05);
    loSpark.decreaseAll(.05);
    eSpark.decreaseAll(.05);
    
    hiSpark.replace(hfenergy*500);
    midSpark.replace(mfenergy*5);
    loSpark.replace(lfenergy*5);
    eSpark.replace(energy*5);
    
    hiSpark.draw(parent);
    midSpark.draw(parent);
    loSpark.draw(parent);
    eSpark.draw(parent);
  }
}

class Spark {
  private color sparkColor;
  private int points, radius, strokeWeight;
  private float rotation, rotationSpeed;
  private SparkHeap sparkHeap;
  
  public Spark(int points, int radius, float rotationSpeed, color sparkColor, int strokeWeight) {
    this.points = points;
    this.radius = radius;
    this.rotationSpeed = rotationSpeed;
    this.rotation = 0f;
    this.sparkColor = sparkColor;
    this.strokeWeight = strokeWeight;
    
    sparkHeap = new SparkHeap(points);
  }
  
  public void draw(PGraphics parent) {
    SparkPoint[] arr = sparkHeap.getArray();
    parent.stroke(sparkColor);
    parent.strokeWeight(strokeWeight);
    parent.noFill();
    parent.beginShape();
    for (int i = 0; i < arr.length; i++) {
      SparkPoint s = arr[i];
      float r = radius + s.val;
      float t = (((float) s.order / (float) points) * 360 + rotation) % 360;
      float x = (parent.width / 2) + (r) * cos(t);
      float y = (parent.height / 2) + (r) * sin(t);
      parent.vertex(x,y);
      rotation = (rotation + rotationSpeed) % 360;
    }
    parent.endShape();
  }
  
  public void replace(float val) {
    sparkHeap.replaceRoot(val);
  }
  
  public void decreaseAll(float perD) {
    for (SparkPoint p : sparkHeap.getArray()) {
      p.val *= (1 - perD);
    }
  }
}

private class SparkHeap {
  private SparkPoint[] sparkPoints;
  private int index = 0;
  
  public SparkHeap(int numPoints) {
    sparkPoints = new SparkPoint[numPoints];
    while (index < numPoints) {
      insert(0f);
    }
  }
  
  public SparkPoint[] getArray() {
    return sparkPoints;
  }
  
  public void insert(float val) {
    SparkPoint parent, self;
    int tIndex, parentIndex; 
    
    tIndex = index;
    SparkPoint sp = new SparkPoint(val, index);
    sparkPoints[index++] = sp;
    
    while (tIndex > 0) {
      parentIndex = floor(tIndex/2);
      
      self = sparkPoints[tIndex];
      parent = sparkPoints[parentIndex];
      if (self.val < parent.val) {
        sparkPoints[tIndex] = parent;
        sparkPoints[parentIndex] = self;
        tIndex = parentIndex;
      } else {
        tIndex = 0;
      }
    }
  }
  
  public void replaceRoot(float val) {
    float retVal = sparkPoints[0].val;
    if (retVal < val) {
      sparkPoints[0].val = val;
      minHeapify();
    }
  }
  
  private void minHeapify() {
    SparkPoint parent, lChild, rChild;
    int index = 0, lChildIndex = (index*2) + 1, rChildIndex = (index*2) + 2;
    
    while (rChildIndex <= sparkPoints.length - 1 || lChildIndex <= sparkPoints.length - 1) {
      parent = sparkPoints[index];
      
      lChild = sparkPoints[lChildIndex];
      
      // for almost complete trees
      if (rChildIndex > sparkPoints.length - 1)
        rChild = null;
      else
        rChild = sparkPoints[rChildIndex];
      
      if (parent.val > lChild.val && (rChild == null || lChild.val <= rChild.val )) {
        sparkPoints[index] = lChild;
        sparkPoints[lChildIndex] = parent;
        index = lChildIndex;
      }
      else if (rChild !=  null && rChild.val <= lChild.val && parent.val > rChild.val) {
        sparkPoints[index] = rChild;
        sparkPoints[rChildIndex] = parent;
        index = rChildIndex;
      } else {
        break;
      }
      
      lChildIndex = (index*2) + 1;
      rChildIndex = (index*2) + 2;
    }
  }
  
  public void print() {
    for (SparkPoint v : sparkPoints) {
      println(v.val);
    }
  }
}

private class SparkPoint {
  public float val;
  public int order;
  
  public SparkPoint(float val, int order) {
    this.val = val;
    this.order = order;
  }
}