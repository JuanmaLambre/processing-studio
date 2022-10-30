/** Cuadratic Bezier */
class CBezier extends Curve {
  private ArrayList<PVector> points;
  
  CBezier() {
    this.points = new ArrayList(4); 
  }
  
  void addFirstPoint(float x, float y) {
    if (this.points.size() == 0) this.addPoint(x, y);
  }
  
  void addPoint(float x, float y) {
     points.add(new PVector(x, y));
  }
  
  void addPoint(PVector p) {
     points.add(p.copy());
  }
  
  PVector getPoint(float u) {
    int sections = (int) Math.floor((points.size() - 1) / 3f);
    float sectionLength = 1f / sections;
    int sectionNo = (int) Math.floor(u / sectionLength);
    if (u == 1) sectionNo--;
    float sectionU = (u % sectionLength) / sectionLength;
    if (u == 1) sectionU = sectionLength;
    int firstPointIdx = sectionNo == 0 ? 0 : sectionNo * 3 + 1;
    
    PVector p0 = this.points.get(firstPointIdx);
    PVector p1 = this.points.get(firstPointIdx + 1);
    PVector p2 = this.points.get(firstPointIdx + 2);
    PVector p3 = this.points.get(firstPointIdx + 3);
    
    PVector result = p0.copy().mult(pow(1 - sectionU, 3));
    result.add(p1.copy().mult(3 * sectionU * pow(1 - sectionU, 2)));
    result.add(p2.copy().mult(3 * pow(sectionU, 2) * (1 - sectionU)));
    result.add(p3.copy().mult(pow(sectionU, 3)));
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
}
