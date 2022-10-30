int TAILS_COUNT = 20;
float TAILS_LENGTH = 1; // In radians
float DELTA = PI/200;
float RADIAL_PEAKS = 6;

float INNER_RADIUS = 50;

float theta = -PI;
PShape[] fellows;

void setup() {
  fullScreen(P2D);
}

void createFellows(int count) {
  fellows = new PShape[count];
  for (int i = 0; i < count; i++) fellows[i] = createShape();
}

void beginFellows() {
  for (int i = 0; i < fellows.length; i++) fellows[i].beginShape();
}

void endFellows() {
  for (int i = 0; i < fellows.length; i++) {
    fellows[i].endShape();
    shape(fellows[i]);
  }
}

void draw() {
  translate(width/2, height/2);
  
  background(0);
  
  noFill();
  createFellows(9);
  beginFellows();
  for (int i = 0; i < TAILS_COUNT; i++) {
    float alpha = map(i, 0, TAILS_COUNT-1, 255, 100);
    
    // Inner Cyan fellow
    float angle = theta + TAILS_LENGTH/TAILS_COUNT * i;
    float radius = 50*(cos(angle*RADIAL_PEAKS)+1) + 100;
    float x = radius * cos(angle);
    float y = radius * sin(angle);
    fellows[0].stroke(0, 190, 255, alpha);
    fellows[0].strokeWeight(4);
    fellows[0].vertex(x, y);
    
    // Inner Magenta fellow
    angle += 2*PI/3;
    radius = 50*(cos(angle*RADIAL_PEAKS)+1) + 100;
    x = radius * cos(angle);
    y = radius * sin(angle);
    fellows[1].stroke(255, 0, 190, alpha);
    fellows[1].strokeWeight(4);
    fellows[1].vertex(x, y);
    
    // Inner Yellow fellow
    angle += 2*PI/3;
    radius = 50*(cos(angle*RADIAL_PEAKS)+1) + 100;
    x = radius * cos(angle);
    y = radius * sin(angle);
    fellows[2].stroke(190, 255, 0, alpha);
    fellows[2].strokeWeight(4);
    fellows[2].vertex(x, y);
    
    alpha /= 1.2;
    
    // Outer Cyan fellows
    angle = PI + PI/24 + theta + TAILS_LENGTH/TAILS_COUNT * i/6;
    radius = 50*(cos(angle*RADIAL_PEAKS*4)+1) + 200;
    x = radius * cos(angle);
    y = radius * sin(angle);
    fellows[3].stroke(0, 190, 255, alpha);
    fellows[3].strokeWeight(4);
    fellows[3].vertex(x, y);
    
    angle += 3*PI/24;
    radius = 50*(cos(angle*RADIAL_PEAKS*4)+1) + 200;
    x = radius * cos(angle);
    y = radius * sin(angle);
    fellows[4].stroke(0, 190, 255, alpha);
    fellows[4].strokeWeight(4);
    fellows[4].vertex(x, y);
    
    // Outer Magenta fellows
    angle += 2*PI/3 - 3*PI/24; 
    radius = 50*(cos(angle*RADIAL_PEAKS*4)+1) + 200;
    x = radius * cos(angle);
    y = radius * sin(angle);
    fellows[5].stroke(255, 0, 190, alpha);
    fellows[5].strokeWeight(4);
    fellows[5].vertex(x, y);
    
    angle += 3*PI/24;
    radius = 50*(cos(angle*RADIAL_PEAKS*4)+1) + 200;
    x = radius * cos(angle);
    y = radius * sin(angle);
    fellows[6].stroke(255, 0, 190, alpha);
    fellows[6].strokeWeight(4);
    fellows[6].vertex(x, y);
    
    // Outer Yellow fellows
    angle += 2*PI/3 - 3*PI/24; 
    radius = 50*(cos(angle*RADIAL_PEAKS*4)+1) + 200;
    x = radius * cos(angle);
    y = radius * sin(angle);
    fellows[7].stroke(190, 255, 0, alpha);
    fellows[7].strokeWeight(4);
    fellows[7].vertex(x, y);
    
    angle += 3*PI/24;
    radius = 50*(cos(angle*RADIAL_PEAKS*4)+1) + 200;
    x = radius * cos(angle);
    y = radius * sin(angle);
    fellows[8].stroke(190, 255, 0, alpha);
    fellows[8].strokeWeight(4);
    fellows[8].vertex(x, y);
  }
  endFellows();
  
  //noLoop();
  
  theta -= DELTA;  
}
