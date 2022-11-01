/** Cuadratic Bezier */
class CBezier extends Curve {
  private PVector[] points;
  private float length;
  
  CBezier(PVector p0, PVector c0, PVector c1, PVector p1) {
    this.points = new PVector[] { p0.copy(), c0.copy(), c1.copy(), p1.copy() };
    this.length = this.calculateLength();
  }
  
  float length() {
    return this.length;
  }
  
  PVector getPoint(float u) {
    PVector p0 = this.points[0];
    PVector p1 = this.points[1];
    PVector p2 = this.points[2];
    PVector p3 = this.points[3];
    
    PVector result = p0.copy().mult(pow(1 - u, 3));
    result.add(p1.copy().mult(3 * u * pow(1 - u, 2)));
    result.add(p2.copy().mult(3 * pow(u, 2) * (1 - u)));
    result.add(p3.copy().mult(pow(u, 3)));
    
    return result;
  }

  PVector getNormal(float u) {
    PVector tangent = this.getTangent(u);
    return tangent.rotate(HALF_PI);
  }

  PVector getTangent(float u) {
    // TODO: Maybe implement this?
    // https://en.wikipedia.org/wiki/B%C3%A9zier_curve#Cubic_B%C3%A9zier_curves
    float delta = 0.001;
    PVector p0 = this.getPoint(u - delta);
    PVector p1 = this.getPoint(u + delta);
    PVector result = p1.sub(p0).normalize();
    return result;
  }
  
  String toString() {
    String str = "CBezier";
    for (PVector point : this.points) {
      str += String.format(" (%f; %f)", point.x, point.y);
    }
    return str;
  }
  
  private float calculateLength() {
    int steps = 256;
    PVector prev = this.getPoint(1f / steps);
    float length = 0;
    
    for (int i = 1; i <= steps; i++) {
      PVector cur = this.getPoint(1f * i/steps);
      length += cur.dist(prev);
      prev.set(cur);
    }
    
    return length;
  }
}
