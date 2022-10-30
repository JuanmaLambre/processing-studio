abstract class Curve {
  abstract PVector getPoint(float u); 

  abstract PVector getNormal(float u); 

  abstract PVector getTangent(float u); 
  
  void draw(int segments) {
    beginShape();  //<>//
    for (int i = 0; i <= segments; i++) {
      float u = 1f * i/segments;
      PVector point = this.getPoint(u);
      vertex(point.x, point.y);
    }
    endShape();
  }
}
