Scene scene;
PGraphics pg;

void setup() {
  size(1000, 1000, P3D);
  frameRate(120);
  pg = createGraphics(1000,1000);
  //pg.beginDraw();
  //pg.endDraw();
  //while (pg == null) ;
  scene = new Scene2_Sparkz(pg);
  scene.init();
}

void draw() {
  scene.step();
  image(pg, 0, 0, width, height);
}