Magnet[] magnets = new Magnet[8];
Particle[] particles = new Particle[100];

void setup() {
  fullScreen(P2D);
  background(0);
  
  for (int i = 0; i < magnets.length; i++) {
    magnets[i] = new Magnet(random(width), random(height), i % 2 == 0);
  }
  
  for (int i = 0; i < particles.length; i++) {
    particles[i] = new Particle(random(width), random(height));
  }
}

void draw() {
  background(0);
  
  for (Particle particle : particles) {
    particle.show();
    particle.update(magnets);
  }
  
  for (Magnet magnet : magnets) magnet.show();
}
