Square squares[];

void setup() {
  size(480, 480, P2D);
  colorMode(HSB);
  background(0);

  int squaresCount = 14;
  squares = new Square[squaresCount];
  for (int i = 0; i < squaresCount; i++) {
    float x = maxSqSide * i;
    float y = x;
    float offset = i * TWO_PI / squaresCount;
    squares[i] = new Square(x, y, offset);
  }
}

void draw() {
  background(0);

  for (Square sq : squares) {
    sq.draw();
    sq.update();
  }
}
