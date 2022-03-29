float xSpeed = 1.0;
float ySpeed = -0.8;
float factorPeriod = 3; // Seconds to go back to normal size
float maxSqSide = 40;

class Square {

  float position[];
  float side;
  float sideFactorOffset;
  color fillColor;
  
  Square(float x, float y, float offset) {
    position = new float[] { x, y };
    side = maxSqSide;
    sideFactorOffset = offset;
    println(offset * 255.0 / TWO_PI);
    fillColor = color(offset/4 * 255.0 / HALF_PI, 120, 255);
  }
  
  void draw() {
    fill(this.fillColor);
    noStroke();
    square(this.position[0], this.position[1], side);
  }
  
  void update() {
    this.position[0] += xSpeed;
    this.position[1] += ySpeed;
    
    float margin = maxSqSide;
    if (this.position[0] < -margin) this.position[0] += width + 2*margin;
    if (this.position[0] > width + margin) this.position[0] -= width + 2*margin;
    if (this.position[1] < -margin) this.position[1] += height + 2*margin;
    if (this.position[1] > height + margin) this.position[1] -= height + 2*margin;
    
    float seconds = 1.0 * frameCount / frameRate;
    float angle = seconds * TWO_PI / factorPeriod;
    float sideFactor = sin(angle + this.sideFactorOffset) / 4 + 0.75;
    this.side = maxSqSide * sideFactor;
  }
}
