class SVGPath {
  private ArrayList<Curve> curves;
  private float[] viewbox;
  
  SVGPath(float minx, float miny, float x, float y) {
    this.curves = new ArrayList();
    this.viewbox = new float[] { minx, miny, x, y };
  }
  
  void draw(int segmentsPerCurve) {
    for(Curve curve : curves) curve.draw(segmentsPerCurve); 
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
           this.curves.add(line);
           break;
         
         case "c":
         case "C":
           CBezier curve = new CBezier(); //<>//
           curve.addPoint(cursor);
           
           while (dataIdx < data.length && !data[dataIdx].matches("[a-zA-Z]")) {
             xy = this.getXY(data, dataIdx);
             dataIdx += 2;
             if (command.equals("c")) cursor.add(xy[0], xy[1]);
             else cursor.set(xy[0], xy[1]);
             curve.addPoint(cursor);
           }
           
           this.curves.add(curve);
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
