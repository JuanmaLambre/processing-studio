ArrayList<FadingCircle> circles = new ArrayList();
BezierPath[] paths;

color[] pickColors(int pathNo) {
  color[] options = new color[] {
    color(0, int(random(50, 255)), int(random(50, 255))),
    color(int(random(50, 255)), 0, int(random(50, 255))),
    color(int(random(50, 255)), int(random(50, 255)), 0)
  };
  
  // Avoid selecting repeated colors
  int selected1 = pathNo % options.length;
  int selected2 = (pathNo + 1) % options.length;
  
  return new color[] { options[selected1], options[selected2] };
}

void setup() {
  fullScreen(P2D);
  background(0);
  
  paths = new BezierPath[] {
    new BezierPath().appendCurves(
      new BezierCurve(
        new PVector(width, height),
        new PVector(0, height),
        new PVector(3.0 * width / 2.0, height / 2.0),
        new PVector(0, 0)
      ).setSpeed(0.01).setTime(-0.0)
    ),
    new BezierPath().appendCurves(
      new BezierCurve(
        new PVector(0, 3.0 * height / 4.0),
        new PVector(0, 2.0 * height / 4.0),
        new PVector(2.0 * width / 3.0, 2.0 * height / 4.0),
        new PVector(2.0 * width / 3.0, 1.0 * height / 4.0)
      ).setSpeed(0.017).setTime(-1.8),
      new BezierCurve(
        new PVector(2.0 * width / 3.0, 1.0 * height / 4.0),
        new PVector(2.0 * width / 3.0, 2.0 * height / 4.0),
        new PVector(4.0 * width / 3.0, 2.0 * height / 4.0),
        new PVector(4.0 * width / 3.0, 3.0 * height / 4.0)
      ).setSpeed(0.017)
    ),
    new BezierPath().appendCurves(
      new BezierCurve(
        new PVector(1.0 * width / 4.0, 2.0 * height / 3.0),
        new PVector(width, 0),
        new PVector(width, height),
        new PVector(1.0 * width / 4.0, 1.0 * height / 3.0)
      ).setSpeed(0.015).setTime(-3.0)
    ),
    new BezierPath().appendCurves(
      new BezierCurve(
        new PVector(1.0 * width / 5.0, height),
        new PVector(width, 0),
        new PVector(3.0 * width / 5.0, height),
        new PVector(3.0 * width / 4.0, 2.0 * height / 5.0)
      ).setSpeed(0.015).setTime(-4.0)
    )
  };
}

void draw() {
  background(0);
  
  for (int i = 0; i < paths.length; i++) {
    BezierPath path = paths[i];
    color[] colors = pickColors(i);
    int x = int(path.getPoint().x);
    
    FadingCircle newCircle = new FadingCircle()
      .setRadius(int(random(40, 80)))
      .setColor(colors[0])
      .setPosition(x, int(path.getPoint().y))
      .setFadingRate(random(2.5, 6));
      
    FadingCircle mirrorCircle = new FadingCircle()
      .setRadius(int(random(40, 80)))
      .setColor(colors[1])
      .setPosition(width - x, int(path.getPoint().y))
      .setFadingRate(random(2.5, 6));
      
    circles.add(newCircle);
    circles.add(mirrorCircle);
    path.update();
  }

  int i = 0;
  while (i < circles.size()) {
    FadingCircle fadingCircle = circles.get(i);
    fadingCircle.show();
    fadingCircle.update();
    
    if (fadingCircle.isFaded()) {
      circles.remove(i);
    } else {
      i++;
    }
  }
  
  saveFrame();
}
