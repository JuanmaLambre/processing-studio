
void setup() {
  size(600, 600, P3D);
  camera(0, 0, -100, 0, 0, 0, 0, -1, 0);
}

void draw() {
  background(50);
  
  stroke(200, 0, 0);
  line(0, 0, 0, width/5, 0, 0);
  
  stroke(0, 200, 0);
  line(0, 0, 0, 0, width/5, 0);
  
  stroke(0, 0, 200);
  line(0, 0, 0, 0, 0, width/5);
  
  if (mousePressed && mouseButton == LEFT) {
    float sensitivity = 0.1;
    float deltaX = -sensitivity * (mouseX - pmouseX);
    float deltaY = sensitivity * (mouseY - pmouseY);
    beginCamera();
    translate(deltaX, deltaY);
    endCamera();
  } else if (mousePressed && mouseButton == RIGHT) {
    float sensitivity = 0.01;
    float deltaX = -sensitivity * (mouseX - pmouseX);
    float deltaY = sensitivity * (mouseY - pmouseY);
    beginCamera();
    rotateX(deltaY);
    rotateY(deltaX);
    endCamera();
  }
}
