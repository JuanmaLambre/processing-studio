float NOISE_FACTOR = 0.01;

float timeOffset = random(100);

void setPixel(int x, int y, color rgba) {
  int index = x + y * width;
  pixels[index] = rgba;
}

void setup() {
  size(800, 450);
  pixelDensity(1);
}

void draw() {
  timeOffset += 0.003; 
  
  loadPixels();
  
  for (int i = 0; i < width; i++) {
    for (int j = 0; j < height; j++) {
        float noiseValue = noise(i * NOISE_FACTOR, j * NOISE_FACTOR, timeOffset);
        setPixel(i, j, color(noiseValue * 255));
    }
  }
    
  updatePixels();
}
