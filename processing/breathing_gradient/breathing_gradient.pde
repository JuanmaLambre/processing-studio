color centerColor = #ff00ff, outerColor = #ffff00;
float t = 0, tSpeed = 0.04;

void setup() {
  size(800, 600, P2D);
  background(0);
  
  stroke(255);
  strokeWeight(3);
  noFill();
}

void draw() {
  float inter = (sin(t) + 1) / 8;
  color outer = lerpColor(outerColor, centerColor, inter);
 
  radialGradient(400, 300, 200, centerColor, outer);
  
  t += tSpeed;
}

void radialGradient(int x, int y, int radius, color center, color outer) { 
  noStroke();
  
  for (int r = radius; r >= 0; r--) {
    float inter = map(r, 0, radius, 0, 1);
    color c = lerpColor(center, outer, inter);
    fill(c);
    circle(x, y, 2*r); 
  }
}
