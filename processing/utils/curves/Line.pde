class Line extends Curve {
  PVector start, end;
  
  Line(PVector start, PVector end) {
    this(start.x, start.y, end.x, end.y);
  }
  
  Line(float sx, float sy, float ex, float ey) {
    this.start = new PVector(sx, sy);
    this.end = new PVector(ex, ey);
  }
  
  PVector getPoint(float u) {
    PVector result = this.end.copy().sub(this.start);
    result.mult(u).add(this.start);
    return result;
  }

  PVector getNormal(float u) {
    PVector tangent = this.getTangent(u);
    return tangent.rotate(HALF_PI);
  }

  PVector getTangent(float u) {
    PVector result = this.end.copy().sub(this.start);
    result.normalize();
    return result;
  }
  
  void draw(int segments) {
    this.draw();
  }
  
  void draw() {
    line(this.start.x, this.start.y, this.end.x, this.end.y);
  }
}
