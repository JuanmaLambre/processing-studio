

/* As in chain link */
class Link {
  PVector polarPosition;
  color strokeColor;
  
  Link(float r, float angle) {
    polarPosition = new PVector(r, angle);
    float h = map(polarPosition.y, 0, TWO_PI, 0, 255);
    strokeColor = color(h, 255, 255);
  }
  
  float getAngle() {
    return polarPosition.y;
  }
  
  boolean isInsideArc(float minAngle, float maxAngle) {
    float linkAngle = getAngle();
    
    if (maxAngle >= TWO_PI && linkAngle < minAngle) {
      linkAngle += TWO_PI;
    }
    
    return minAngle <= linkAngle && linkAngle < maxAngle; 
  }
  
  void draw() {
    stroke(strokeColor);
    float x = polarPosition.x * cos(polarPosition.y);
    float y = polarPosition.x * sin(polarPosition.y);
    circle(x, y, LINK_RADIUS);
  }
  
  void update() {
    polarPosition.y += LINK_SPEED;
    if (polarPosition.y >= TWO_PI) polarPosition.y -= TWO_PI;
  }
}
