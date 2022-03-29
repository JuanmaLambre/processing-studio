class Snowflake {
  static final float NOISE_AMPLITUDE = 100f;

  // Instance constants
  float radialStep;
  float noiseStep;
  float angle;

  // State arguments
  float radialPos;
  float noiseOff;
  
  Snowflake() {
    radialStep = random(2.5, 3.5);
    noiseStep = random(0.007, 0.012);
    angle = random(0, 2*PI);
     
    radialPos = 0;
    noiseOff = random(0, 9999);
  }

  void update() {
    radialPos += radialStep;
    noiseOff += noiseStep;
  }

  void draw() {
    float x = this.radialPos;
    float y = (noise(this.noiseOff) - 0.5) * NOISE_AMPLITUDE;
    float rotatedX = x * cos(angle) - y * sin(angle);
    float rotatedY = y * cos(angle) + x * sin(angle);
    noStroke();
    fill(255, 255, 255, 128);
    float b = 0.2;
    float a = -6.0f / (35*350f);
    float r = 1f / (a * this.radialPos + b);
    circle(rotatedX, rotatedY, r);
  }
}

Snowflake[] snowflakes = new Snowflake[100];

void setup() {
  size(500, 500);
  background(0);
  
  for (int i = 0; i < snowflakes.length; i++) {
    snowflakes[i] = new Snowflake(); 
  }
}

void draw() {
  translate(width/2, height/2);
  background(0);

  for (int i = 0; i < snowflakes.length; i++) {
    snowflakes[i].draw();
    snowflakes[i].update();
    
    if (snowflakes[i].radialPos > width * 0.7) {
      snowflakes[i] = new Snowflake();
    }
  }
}
