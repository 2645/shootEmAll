class Entity {

  float x, y; // the xCoord and yCoord
  float xS, yS; // xSpeed and ySpeed
  float dir;   // direction player is looking in
  float speedFactor;
  float time;
  float firstTime;
  float size;
  boolean isDead;
  PImage im, defaultBump;

  Entity() {
    if (this.im == null) {
      this.im = rm.get("default.png");
    }
    if ( this.defaultBump == null) {
      this.defaultBump = rm.get("defaultBumpMap.png");
    }
    this.defaultBump.loadPixels();
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
    if (this.im == null) {
      this.im = rm.get("default.png");
    }
    this.im.loadPixels();
    if ( this.defaultBump == null) {
      this.defaultBump = rm.get("defaultBumpMap.png");
    }
    this.defaultBump.loadPixels();
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
    if (this.im == null) {
      this.im = rm.get("default.png");
    }
    this.im.loadPixels();
    if ( this.defaultBump == null) {
      this.defaultBump = rm.get("defaultBumpMap.png");
    }
    this.defaultBump.loadPixels();
  }

  void updatePos() {
    float x = this.x+this.xS*(millis()-this.time)/100;    
    float y = this.y+this.yS*(millis()-this.time)/100;
    int absX =ceil(max(min(1999-this.size/2, ceil(x+1000)), this.size/2));
    int absY =ceil(max(min(1999-this.size/2, ceil(y+1000)), this.size/2));
    boolean noCol = true;
    for (int i = 0; i<this.size; i++) {
      for (int j = 0; j<this.size; j++) {         
        if (this.defaultBump.pixels[round(j*this.size+i)] != 16777215 && g.map.pixels[round((absY-this.size/2+j)*2000+absX-this.size/2+i)] != 16777215) {
          println("collision found at " + millis());
          noCol = false;
        }
      }
    }



    /**int maxX = x>0?ceil(x):floor(x);
     int maxY = y>0?ceil(y):floor(y);
     boolean didWallCol = false;
     if (maxY == 0 && maxX == 0) {
     this.time = millis();
     return;
     }
     int absX = round(this.x + 1000);
     int absY = round(this.y + 1000);
     int yD = maxY < 0 ? -1 : 1;
     int xD = maxX < 0 ? -1 : 1;
     int absMaxX = abs(maxX);
     int absMaxY = abs(maxY);
     if (absMaxY > absMaxX) {
     float diff = absMaxX / absMaxY;
     for (int i = 1; i < absMaxY; i++) {
     int newX = max(min(absX + round((i*xD) * diff), 1999), 0);
     int newY = max(min(absY + (i*yD), 1999), 0);
     if (g.map.pixels[newY*2000 + newX] != 16777215) {
     x = 0;
     y = 0;
     this.wallCol();
     didWallCol = true;
     break;
     }
     }
     } else {
     float diff = absMaxY / absMaxX;
     for (int i = 1; i < absMaxX; i++) {
     int newX = max(min(absX + (i*xD), 1999), 0);
     int newY = max(min(absY + round((i*yD) * diff), 1999), 0);
     if (g.map.pixels[newY*2000 + newX] != 16777215) {
     x = 0;
     y = 0;
     this.wallCol();
     didWallCol = true;
     break;
     }
     }
     }
     
     int newX = max(min(absX + round(x), 1999), 0);
     int newY = max(min(absY + round(y), 1999), 0);
     if (g.map.pixels[newY*2000 + newX] != 16777215) {
     if (!didWallCol) {
     this.wallCol();
     }
     x = 0;
     y = 0;
     }
     **/

    if (noCol) {
      if (validPos(x)) {
        this.x = x;
      } 
      if (validPos(y)) {   
        this.y = y;
      }
    } else {
      if (this instanceof Bullet) {
        g.entities.remove(this);
      }
    }
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

  void wallCol() {
    println(this +" is eductively touchin\' that wall");
  }

  void fire() {
  }

  boolean validPos(float x) {
    if (x<= g.maxCoord && x >= g.minCoord) {
      return true;
    }
    return false;
  }
}

