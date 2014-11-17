
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
  if (key == CODED) {
    if (keyCode == SHIFT) {
      s.g.p.pickUp = false;
    }
  }
  if (input) {
    if (key == 'W' || key == 'w') {
      up = 0;
    } else if (key =='S' || key == 's') {
      down = 0;
    } else if (key == 'A' || key == 'a') {
      left = 0;
    } else if (key == 'D' || key == 'd') {
      right = 0;
    }
  } else {
    if (key == 'Z' || key == 'z') {
      up = 0;
    } else if (key =='S' || key == 's') {
      down = 0;
    } else if (key == 'Q' || key == 'q') {
      left = 0;
    } else if (key == 'D' || key == 'd') {
      right = 0;
    }
  }

  s.g.p.updateSpeeds(right-left, down-up);
}

void keyPressed() {
  if ((key == 'W' ||key == 'w') && s.state != 1) {
    s.state = 1;
    input = true;
  } else if ((key == 'Z' || key == 'z') && s.state != 1) {
    s.state = 1;
    input = false;
  }
  if (key == CODED) {
    if (keyCode == SHIFT) {
      g.p.pickUp = true;
    }
  }
  if (key == 'R' || key == 'r') {
    this.g = new Game();
    this.s = new Screen(this.g);
    s.state = 1;
  }
  if (input) {
    if (key == 'W' || key == 'w') {
      up = 1;
    } else if (key =='S' || key == 's') {
      down = 1;
    } else if (key == 'A' || key == 'a') {
      left = 1;
    } else if (key == 'D' || key == 'd') {
      right = 1;
    }
  } else {
    if (key == 'Z' || key == 'z') {
      up = 1;
    } else if (key =='S' || key == 's') {
      down = 1;
    } else if (key == 'Q' || key == 'q') {
      left = 1;
    } else if (key == 'D' || key == 'd') {
      right = 1;
    }
  }

  s.g.p.updateSpeeds(right-left, down-up);
}

void mouseReleased() {
  s.g.p.w.triggered = false;
}

void mousePressed() {
  s.g.p.w.triggered = true;
}

