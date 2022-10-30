class Particle {  
  constructor() {
    this.baseColor = this.randomColor();
    this.vertices = [];
    this.brightnessOffset = Math.random() * config.PERIOD_FRAMES;

    const [centerX, centerY] = [Math.random() * width, Math.random() * height];
    
    for (let i = 0; i < config.VERTICES; i++) {
      const angle = 2 * Math.PI * i / config.VERTICES;
      const radius = Math.random() * config.MAX_RADIUS;
      const x = radius * Math.cos(angle) + centerX;
      const y = radius * Math.sin(angle) + centerY;
      this.vertices.push([x, y]);
    }
  }
  
  draw() {
    //this.baseColor.setBlue(this.calculateBrightness()); // Set brightness
    //this.baseColor.setGreen(this.calculateBrightness()); // Set saturation
    const fillColor = color(
      this.baseColor.color._getHue(),
      this.baseColor.color._getSaturation(),
      this.calculateBrightness()
    );
    
    fill(fillColor);
    noStroke();
    
    beginShape();
    for (let v of this.vertices) {
      vertex(...v);
    }
    endShape(CLOSE);
  }
  
  calculateBrightness() {
    const [minBright, maxBright] = this.baseColor.brightRange;
    const idx = (frameCount + this.brightnessOffset) / config.PERIOD_FRAMES;
    const angle = idx * TWO_PI;
    return (Math.pow(Math.sin(angle), 21) + 1) / 2 * (maxBright - minBright) + minBright;
  }
  
  randomColor() {
    const colors = config.COLORS;
    let rnd = Math.random();
    for (let i = 0; rnd > 0; i++) {
      rnd -= colors[i].probability;
      if (rnd < 0) {
        return colors[i];      
      }
    }
  }
}

const particles = [];
let config;

function setup() {
  colorMode(HSB, 360, 100, 100);
  createCanvas(windowWidth, windowHeight);
  
  config = {
    MAX_RADIUS: 3,
    VERTICES: 4,
    MIN_BRIGHTNESS: 60,
    PERIOD_FRAMES: 120,
    COLORS: [
      //{ color: color(300, 100, 100), probability: 1 },
      { color: color(60, 60, 100), brightRange: [40, 90], probability: 0.4 }, // Yellow
      { color: color(120, 40, 80), brightRange: [10, 40], probability: 0.3 }, // Green
      { color: color(300, 0, 100), brightRange: [30, 90], probability: 0.3 } // White
    ]
  }
  
  for (let i = 10000; i > 0; i--) {
    particles.push(new Particle());
  }
}


function draw() {
  background(0);
  
  particles.forEach(particle => particle.draw());
}
