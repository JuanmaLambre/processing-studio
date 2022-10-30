float SPACE = 120;
float hDistance = 3*Hexagon.SIDE + sqrt(3)*SPACE;
float vDistance = sqrt(3.0/4.0)*Hexagon.SIDE + SPACE/2.0;
float xOffset = -random(Hexagon.SIDE);
float yOffset = -random(Hexagon.SIDE);
  
ArrayList<Hexagon> hexagons = new ArrayList();

Hexagon getNearestAt(float x, float y) {
  // Could be optimized knowing the x and y offsets
  
  for (Hexagon hexagon : hexagons) {
    float d = dist(hexagon.position.x, hexagon.position.y, x, y);
    if (d < Hexagon.SIDE) return hexagon;
  }
  
  return null;
}


void setup() {
  fullScreen(P2D);
  
  int xMult = 0;
  
  //for (float y = yOffset; y < height + Hexagon.SIDE; y += vDistance) {
  //  float xInit = xMult * hDistance/2 + xOffset;
  //  for (float x = xInit; x < width + Hexagon.SIDE; x += hDistance) {
  //    hexagons.add(new Hexagon(x, y));
  //  }
    
  //  // Toggle between 0 and 1 
  //  xMult = -(xMult - 1);
  //}
  
  hexagons.add(new Hexagon(width/2, height/2));
}

void draw() {
  background(0);
  
  for (Hexagon hexagon : hexagons) {
    hexagon.show();
    hexagon.update();
  }
  
  //Hexagon nearest = getNearestAt(mouseX, mouseY);
  //if (nearest != null) nearest.setActive();
}
  
