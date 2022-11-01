/** CompoundCurve with only straight lines */
class DiscreteCurve extends CompoundCurve {
  private PVector firstPoint;
  
  DiscreteCurve() {
    super();
  }
  
  void addPoint(float x, float y) {
    this.addPoint(new PVector(x, y));
  }
  
  void addPoint(PVector point) {
    if (this.firstPoint == null) {
      this.firstPoint = point.copy();
      return;
    }
    
    PVector newStart;
    
    if (this.curves.size() == 0) {
      // At this point, firstPoint is already set
      newStart = firstPoint.copy();
    } else {
      int lastIdx = this.curves.size() - 1;
      Line lastLine = (Line) this.curves.get(lastIdx);
      newStart = lastLine.end;
    }

    Line newLine = new Line(newStart, point);
    this.addCurve(newLine);
  }
  
}
