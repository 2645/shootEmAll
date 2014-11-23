class Enemy extends EntityLiving {

  float range;
  float ammoDropChance, healthPackDropChance, weaponDropChance;
  float exp;

  Enemy(float x, float y, float speedFactor, Weapon w, float h, float size, float range) {    
    super(x, y, speedFactor, w, floor((h + min(g.level,5)*5)*pow(1.1,max(1,g.level-5))), size);
    this.range = range;
    this.exp  = this.h*1.1/10;
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
    updateSpeed(p);

    super.update();
  }

  void updateSpeed(Player p) {
    if (abs(x-p.x) + abs(y-p.y)<range*4) {
      if (abs(x-p.x) + abs(y-p.y) > range/4) {
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
      } else {
        if (x-p.x < 0) {
          xS = -1*speedFactor;
        } else if (x-p.x == 0) {
          xS = 0;
        } else {
          xS = 1*speedFactor;
        }

        if (y-p.y < 0) {
          yS = -1*speedFactor;
        } else if (y-p.y == 0) {
          yS = 0;
        } else {
          yS = 1*speedFactor;
        }
      }
    }
  }
    void show() {
      pushMatrix();
      translate(x, y);
      pushMatrix();        
      rotate(dir);
      image(im, 0, 0,size,size);
      popMatrix();
      calculateHealth();
      popMatrix();
    }

    void calculateHealth() {
      rectMode(CORNERS);
      fill(33, 1, 1);
      rect(-this.size/2, -this.size, (this.h/this.maxHealth) * this.size-this.size/2, -this.size+5);
      fill(0, 1, 1);
      rect((this.h/this.maxHealth)*this.size - this.size/2, -this.size, this.size/2, -this.size+5);
    }
  }

