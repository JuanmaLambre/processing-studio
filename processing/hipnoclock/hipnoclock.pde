Link[] chain;
float minAngle, maxAngle;

void mouseWheel(MouseEvent event) {
  LINK_RADIUS += event.getCount();
  println("LINK_RADIUS = " + LINK_RADIUS);
}

void setup() {
  config();
  
  size(800, 800);
  colorMode(HSB);
  noFill();
  
  chain = new Link[CHAIN_LENGTH];
  for (int i = 0; i < CHAIN_LENGTH; i++) {
    float angle = i * TWO_PI/CHAIN_LENGTH;
    chain[i] = new Link(CHAIN_RADIUS, angle);
  }
}

void draw() {
  translate(width/2, height/2);
  background(9);
  
  int iStart = (int) map(minAngle, 0, TWO_PI, 0, CHAIN_LENGTH);
  for (int i = iStart; i < iStart + CHAIN_LENGTH; i++) {
    Link link = chain[i % CHAIN_LENGTH];
    link.draw();
    if (link.isInsideArc(minAngle, maxAngle)) link.update();
  }
  
  minAngle += ANGLE_RANGE_SPEED;
  maxAngle += ANGLE_RANGE_SPEED;
  if (minAngle >= TWO_PI) {
    minAngle -= TWO_PI;
    maxAngle -= TWO_PI;
  } 
}
