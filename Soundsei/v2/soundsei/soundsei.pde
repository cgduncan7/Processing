Scene scene;

void setup() {
  size(400, 400, P3D);
  scene = new Scene1_Beatboxes(this);
  scene.init(this);
}

void draw() {
  scene.step();
}