class SVGPath extends CompoundCurve {
  private float[] viewbox;
  
  SVGPath(float minx, float miny, float x, float y) {
    super();
    this.viewbox = new float[] { minx, miny, x, y };
  }
  
  void draw(int segments) {
    for(Curve curve : curves) curve.draw(segments / curves.size()); 
  }
  
  void build(String definition) {
    this.curves.clear();
    
    String[] data = definition.split("[\\s,]+");
    PVector cursor = new PVector();
    int dataIdx = 0;
    
    while (dataIdx < data.length) {
      float[] xy;
      String command = data[dataIdx++];
      switch(command) {
         case "m":
         case "M":
           xy = this.getXY(data, dataIdx);
           dataIdx += 2;
           if (command.equals("m")) cursor.add(xy[0], xy[1]);
           else cursor.set(xy[0], xy[1]);
           break;
           
         case "l":
         case "L":
           PVector start = cursor.copy();
           xy = this.getXY(data, dataIdx);
           dataIdx += 2;
           if (command.equals("l")) cursor.add(xy[0], xy[1]);
           else cursor.set(xy[0], xy[1]);
           PVector end = cursor.copy();
           Line line = new Line(start, end);
           this.addCurve(line);
           break;
         
         case "c":
         case "C":
           PVector[] points = new PVector[4];
           points[0] = cursor.copy();
           int pointsCount = 1; //<>//
           
           while (dataIdx < data.length && !data[dataIdx].matches("[a-zA-Z]")) {
             xy = this.getXY(data, dataIdx);
             dataIdx += 2;
             
             if (command.equals("c")) cursor.add(xy[0], xy[1]);
             else cursor.set(xy[0], xy[1]);
             
             points[pointsCount++] = cursor.copy();
             if (pointsCount == 4) {
               CBezier bezier = new CBezier(points[0], points[1], points[2], points[3]);
               this.addCurve(bezier);
               pointsCount = 0;
             }
           }
           
           if (pointsCount > 0) 
             println(String.format("%d points have been left out from cubic Bezier definition", pointsCount));
           
           break;
      }
    }
  }
  
  private float[] getXY(String[] data, int idx) {    
    float x = Float.valueOf(data[idx++]);
    float y = Float.valueOf(data[idx++]);
    
    x = map(x, this.viewbox[0], this.viewbox[2], 0, width);
    y = map(y, this.viewbox[1], this.viewbox[3], 0, height);
    
    float[] result = new float[] { x, y };
    return result;
  }
}
