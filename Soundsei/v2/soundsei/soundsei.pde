Scene scene;
PGraphics pg;

void setup() {
  size(800, 800);
  frameRate(120);
  pg = createGraphics(800,800);
  //pg.beginDraw();
  //pg.endDraw();
  //while (pg == null) ;
  scene = new Scene3_Walkers(pg);
  scene.init();
}

void draw() {
  scene.step();
  image(pg, 0, 0, width, height);
}