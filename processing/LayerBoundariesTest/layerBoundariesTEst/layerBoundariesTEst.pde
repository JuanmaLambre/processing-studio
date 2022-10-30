
class Circle {
  PVector position;
  float radius;

  Circle(float x, float y, float r) {
    this.position = new PVector(x, y);
    this.radius = r;
  }

  void draw() {
    strokeWeight(2);
    stroke(0);
    circle(this.position.x, this.position.y, this.radius * 2);
  }
}

Circle circles[];

void drawVector(PVector v) {
  drawVector(v, new PVector());
}

void drawVector(PVector v, PVector offset) {
  strokeWeight(2);
  stroke(200, 0, 0);

  PVector end = PVector.add(v, offset);
  line(offset.x, offset.y, end.x, end.y);
}

void drawPointAt(PVector v) {
  strokeWeight(8);
  stroke(200, 0, 0);
  circle(v.x, v.y, 2);
}

void drawPointAt(float x, float y) {
  drawPointAt(new PVector(x, y));
}

PVector[] getContactPoints(Circle circleA, Circle circleB) {
  PVector cBPrime = circleB.position.copy().sub(circleA.position);
  float rotationAngle = cBPrime.heading();
  cBPrime.rotate(-rotationAngle);

  PVector d = cBPrime;
  float alpha = asin((circleB.radius - circleA.radius) / d.mag());
  float h = circleB.radius - circleA.radius;

  float xA = circleA.radius * sin(alpha);
  float yA = circleA.radius * cos(alpha);

  float xB = circleB.radius * sin(alpha);
  float yB = circleB.radius * cos(alpha);

  PVector pA = new PVector(-xA, -yA);
  PVector pB = new PVector(cBPrime.x - xB, -cBPrime.y - yB);

  pA.rotate(rotationAngle).add(circleA.position);
  pB.rotate(rotationAngle).add(circleA.position);

  return new PVector[] { pA, pB };
}

Circle nearest;
void mousePressed() {
  PVector mousePos = new PVector(mouseX - width/2, - mouseY + height/2);
  float minDist = 999999999;
  
  for (Circle circle : circles) {
    float dist = mousePos.dist(circle.position);
    if (dist < minDist) {
      minDist = dist;
      nearest = circle;
    }
  }
}

void mouseDragged() {
  nearest.position.set(mouseX - width/2, - mouseY + height/2);
}

void setup() {
  fullScreen(P2D);

  circles = new Circle[] {
    new Circle(-100, 0, 80), 
    new Circle(400, 0, 200), 
    new Circle(-200, 200, 100)
  };
}

void draw() {
  translate(width/2, height/2);
  scale(1, -1);
  background(255);

  for (Circle circle : circles) circle.draw();

  for (int i = 1; i < circles.length; i++) {
    Circle circleA = circles[i-1];
    Circle circleB = circles[i];
    PVector[] contacts = getContactPoints(circleA, circleB);
    PVector pA = contacts[0];
    PVector pB = contacts[1];
    drawPointAt(pA);
    drawPointAt(pB);

    strokeWeight(2);
    line(pA.x, pA.y, pB.x, pB.y);
  }

}
