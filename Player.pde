class Player extends EntityLiving {


  float xCenter, yCenter; // xCoord and yCoord of center of screen
  float healthTimer;
  float maxHealth;
  PImage im;
  boolean pickUp;
  
  Player(float x, float y, float speedFactor, Weapon w, float h, float size) {
    super(x, y, speedFactor, w, h, size);
    this.xCenter = width/2;
    this.yCenter = height/2;
    this.healthTimer = millis();
    this.maxHealth = 100;
    this.w.owner = this;
    this.im = rm.get("player.png");
  }

  void show() {
    pushMatrix();
    rotate(dir);
    fill(0, 0, 1);
    image(im,0,0,size,size);
    image(w.im,0,0);
    this.w.show();
    popMatrix();
  }

  void update() {
    updateDir();
    updatePos();
    updateHealth();
  }

  void updateDir() {
    if (xCenter - mouseX>=0) {
      this.dir = atan((yCenter-mouseY)/(xCenter-mouseX))-PI;
    } else {
      this.dir = atan((yCenter-mouseY)/(xCenter-mouseX));
    }
  }

  void updateSpeeds(float x, float y) {
    this.xS = x*speedFactor;
    this.yS = y*speedFactor;
  }
  
  boolean firstCountDown = true;
  
  void updateHealth(){
    if(this.h > maxHealth&& (firstCountDown || (millis()-this.healthTimer>1000))){
      h--;
      this.healthTimer = millis();
      firstCountDown = false;
    }
    if(h >200){
      h = 200;
    }
    if(h == 100){
      firstCountDown = true;
    }
  }
}

