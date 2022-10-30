int X_MINOR_STEP = 10;
int X_MAJOR_STEP = 50;
int Y_MINOR_STEP = 10;
int Y_MAJOR_STEP = 50;

int draggingIndex = -1;

int[][] points;

float distSq(int[] p0, int px1, int py1) {
  return (px1 - p0[0])*(px1 - p0[0]) + (py1 - p0[1])*(py1 - p0[1]);
}

void drawGrids() {
  stroke(200);
  
  strokeWeight(1);
  for (int x = X_MINOR_STEP; x < width; x += X_MINOR_STEP) {
    line(x, 0, x, height);
  }
  
  for (int y = Y_MINOR_STEP; y < height; y += Y_MINOR_STEP) {
    line(0, y, width, y);
  }
  
  strokeWeight(2);
  for (int x = X_MAJOR_STEP; x < width; x += X_MAJOR_STEP) {
    line(x, 0, x, height);
  }
  
  for (int y = Y_MAJOR_STEP; y < height; y += Y_MAJOR_STEP) {
    line(0, y, width, y);
  }
}

void drawPoints() {
  noStroke();
  
  fill(200, 0, 120);
  for (int[] point : points) {
    circle(point[0], point[1], 12);
  }
  
  stroke(150);
  line(points[0][0], points[0][1], points[1][0], points[1][1]);
  line(points[2][0], points[2][1], points[3][0], points[3][1]);
}

void drawPointLabels() {
  fill(0);
  textSize(20);
  int offset = 16;
  for (int[] point : points) {
    int x;
    if (point[0] < width / 2) {
      x = point[0] + offset;
      textAlign(LEFT);
    } else {
      x = point[0] - offset;
      textAlign(RIGHT);
    }
    
    int y = point[1] + (point[1] < height / 2 ? 2 * offset : -offset);
    String coords = String.format("(%d; %d)", point[0], point[1]);
    
    text(coords, x, y);
  }
}

void drawBezier() {
  noFill();
  stroke(0);
  beginShape();
  for (float t = 0; t < 1; t += 0.01) {
    float x = pow(1-t, 3) * points[0][0] + 
        3 * pow(1-t, 2) * t * points[1][0] +
        3 * (1-t) * pow(t, 2) * points[2][0] +
        pow(t, 3) * points[3][0];
    float y = pow(1-t, 3) * points[0][1] + 
        3 * pow(1-t, 2) * t * points[1][1] +
        3 * (1-t) * pow(t, 2) * points[2][1] +
        pow(t, 3) * points[3][1];
    vertex(x, y);
  }
  endShape();
}

void keyPressed() {
  if (key == ' ') {
    println(String.format("(%d; %d)", points[0][0], points[0][1])); 
    println(String.format("(%d; %d)", points[1][0], points[1][1])); 
    println(String.format("(%d; %d)", points[2][0], points[2][1])); 
    println(String.format("(%d; %d)", points[3][0], points[3][1])); 
    println();
  }
}

void mouseDragged() {
  points[draggingIndex] = new int[] { mouseX, mouseY };
}

void mousePressed() {
  float closestDistance = 99999;
  for (int i = 0; i < 4; i++) {
    float distance = distSq(points[i], mouseX, mouseY);
    if (distance < closestDistance) {
      closestDistance = distance;
      draggingIndex = i;
    }
  }
}

void setup() {
  //fullScreen();
  size(500, 900);
  background(255);
  
  points = new int[][] {
    { int(random(width)), int(random(height)) },
    { int(random(width)), int(random(height)) },
    { int(random(width)), int(random(height)) },
    { int(random(width)), int(random(height)) },
  };
}

void draw() {
  background(255);
  
  drawGrids();
  
  drawPoints();
  drawPointLabels();
  
  drawBezier();
}
