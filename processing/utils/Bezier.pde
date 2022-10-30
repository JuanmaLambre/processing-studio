class BezierPath {
  
  ArrayList<BezierCurve> curves = new ArrayList();
  BezierCurve currentCurve = null;
  
  BezierPath appendCurves(BezierCurve ...curves) {
    for (BezierCurve curve : curves) {
      this.curves.add(curve);
      
      if (this.currentCurve == null) 
        this.currentCurve = curve;
    }

    return this;
  }
  
  PVector getPoint() {
    return this.currentCurve.getPoint();
  }
  
  void update() {
    this.currentCurve.update();
    if (this.currentCurve.getTime() > 1) {
      int nextIndex = this.curves.indexOf(this.currentCurve) + 1;
      if (nextIndex < this.curves.size()) {
        this.currentCurve = this.curves.get(nextIndex);
      }
    }
  }
}

class BezierCurve {
  
  PVector p0, p1, p2, p3;
  float t = 0;
  float speed = 0.05;
  
  BezierCurve(PVector p0, PVector p1, PVector p2, PVector p3) {
    this.p0 = p0;
    this.p1 = p1;
    this.p2 = p2;
    this.p3 = p3;
  }
  
  BezierCurve setSpeed(float s) {
    this.speed = s;
    return this;
  }
  
  BezierCurve setTime(float t) {
    this.t = t;
    return this;
  }
  
  float getTime() {
    return this.t;
  }
  
  void update() {
    this.t += this.speed;
  }
  
  PVector getPoint(float t) {
    return PVector.mult(p0, pow(1-t, 3))
        .add(PVector.mult(p1, 3 * pow(1-t, 2) * t))
        .add(PVector.mult(p2, 3 * (1-t) * t * t))
        .add(PVector.mult(p3, pow(t, 3)));
  }
  
  PVector getPoint() {
    return this.getPoint(this.t); 
  }
  
  BezierCurve buildNextCurve(PVector pB, PVector pC) {
    // This method will return a continuos and derivable curve
    // pA is a reflection of p2 over p3, in order to make the derivative continous
    PVector pA = PVector.mult(this.p3, 2).sub(this.p2);
    return this.buildNextCurve(pA, pB, pC);
  }
  
  BezierCurve buildNextCurve(PVector pA, PVector pB, PVector pC) {
    return new BezierCurve(p3, pA, pB, pC);
  }
  
}
