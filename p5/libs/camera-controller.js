const CameraController = {
  /* Private variables */
  translation: new p5.Vector(),
  scaling: new p5.Vector(1, 1),

  settings: {
    dragSensitivity: 0.6,
    wheelSensitivity: 0.3 / 100,
    cartesian: false,
    avoidReflection: true,
  },

  autoSetup() {
    if (!window.mouseDragged) window.mouseDragged = this.onMouseDragged.bind(this);
    if (!window.mouseWheel) window.mouseWheel = this.onScroll.bind(this);
  },

  update() {
    const yFactor = this.settings.cartesian ? -1 : 1;
    translate(width / 2, height / 2);
    scale(this.scaling.x, yFactor * this.scaling.y);
    translate(-width / 2, -height / 2);

    translate(this.translation);
  },

  onMouseDragged() {
    const dir = new p5.Vector(mouseX - pmouseX, mouseY - pmouseY);
    dir.mult(this.settings.dragSensitivity / this.scaling.mag());
    if (this.settings.cartesian) dir.y *= -1;

    this.translation.add(dir);
  },

  onScroll(event) {
    if (event == undefined) {
      console.warn("CameraController.onScroll must be called with event argument");
      return false;
    }

    const { wheelSensitivity, avoidReflection } = this.settings;

    const scrollDelta = -event.delta * wheelSensitivity;
    this.scaling.add(scrollDelta, scrollDelta);

    if (avoidReflection && this.scaling.x < 0) this.scaling.x = 0;
    if (avoidReflection && this.scaling.y < 0) this.scaling.y = 0;

    return false;
  },
};
