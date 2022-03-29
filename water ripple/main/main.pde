// float DAMPING = 0.99; // Trippy
float DAMPING = 0.95;

float[][][] current;
float[][][] previous;

void setup() {
  size(800, 450);
  colorMode(RGB, 255, 255, 255);
  current = new float[width][height][3];
  previous = new float[width][height][3];
}

void mousePressed() {
  int SIZE = 2;
  float[] newColor = new float[] { random(1), random(1), random(1) };

  for (int x = mouseX - SIZE; x < mouseX + SIZE; x++) {
    for (int y = mouseY - SIZE; y < mouseY + SIZE; y++) {
      current[x][y] = newColor;
    }
  }
}

void draw() {
  loadPixels();
  
  for (int x = 1; x < width - 1; x++) {
     for (int y = 1; y < height - 1; y++) {
       float currentRed = (
           previous[x-1][y][0] +
           previous[x+1][y][0] + 
           previous[x][y+1][0] +
           previous[x][y-1][0]
         ) / 2 - current[x][y][0];
         
        float currentGreen = (
           previous[x-1][y][1] +
           previous[x+1][y][1] + 
           previous[x][y+1][1] +
           previous[x][y-1][1]
         ) / 2 - current[x][y][1];
         
        float currentBlue = (
           previous[x-1][y][2] +
           previous[x+1][y][2] + 
           previous[x][y+1][2] +
           previous[x][y-1][2]
         ) / 2 - current[x][y][2];
         
         
         current[x][y][0] = currentRed * DAMPING;
         current[x][y][1] = currentGreen * DAMPING;
         current[x][y][2] = currentBlue * DAMPING;
          
         float[] colorRef = current[x][y];
         pixels[x + y * width] = color(
           colorRef[0] * 255,
           colorRef[1] * 255,
           colorRef[2] * 255
         );
     }
  }
  
  float[][][] swapAux = previous;
  previous = current;
  current = swapAux;
  
  updatePixels();
}
