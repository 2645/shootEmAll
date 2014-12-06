
Game g;
Screen s;
ResourceManager rm;
PFont f;
boolean input;

void setup() {
  size(displayWidth, displayHeight, P2D);
  this.rm = new ResourceManager();
  this.g = new Game();
  this.s = new Screen(this.g);
  colorMode(HSB, 100, 1, 1, 1);
  f = createFont("Arial", 36, true);
  textFont(f, 36);
  textAlign(LEFT);
  ellipseMode(CENTER);
  imageMode(CENTER);
}

void draw() {
  s.update();
}

boolean sketchFullScreen() {
  return true;
}

float left, right, up, down;

void keyReleased() {
  s.controlReleased();
}

void keyPressed() {
  s.controlPressed();
}

void mouseReleased() {
  s.mouseRelease();
  
}

void mousePressed(){
  s.mousePress();
}
