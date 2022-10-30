// Properties:
//int AVG_DELAY = 55;
//int DELTA_DELAY = 10;
int SPRAY_RADIUS = 50;
int SPARKLE_MAX_RADIUS = 4;

int lastSpayed = 0;
int delay = 0;

class Circle {
  color fill = #00AAAA;
  
  float radius;
  PVector position;
  
  Circle(float r, float x, float y) {
    this.radius = r;
    this.position = new PVector(x, y);
  }
  
  void draw() {
    noStroke();
    fill(this.fill);
    circle(this.position.x, this.position.y, 2 * this.radius);
  }
}

void mouseDragged() {
  float r = SPRAY_RADIUS * random(1);
  float theta = TWO_PI * random(1);
  float x = r * cos(theta) + mouseX - width/2;
  float y = r * sin(theta) + mouseY - height/2;
  float sparkleRadius = random(SPARKLE_MAX_RADIUS);
  
  Circle circle = new Circle(sparkleRadius, x, y);
  circle.draw();
}

void keyPressed() {
  if (key == ' ') {
    background(0);
  }
}

void setup() {
  size(800, 600, P2D);
  background(0);
}

void draw() {
  translate(width/2, height/2);
}
