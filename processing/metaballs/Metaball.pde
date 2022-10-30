class Metaball {
  float x, y;
  PVector ballColor; // 0-1 range
  PVector velocity;
  
  Metaball(float x, float y) {
    this.x = x;
    this.y = y;
    
    float r = random(1);
    float g = 1 - r;
    this.ballColor = new PVector(r, g, 1.0);
    
    velocity = PVector.random2D().normalize().mult(random(1,1.5));
  }
  
  void update() {
    float newX = this.x + this.velocity.x;
    float newY = this.y + this.velocity.y;
    
    if (newX < 0 || newX > width) this.velocity.x *= -1;
    if (newY < 0 || newY > height) this.velocity.y *= -1;
    
    this.x = constrain(newX, 0, width);
    this.y = constrain(newY, 0, width);
  }
}
