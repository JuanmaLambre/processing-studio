
PShader shader;

void setup() {
  size(500, 500, P2D);
  shader = loadShader("shader.glsl");
}

void draw() {
  //shader(shader);
  fill(100, 0, 250);
  rect(0, 0, width, height);
  fill(200, 0, 100);
  ellipse(250, 150, 60, 110);
}
