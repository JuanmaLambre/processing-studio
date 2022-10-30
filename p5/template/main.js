const MODEL_URL =
  "https://cdn.jsdelivr.net/gh/ml5js/ml5-data-and-models/models/pitch-detection/crepe/";

const DETECTION_SPAN = 200; // 5secs

let fft;
let pitch, microphone, frequency;
let lastDetection = -DETECTION_SPAN;

function log2(n) {
  return Math.log(n) / Math.log(2);
}

function american(noteNo /* from 0 to 11 */) {
  switch (noteNo) {
    case 0:
      return "C";
    case 1:
      return "C#";
    case 2:
      return "D";
    case 3:
      return "D#";
    case 4:
      return "E";
    case 5:
      return "F";
    case 6:
      return "F#";
    case 7:
      return "G";
    case 8:
      return "G#";
    case 9:
      return "A";
    case 10:
      return "A#";
    case 11:
      return "B";
  }
}

function onPitch(error, freq) {
  if (error) {
    console.error(error);
  } else {
    const now = millis();
    if (freq && now - lastDetection > DETECTION_SPAN) {
      const spectrum = fft.analyze();
      const freqIdx = Math.round(map(freq, 20, 20000, 0, 1024));
      const amplitude = spectrum[freqIdx];
      const volPercentage = amplitude / 255;

      if (volPercentage > 0) {
        frequency = freq;
        lastDetection = now;

        const midiNo = Math.round(12 * log2(freq / 440) + 69);
        const octave = Math.floor((midiNo - 24) / 12) + 1;
        const note = (midiNo - 24) % 12; // 0 is C, 11 is B
        const americanNotation = american(note);
        console.log(americanNotation + octave, freq);

        const hue = map(note, 0, 11, 0, 360);
        fill(hue, 100, 100);
        noStroke();
        //circle(random(width), random(height), 50);
        background(hue, 100, 100, volPercentage);
      }
    }

    pitch.getPitch(onPitch);
  }
}

function onModelLoaded() {
  pitch.getPitch(onPitch);
}

function listening() {
  console.log("Listening");
  pitch = ml5.pitchDetection(
    MODEL_URL,
    audioContext,
    microphone.stream,
    onModelLoaded
  );
}

function mousePressed() {
  userStartAudio();
}

function setup() {
  createCanvas(windowWidth, windowHeight);

  audioContext = getAudioContext();

  microphone = new p5.AudioIn();
  microphone.start(listening);

  fft = new p5.FFT();

  colorMode(HSB);

  console.log("Click once to start");

  background(0);
}

function draw() {
  // background(0, 0, 0, 0.01);
}
