class Enemy extends EntityLiving {

  float range;
  float ammoDropChance, healthPackDropChance, weaponDropChance;

  Enemy(float x, float y, float speedFactor, Weapon w, float h, float size, float range) {
    super(x, y, speedFactor, w, h, size);
    this.range = range;
  }

  void update(Player p) {
    if (x - p.x>=0) {
      this.dir = atan((y-p.y)/(x-p.x))-PI;
    } else {
      this.dir = atan((y-p.y)/(x-p.x));
    }
    if (abs(x-p.x) + abs(y-p.y)<range) {

      w.triggered = true;
    } else {
      w.triggered = false;
    }
    if (abs(x-p.x) + abs(y-p.y)<range*4) {
      updateSpeed(p);
    }    
    super.update();
  }

  void updateSpeed(Player p) {
    if (x-p.x < 0) {
      xS = 1*speedFactor;
    } else if (x-p.x == 0) {
      xS = 0;
    } else {
      xS = -1*speedFactor;
    }

    if (y-p.y < 0) {
      yS = 1*speedFactor;
    } else if (y-p.y == 0) {
      yS = 0;
    } else {
      yS = -1*speedFactor;
    }
  }

  void show() {
    pushMatrix();
    translate(x, y);
    rotate(dir);
    image(im, 0, 0);
    popMatrix();
  }



  
}

