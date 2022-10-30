import processing.sound.*;

FFT fft;
AudioIn in;
int bands = 512;
float[] spectrum = new float[bands];
float volumeLevel = 0; // 0to 1

void setup() {
  size(512, 360);
  background(255);
  
  frameRate(20);
    
  // Create an Input stream which is routed into the Amplitude analyzer
  fft = new FFT(this, bands);
  in = new AudioIn(this, 1);
  
  // start the Audio Input
  in.start();
  
  // patch the AudioIn
  fft.input(in);
}      

void draw() {
  background(255);
  fft.analyze(spectrum);

  stroke(0);
  float maxSpectrum = 0;
  float maxSpectrumFreq = 0.0;
  for(int i = 0; i < bands; i++) {
    // The result of the FFT is normalized
    // draw the line for frequency band i scaling it up by 5 to get more amplitude.
    float spec = spectrum[i];
    line( i, height, i, height - spec*height*5 );
    
    if (spec > maxSpectrum) {
      maxSpectrum = spec;
      maxSpectrumFreq = i * 44100.0 / bands / 2;
    }
  }
  
  if (mousePressed) {
    volumeLevel = 1.0 * (height - mouseY) / height;
  }
  
  textSize(16); 
  fill(128, 0, 200);
  textAlign(RIGHT, TOP);
  text(String.valueOf((int)maxSpectrumFreq) + " Hz", width, 0);
  
  stroke(128, 0, 0);
  line(0, (1-volumeLevel)*height, width, (1-volumeLevel)*height);
  
  // saveFrame("./frames/####.png");
}
