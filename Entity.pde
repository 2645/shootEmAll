class Entity {

  float x, y; // the xCoord and yCoord
  float xS, yS; // xSpeed and ySpeed
  float dir;   // direction player is looking in
  float speedFactor;
  float time;
  float firstTime;
  float size;
  boolean isDead;
  PImage im;

  Entity() {
  }

  Entity(float x, float y, float speedFactor, float size) {
    this.x = x;
    this.y = y;
    this.xS = 0;
    this.yS = 0;
    this.dir = 0;
    this.speedFactor = speedFactor;
    this.time = millis();
    this.firstTime = millis();
    this.size = size;
  }

  Entity(float x, float y, float s, float dir, float size) {
    this.x = x;
    this.y = y;
    this.dir = dir;
    this.xS = s*cos(this.dir);
    this.yS = s*sin(this.dir);    
    this.time = millis();
    this.firstTime = millis();
    this.size = size;
  }

  void updatePos() {
    this.x += this.xS*(millis()-this.time)/100;
    this.y += this.yS*(millis()-this.time)/100;
    this.time = millis();
  }

  void update() {
    updatePos();
  }

  void show() {
    fill(63, 99, 1);
    rect(x, y, size, size);
  }

  void resolveCollision(Entity e) {
    if (this instanceof EntityLiving && e instanceof Bullet) {
      ((EntityLiving)this).entityCol((Bullet) e);
    } else if (this instanceof Bullet && e instanceof EntityLiving) {
      ((EntityLiving) e).entityCol((Bullet) this);
    } else if (this instanceof EntityLiving && e instanceof EntityLiving) {
      ((EntityLiving) e).entityCol((EntityLiving) this);
    } else if (this instanceof Drop && e instanceof Player) {
      ((Drop) this).entityCol((Player) e);
    } else if (this instanceof Player && e instanceof Drop) {
      ((Drop) e).entityCol((Player) this);
    } 
    // COLLISIONS THAT ARE IGNORED
    else if (this instanceof Drop && e instanceof Drop) {
    } else if (this instanceof Drop && e instanceof Entity) {
    } else if (this instanceof Entity && e instanceof Drop) {
    } else if (this instanceof Bullet && e instanceof Bullet) {
    } else {
      this.entityCol(e);
    }
  }
  
  void entityCol(Entity e) {
    println("collision between " + this.getClass() + " and " +e.getClass() + " is not implemented you noob");
  }

  boolean collide(Entity e) {
    if (dist(this.x, this.y, e.x, e.y)<this.size/2 + e.size/2 && !e.isDead  && !this.isDead) {
      return true;
    }
    return false;
  }

  void borderCol() {
    if (this instanceof Bullet) {
      ((Bullet) this).borderCol();
      return;
    }
    if (this.x+this.size/2>=g.maxCoord) {
      this.x = g.maxCoord-1-this.size/2;
    }
    if (this.y+this.size/2>=g.maxCoord) {
      this.y = g.maxCoord-1-this.size/2;
    }
    if (this.x-this.size/2<=g.minCoord) {
      this.x = g.minCoord+1+this.size/2;
    }
    if (this.y-this.size/2<=g.minCoord) {
      this.y = g.minCoord+1+this.size/2;
    }
  }

  void fire() {
  }
}
