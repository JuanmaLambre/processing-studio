class FadingCircle {
  float radius;
  color fillColor;
  PVector center;
  PVector velocity;
  float fadingRate;
  int frame;
  
  FadingCircle() {
    this.velocity = PVector.random2D();
    this.center = new PVector(0, 0);
    this.fillColor = color(0);
    this.radius = 10;
    this.fadingRate = 4;
    this.frame = 0;
  }
  
  FadingCircle setRadius(float r) {
    this.radius = r;
    return this;
  }
  
  FadingCircle setColor(int r, int g, int b) {
    // RGB in (0,255) mode
    this.fillColor = color(r, g, b);
    return this;
  }
  
  FadingCircle setPosition(int x, int y) {
    this.center.set(x, y);
    return this;
  }
  
  FadingCircle setFadingRate(float rate) {
    this.fadingRate = rate;
    return this;
  }
  
  boolean isFaded() {
    int alpha = 255 - int(frame * this.fadingRate);
    return alpha <= 0;
  }
  
  void update() {
    frame++;
    this.center.add(this.velocity);
  }
  
  void show() {
    int alpha = 255 - int(frame * this.fadingRate);
    noStroke();
    fill(this.fillColor, alpha);
    circle(this.center.x, this.center.y, this.radius);
  }
  
}
