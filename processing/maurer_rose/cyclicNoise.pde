float cycleLength = 1;

void cycleLength(float len) {
  cycleLength = len;
}

float cyclicNoise(float off) {
  float radius = cycleLength / TWO_PI;
  float x = radius * cos(off);
  float y = radius * sin(off);
  return noise(x, y);
}
