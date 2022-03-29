int OFF1 = 999;

void mousePressed() {
  exit();
}

void setup() {
  fullScreen();
  //frameRate(30);
}

void draw() {
  translate(width/2, height/2);
  background(0);

  noFill();

  float timeOff = frameCount * 0.007;
  for (float j = timeOff; j < timeOff + 0.5; j += 0.01) {
    float alpha = 255 * sin(PI * 2 * (j-timeOff));
    float p = (j - timeOff) * 2;
    
    // Processing bug: shape.stroke will be set to white in this case
    if (alpha == 0) continue;
    
    PShape shape1 = createShape();
    PShape shape2 = createShape();
    
    shape1.beginShape();
    shape2.beginShape();
    
    shape1.stroke(200*p, 0, 200*(1-p), alpha);
    shape2.stroke(200*(1-p), 200*p, 0, alpha);
    
    for (float i = 0; i < 1; i += 0.01) {
      float iOffset = frameCount * 0.001 + i;
      float y = height * (noise(2*i, j) - 0.5) + 100*(sin(10*iOffset));
      float x = (i-0.5) * width;
      shape1.vertex(x, y);
      
      y = height * (noise(2*i + OFF1, j) - 0.5) + 100*(cos(10*iOffset));
      shape2.vertex(x, y);
    }
    
    shape1.endShape();
    shape2.endShape();
    
    shape(shape1);
    shape(shape2);
  }
  
  saveFrame();
  if (frameCount > 30 * 10) exit();
}
