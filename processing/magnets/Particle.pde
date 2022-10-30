class Particle {
 
  PVector position;
  PVector velocity;
  
  Particle(float x, float y) {
    this.position = new PVector(x, y);
    this.velocity = PVector.random2D().setMag(random(1, 3));
  }
  
  Particle setVelocity(float x, float y) {
    this.velocity.set(x, y);
    return this;
  }
  
  void update(Magnet[] magnets) {
    PVector force = new PVector(0,0);
    
    for (Magnet magnet: magnets) {
      PVector direction = PVector.sub(magnet.position, this.position);
      float distance = direction.magSq();
      direction.setMag(500 / distance * (magnet.positive ? 1 : -1));
      force.add(direction);
    }
 
    this.velocity.add(force);
    this.position.add(this.velocity);
    
    if (this.position.x < 0 || this.position.x > width) {
      this.velocity.x *= -1; 
    }
    
    if (this.position.y < 0 || this.position.y > height) {
      this.velocity.y *= -1; 
    }
  }
  
  void show() {
    fill(255);
    stroke(0);
    circle(this.position.x, this.position.y, 12);
  }
  
  void showDebug() {
    stroke(255, 0, 0);
    strokeWeight(2);
    PVector velEnd = velocity.copy().setMag(50).add(position);
    line(position.x, position.y, velEnd.x, velEnd.y);
  }
}
