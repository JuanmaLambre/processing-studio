float NOISE_RADIUS = 3;
float zOffset = 0;
float radiusFactor = 0;

int colorIndex = 0;
color[] fillColors = new color[] {
  color(120, 0, 200),
  color(0, 120, 200),
  color(120, 200, 0),
  color(200, 0, 120),
  color(200, 120, 0)
};

void setup() {
  //fullScreen(P2D);
  size(900, 900, P2D);
  
  background(0);
}

void draw() {
  translate(width/2, height/2);
  
  beginShape(TRIANGLE_FAN);
  noStroke(); fill(0);
  vertex(0,0);
  fill(fillColors[colorIndex % fillColors.length]);
  for (float angle = 0; angle < TWO_PI + 0.01; angle += 0.01) {
    float noiseX = cos(angle) + 1;
    float noiseY = sin(angle) + 1;
    
    float noiseValue = noise(noiseX, noiseY, zOffset);
    float radius = map(noiseValue, 0, 1, height/4, height/2) * radiusFactor;
    float x = radius * cos(angle);
    float y = radius * sin(angle);
    vertex(x, y);
  }
  endShape(CLOSE);
  
  zOffset += 0.009;
  radiusFactor += 0.01;
  if (radiusFactor > -0.3*colorIndex+2.5) {
    radiusFactor = 0;
    colorIndex++;
    zOffset += 100;
  }
}
