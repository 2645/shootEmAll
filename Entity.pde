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
    if ( this.defaultBump == null) {
      this.defaultBump = rm.get("defaultBumpMap.png");
    }
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
    if ( this.defaultBump == null) {
      this.defaultBump = rm.get("defaultBumpMap.png");
    }
  }

  void updatePos() {
    // BASED ON EATERS COLLISION DETECTION
    
    boolean collided = false;
    
    // CALCULATE DISTANCE IT HAS TO TRAVEL AT MAX
    float xDist = this.xS*(millis()-this.time)/100;    
    float yDist = this.yS*(millis()-this.time)/100;
    float absXDist = abs(xDist);
    float absYDist = abs(yDist);
    
    // CALCULATE ABSOLUTE COORDS OF ENTITY (0 - 1999)
    float absX = ceil(max(min(1999-this.size/2, ceil(this.x+1000)), this.size/2));
    float absY = ceil(max(min(1999-this.size/2, ceil(this.y+1000)), this.size/2));
    float xFactor, yFactor;
    if (xDist == 0 && yDist == 0 ) {
      return;
    }
    
    // CALCULATE GROWTH FACTOR OF X AND Y
    if (absXDist > absYDist) {
      xFactor = 1;
      yFactor = absYDist/absXDist;
    } else {
      xFactor = absXDist/absYDist;
      yFactor = 1;
    }
    
    // CALCULATE DIRECTION OF X AND Y
    int xDir = xDist > 0 ? 1 : -1;
    int yDir = yDist > 0 ? 1 : -1;

    float newX, newY;
    
    // CHECK EVERY POSITION FROM START TO FINISH FOR COLLISION
    for (int k = 1; k < max (absXDist, absYDist); k ++) {
      
      // ABSOLUTE POSITION OF ENTITY
      newX = absX + k * xFactor * xDir;
      newY = absY + k * yFactor * xDir;
      
      // ITERATE THROUGH BUMPMAP OF ENTITY AND PART OF BUMPMAP OF MAP
      for (int i = 0; i<this.size; i++) {
        for (int j = 0; j<this.size; j++) {
          
          // CALCULATE WHICH PIXEL ON THE MAP SHOULD BE CHECKED
          int mapX = ceil(max(min(1999,newX-this.size/2+i),0));
          int mapY = ceil(max(min(1999,newY-this.size/2+j),0));
          
          // IF BOTH ENTITYMAP AND MAPMAP AREN'T TRANSPARANT COLLIDE
          if (this.defaultBump.pixels[round(j*this.size+i)] != 16777215 && g.map.pixels[mapY*2000+mapX] != 16777215) {
            
            // SET THE DISTANCE TRAVELED ONE STEP BACK (CURRENTLY NOT USED)
            xDist = (k-1) * xFactor * xDir;
            yDist = (k-1) * yFactor * yDir; 
            
            this.wallCol();
            collided = true;
            break;
          }
        }
      }
    }
    
    if(!collided){
    this.x += xDist;
    this.y += yDist;
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
    //println(this +" is eductively touchin\' that wall");
  }

  void fire() {
  }

  boolean validPos(float x) {
    if (x<= g.maxCoord && x >= g.minCoord) {
      return true;
    }
    return false;
  }

  void remove() {
    g.entities.remove(this);
  }
}

