ArrayList<FadingCircle> circles = new ArrayList();

void mouseDragged() {
  FadingCircle newCircle = new FadingCircle()
      .setRadius(int(random(40, 80)))
      .setColor(int(random(50, 255)), 0, int(random(50, 255)))
      .setPosition(mouseX, mouseY)
      .setFadingRate(random(2.5, 6));
      
  FadingCircle mirrorCircle = new FadingCircle()
      .setRadius(int(random(40, 80)))
      .setColor(int(random(50, 255)), int(random(50, 255)), 0)
      .setPosition(width - mouseX, height - mouseY)
      .setFadingRate(random(2.5, 6));
      
  circles.add(newCircle);
  circles.add(mirrorCircle);
}

void setup() {
  fullScreen();
}

void draw() {
  background(0);
  
  int i = 0;
  while (i < circles.size()) {
    FadingCircle fadingCircle = circles.get(i);
    fadingCircle.update();
    
    if (fadingCircle.isFaded()) {
      circles.remove(i);
    } else {
      fadingCircle.show();
      i++; 
    }
  }
}
