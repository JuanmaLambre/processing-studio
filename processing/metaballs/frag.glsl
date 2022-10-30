#define METABALLS_COUNT 8
#define EPSILON 0.000001

// Set the XY origin as in Processing
layout(origin_upper_left) in vec4 gl_FragCoord;

uniform float threshold;
uniform float metaballs[METABALLS_COUNT * 2];
uniform float metaballsColors[METABALLS_COUNT * 4];

vec4 calculateMetaColor() {
  float ratios[METABALLS_COUNT];
  float ratiosSum = 0;

  for (int i = 0; i < METABALLS_COUNT; i++) {
    float xDist = gl_FragCoord.x - metaballs[i*2];
    float yDist = gl_FragCoord.y - metaballs[i*2+1];
    float distSq = xDist * xDist + yDist * yDist;
    ratios[i] = 1.0 / distSq;
    ratiosSum += 1.0 / distSq;
  }

  vec4 color = vec4(0, 0, 0, 0);
  for (int i = 0; i < METABALLS_COUNT; i++) {
    vec4 metaballColor = vec4(
      metaballsColors[i*4+0],
      metaballsColors[i*4+1],
      metaballsColors[i*4+2],
      metaballsColors[i*4+3]
    );

    color += (ratios[i] / ratiosSum) * metaballColor;
  }

  return color;
}

void main(void) {
  vec4 newColor = vec4(0, 0, 0, 0);
  float sum = 0;

  for (int i = 0; i < METABALLS_COUNT; i++) {
    float xDist = gl_FragCoord.x - metaballs[i*2];
    float yDist = gl_FragCoord.y - metaballs[i*2+1];
    float distSq = xDist * xDist + yDist * yDist;
    sum += 1.0 / distSq; 
  }

  bool borderCriteria = sum > threshold - EPSILON && sum < threshold + EPSILON;

  float radialDist = sqrt(1.0 / sum);
  float separation = 50, weight = 7;
  bool modCriteria = mod(radialDist, separation) < weight;

  bool insideCriteria = sum > threshold;

  if (insideCriteria) {
    newColor = calculateMetaColor();
  } else if (modCriteria) {
    newColor = calculateMetaColor() * 1.3;
  }

  gl_FragColor = newColor;
} 