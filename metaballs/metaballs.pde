PShader fragShader;

//float threshold = 0.001310;
float threshold = 0.000080;

Metaball[] metaballs;

int movingMetaball = 0;

void mouseWheel(MouseEvent event) {
  threshold += event.getCount() * 0.00001;
  println(String.format("threshold = %f", threshold));
}

//void mouseMoved() {
//  metaballs[movingMetaball].x = mouseX;
//  metaballs[movingMetaball].y = mouseY;
//}

void mouseClicked() {
  movingMetaball++;
  movingMetaball %= metaballs.length;
}

void setupUniforms() {
  fragShader.set("threshold", threshold);
  
  float[] metaballsRef = new float[metaballs.length * 2];
  float[] colorsRef = new float[metaballs.length * 4];
  for (int i = 0; i < metaballs.length; i++) {
    metaballsRef[i*2] = metaballs[i].x;
    metaballsRef[i*2+1] = metaballs[i].y;
    
    PVector ballColor = metaballs[i].ballColor;
    colorsRef[i*4+0] = ballColor.x;
    colorsRef[i*4+1] = ballColor.y;
    colorsRef[i*4+2] = ballColor.z;
    colorsRef[i*4+3] = 1.0;
  }
  fragShader.set("metaballs", metaballsRef);
  fragShader.set("metaballsColors", colorsRef);
}

void setup() {
  fullScreen(P2D);
  //size(600, 600, P2D);
  fragShader = loadShader("frag.glsl");
  
  metaballs = new Metaball[] {
    new Metaball(random(width), random(height)), 
    new Metaball(random(width), random(height)),
    new Metaball(random(width), random(height)),
    new Metaball(random(width), random(height)),
    new Metaball(random(width), random(height)),
    new Metaball(random(width), random(height)),
    new Metaball(random(width), random(height)),
    new Metaball(random(width), random(height)),
    //new Metaball(random(width), random(height)),
    //new Metaball(random(width), random(height)),
    new Metaball(random(width), random(height))
  };
}

void draw() {
  setupUniforms();
  shader(fragShader);
  
  background(0);
  // We draw a rectangle to have fragments on the shader
  rect(0, 0, width, height);
  
  for (Metaball metaball : metaballs) metaball.update();
  
  if (frameCount % 100 == 0) saveFrame("frames/####.png");
}
