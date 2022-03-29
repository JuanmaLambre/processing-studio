float cyclicNoise(float off, float radius) {
  float x = radius * cos(off);
  float y = radius * sin(off);
  return noise(x, y);
}

float cylcicNoise(float off) {
  return cyclicNoise(off, 1);
}
