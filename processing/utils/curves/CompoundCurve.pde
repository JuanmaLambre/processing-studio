class CompoundCurve extends Curve {
  class CurveRef {
    public Curve curve;
    public float u;
  }
  
  protected ArrayList<Curve> curves;
  
  CompoundCurve(Curve... curves) {
    this.curves = new ArrayList(curves.length);
    for (Curve curve : curves) this.curves.add(curve);
  }
  
  PVector getPoint(float u) {
    CurveRef ref = this.getCurveRef(u);
    return ref.curve.getPoint(ref.u);
  }

  PVector getNormal(float u) {
    CurveRef ref = this.getCurveRef(u);
    return ref.curve.getNormal(ref.u);
  }

  PVector getTangent(float u) {
    CurveRef ref = this.getCurveRef(u);
    return ref.curve.getTangent(ref.u);
  }
  
  float length() {
    float length = 0;
    for (Curve curve : this.curves) length += curve.length();
    return length;
  }
  
  void addCurve(Curve curve) {
    this.curves.add(curve);
  }
  
  private CurveRef getCurveRef(float globalU) {
    CurveRef ref = new CurveRef();
    float totalLength = this.length();
    float u = 0;
    int  curveIdx = 0;
    
    while (ref.curve == null) {
      Curve curve = this.curves.get(curveIdx);
      float parametricLength = curve.length() / totalLength;
      
      if (u + parametricLength >= globalU) {
        ref.curve = curve;
        ref.u = map(globalU, u, u + parametricLength, 0, 1);
      }
      
      u += parametricLength;
      curveIdx = (curveIdx + 1) % this.curves.size();
    }
    
    return ref;
  }
    
}
