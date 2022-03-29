float CHAIN_RADIUS = 300;
int CHAIN_LENGTH = 84;
float ANGLE_RANGE_SPEED = TWO_PI / (6 * frameRate); // Radians per frame

float LINK_RADIUS;
float LINK_SPEED = ANGLE_RANGE_SPEED * 0.2; // radians per frame

private void rainbowSpringConfig() {
  LINK_RADIUS = 600;
  strokeWeight(32);
}

private void chainConfig() { 
  LINK_RADIUS = 48;
  strokeWeight(2);
}

void config() {
  chainConfig();
  //rainbowSpringConfig();
  
  minAngle = 0;
  maxAngle = 4*PI/CHAIN_LENGTH;
}
