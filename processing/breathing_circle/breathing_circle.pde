class CirclePath {
  float MAX_RADIUS = 450;
  float MIN_RADIUS = 200;
  
  float alpha;
  float offset;
  
  CirclePath(float alpha, float startOffset) {
    this.offset = startOffset;
    this.alpha = alpha;
  }
  
  void draw() {
    float radius = (sin(this.offset) / 2 + 0.5) * MAX_RADIUS + MIN_RADIUS; 
    
    noFill();
    strokeWeight(4);
    stroke(255, this.alpha);
    circle(0, 0, radius);
  }
  
  void update() {
    this.offset += 0.012;
  }
}

CirclePath[] circles = new CirclePath[] {
  new CirclePath(255.0 * 1 / 8, PI/2 * 1 / 16),
  new CirclePath(255.0 * 2 / 8, PI/2 * 2 / 16),
  new CirclePath(255.0 * 3 / 8, PI/2 * 3 / 16),
  new CirclePath(255.0 * 4 / 8, PI/2 * 4 / 16),
  new CirclePath(255.0 * 5 / 8, PI/2 * 5 / 16),
  new CirclePath(255.0 * 6 / 8, PI/2 * 6 / 16),
  new CirclePath(255.0 * 7 / 8, PI/2 * 7 / 16),
  new CirclePath(255.0 * 8 / 8, PI/2 * 8 / 16),
  //new CirclePath(255.0 * 9 / 8, PI/2 * 9 / 16),
  //new CirclePath(255.0 * 10 / 8, PI/2 * 10 / 16),
  //new CirclePath(255.0 * 11 / 8, PI/2 * 11 / 16),
}; 

void setup() {
  fullScreen();
}

void draw() {
  translate(width / 2, height / 2);
  background(0);
  
  for (CirclePath circlePath : circles) {
    circlePath.draw();
    circlePath.update();
  }
}
