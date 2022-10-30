const paths = [
  [{x:1,Y:0}, {X:0.7,y:-1},{X:0,Y:0}],
  [{x:1,Y:0}, {X:0.7,y:1},{X:0,Y:0}],
]

const PIXELS_PER_UNIT = 100; // Increase this value to zoom in
const PATH_COLORS = [];

function drawGrid() {
  stroke(200);
  strokeWeight(1);

  for (let x = 0; x < width/2; x += PIXELS_PER_UNIT) {
    line(x, height/2, x, -height/2);
    line(-x, height/2, -x, -height/2);
  }

  for (let y = 0; y < height/2; y += PIXELS_PER_UNIT) {
    line(-width/2, y, width/2, y);
    line(-width/2, -y, width/2, -y);
  }

  stroke(0);
  strokeWeight(2);
  line(0, height/2, 0, -height/2);
  line(-width/2, 0, width/2, 0);
}

function getPoint(pathPoint) {
  const x = (pathPoint.X || pathPoint.x || 0) * PIXELS_PER_UNIT;
  const y = (pathPoint.Y || pathPoint.y || 0) * PIXELS_PER_UNIT;
  return {x, y}
}

function drawPaths() {
  strokeWeight(1);

  paths.forEach((path, pathIdx) => {
    const pathColor = PATH_COLORS[pathIdx % PATH_COLORS.length];
    stroke(pathColor);
    
    for (let i = 1; i < path.length; i++) {
      const p0 = getPoint(path[i-1]);
      const p1 = getPoint(path[i]);
      line(p0.x, p0.y, p1.x, p1.y);
    }
  })
}

function setup() {
  createCanvas(700, 500);
  
  PATH_COLORS.push(
    color(255, 0, 0),
    color(0, 255, 0),
    color(0, 0, 255),
    color(0, 255, 255),
    color(255, 0, 255),
    color(255, 255, 0),
  );
}

function draw() {
  background(250);
  translate(width/2, height/2);
  scale(1, -1);

  drawGrid();
  drawPaths();
}
