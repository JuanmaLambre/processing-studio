class Magnet {
 
  PVector position;
  boolean positive;
  
  Magnet(float x, float y, boolean positive) {
    this.position = new PVector(x, y);
    this.positive = positive;
  }
  
  void show() {
    color c = this.positive ? color(0, 200, 200) : color(255, 0, 100);
    fill(c);
    stroke(0);
    circle(position.x, position.y, 16);
  }
  
}
