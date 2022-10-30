float d = 39;
float n = 1.95;

void setup() {
  size(displayHeight, displayHeight, P2D);
  //colorMode(HSB);
  cycleLength(frameRate);
}

void draw() {
  translate(width/2, height/2);
  background(0);
  
  //fill(255);
  //text(String.format("n = %f", n), -width/2, -height/2 + 12);
  //text(String.format("d = %f", d), -width/2, -height/2 + 24);
  
  noFill();
  //noStroke();
  beginShape();
  for (float i = 0; i <= 360; i += 1) {
    float k = i * d;
    
    float r = (height*0.9) / 2 * sin(radians(n*k));
    float theta = radians(k);
    
    //float hue;
    //hue = r * 255 / height / 2;
    //hue = ((i + 300) * 255 / 360) % 255;
    
    float red = i * 255.0 / 360.0;
    float green = 255 * sin(i * PI / 360.0) / 2;
    float blue = (360 - i) * 255.0 / 360.0;
    
    float alpha;
    //alpha = sin(radians(n*k));
    //alpha = 0.6;
    //alpha = sin(2*r*TWO_PI/height + HALF_PI)/2 + 0.5;
    alpha = r / (height*0.9) * 2;
    //alpha = i / 360;
    
    stroke(0, 255, 255, 255*alpha);
    //fill(red, green, blue, 255*alpha);
    
    float x = r * cos(theta);
    float y = r * sin(theta);
    vertex(x, y);
    //circle(x, y, 32);
  }
  endShape();
  
  //d += 0.001;
  n += 0.000051;
  
  //saveFrame("frames/####.png");
  
  if (n > 2.1) exit();
}
