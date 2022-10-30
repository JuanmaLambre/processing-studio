class Hexagon {
  static final float SIDE = 48;
  
  private final float ACTIVE_FRAMES = frameRate;
  
  PVector position;
  float framesActive;
  
  Hexagon(float x, float y) {
    this.position = new PVector(x, y);
  }
  
  void setActive() {
    if (this.framesActive == 0) this.framesActive = ACTIVE_FRAMES;
  }
  
  void update() {
    if (framesActive > 0) framesActive--;
  }
  
  void show() {
    float s = 1 + this.framesActive * 0.1 / ACTIVE_FRAMES;
    PShape hexa = createShape();
    filter(BLUR, 48);
    
    hexa.beginShape();
    hexa.fill(255);
    hexa.noStroke();
    for (float angle = 0; angle < 2*PI; angle += PI/3) {
      float x = SIDE * cos(angle);
      float y = SIDE * sin(angle);
      hexa.vertex(x, y);
    }
    hexa.scale(s);
    hexa.translate(this.position.x, this.position.y);
    hexa.endShape();
    
    shape(hexa);
  }
}
