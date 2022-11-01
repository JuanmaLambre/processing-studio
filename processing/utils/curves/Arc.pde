class Arc extends Curve {
  float startAngle, endAngle;
  float radius;
  PVector center;
  
  Arc(float radius, float startAngle, float endAngle) {
    this(radius, startAngle, endAngle, 0, 0);
  }
  
  Arc(float radius, float startAngle, float endAngle, float cx, float cy) {
    this.startAngle = startAngle;
    this.endAngle = endAngle;
    this.radius = radius;
    this.center = new PVector(cx, cy);
  }
  
  PVector getPoint(float u) {
    float angle = map(u, 0, 1, this.startAngle, this.endAngle);
    PVector result = this.center.copy();
    result.x += this.radius * cos(angle);
    result.y += this.radius * sin(angle);
    return result;
  }

  PVector getNormal(float u) {
    float angle = map(u, 0, 1, this.startAngle, this.endAngle);
    return new PVector(cos(angle), sin(angle));
  }

  PVector getTangent(float u) {
    PVector tangent = this.getNormal(u);
    tangent.rotate(HALF_PI);
    return tangent;
  }
  
  float length() {
    return (this.endAngle - this.startAngle) * this.radius; 
  }
}
