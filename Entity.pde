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

  boolean _checkCollision(int x,int y,int halfSize, int fullSize){
    if (g.map.pixels[y*2000 + x] != 16777215) {
      return true;
    }
    int bottomY = y - halfSize;
    int topY = y + halfSize;
    int leftX = x - halfSize;
    int rightX = x + halfSize;
    for(int j = 0; j < fullSize; j++){
      if (g.map.pixels[topY*2000 + leftX + j] != 16777215) {
        return true;
      }
    }
    for(int j = 0; j < fullSize; j++){
      if (g.map.pixels[bottomY*2000 + leftX + j] != 16777215) {
        return true;
      }
    }
    for(int j = 0; j < fullSize; j++){
      if (g.map.pixels[(bottomY + j)*2000 + leftX] != 16777215) {
        return true;
      }
    }
    for(int j = 0; j < fullSize; j++){
      if (g.map.pixels[(bottomY + j)*2000 + rightX] != 16777215) {
        return true;
      }
    }
    return false;
  }

  void updatePos() {
//    try {
      float x = this.xS*(millis()-this.time)/100;    
      float y = this.yS*(millis()-this.time)/100;
      int maxX = x>0?ceil(x):floor(x);
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
      int xPenalty = 0;
      int yPenalty = 0;
      int halfSize = ceil(this.size/2);
      int fullSize = halfSize + halfSize;
      if (absMaxY > absMaxX) {
        float diff = absMaxX / absMaxY;
        for (int i = 1; i < absMaxY; i++) {
          int newX = max(min(absX + round(((i - xPenalty)*xD) * diff), 1999), 0);
          int newY = max(min(absY + ((i - yPenalty)*yD), 1999), 0);
          if(this._checkCollision(newX, newY, halfSize, fullSize)){
            this.wallCol();
            didWallCol = true;
            int penaltiedNewX = max(min(absX + round((((i - xPenalty) - 1)*xD) * diff), 1999), 0);
            if(this._checkCollision(penaltiedNewX, newY, halfSize, fullSize)){
              int penaltiedNewY = max(min(absY + (((i - yPenalty) - 1)*yD), 1999), 0);
              if(this._checkCollision(newX, penaltiedNewY, halfSize, fullSize)){
                x = 0;
                y = 0;
              }else{
                yPenalty++;
              }
            }else{
              xPenalty++;
            }
          }
        }
      } else {
        float diff = absMaxY / absMaxX;
        for (int i = 1; i < absMaxX; i++) {
          int newX = max(min(absX + ((i - xPenalty)*xD), 1999), 0);
          int newY = max(min(absY + round(((i - yPenalty)*yD) * diff), 1999), 0);
          if(this._checkCollision(newX, newY, halfSize, fullSize)){
            this.wallCol();
            didWallCol = true;
            int penaltiedNewX = max(min(absX + (((i - xPenalty) - 1)*xD), 1999), 0);
            if(this._checkCollision(penaltiedNewX, newY, halfSize, fullSize)){
              int penaltiedNewY = max(min(absY + round((((i - yPenalty) - 1)*yD) * diff), 1999), 0);
              if(this._checkCollision(newX, penaltiedNewY, halfSize, fullSize)){
                x = 0;
                y = 0;
              }else{
                yPenalty++; 
              }
            }else{
              xPenalty++;
            }
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

      x = this.x + x;
      y = this.y + y;
      if (validPos(x)) {
        this.x = x;
      } 
      if (validPos(y)) {   
        this.y = y;
      } 
      this.time = millis();
//    }
//    catch (Exception e) {
//     println(e);
//    }
  }

  void update() {
    updatePos();
  }
  
  void remove(){
     if(g.entities.contains(this)){
       g.entities.remove(this);
     }
  }
  
  void add(){
    if(!g.entities.contains(this)){
      g.entities.add(this);
    }
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
}

