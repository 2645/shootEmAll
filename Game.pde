class Game {

  final int minCoord;
  final int maxCoord;
  Player p;
  ArrayList<Entity> entities;
  float time, level, breakTime;

  Game() {
    this.minCoord = -1000;
    this.maxCoord = 1000;
    this.p = new Player(500, 500, 20, new WeaponDev(), 100, 40);
    this.entities = new ArrayList<Entity>();
    this.time = millis();
    this.breakTime=0;
    this.level = 0;
  }
  boolean first = true;

  void update() {
    if (lvlCompleted()) {
      if (first) {
        breakTime = millis();
        first = false;
      }
      if (millis()-breakTime>=5000) {
        level ++;
        spawnPortals();
        first =true;
      }
    }

    if (p.h <=0) {
      text("YOU LOSE", width/2, height/2);
      noLoop();
    }

    pushMatrix();// update player;
    translate(width/2, height/2);
    p.update();
    p.borderCol();

    pushMatrix();// update all other entities
    translate(-p.x, -p.y);

    drawBackground();   

    updatePlayer();

    updateEntities();

    updateCollisions();

    for (Entity e : entities) {
      e.show();
    }
    popMatrix()
      ;
    p.show();
    popMatrix();
  }

  void drawBackground() {
    for (int i = minCoord; i<= maxCoord; i+=100) {
      stroke(0, 1, 1);
      line(i, minCoord, i, maxCoord);
      line(minCoord, i, maxCoord, i);
    }
  }

  boolean lvlCompleted() {
    for (Entity e : entities) {
      if (e instanceof EntityPortal || e instanceof Enemy) {
        return false;
      }
    }
    return true;
  }

  void spawnPortals() {
    if(level%5 == 0){
      entities.add(new EntityPortalBoss());
    }
    for (int i = 0; i < level/5 ; i++ ){   
      entities.add(new EntityPortalRegular()); 
    }
    time = millis();
  }

  void updatePlayer() {
    if (p.w.canFire()) {
      p.fire();
    }
  }

  void updateEntities() {
    ArrayList<Entity> entitiesCopy = (ArrayList) entities.clone(); 
    for (Entity e : entitiesCopy) {   
      // UPDATE ENTITIES     
      if (e instanceof EntityLiving) {
        if (e instanceof Enemy) {
          ((Enemy)e).update(p);
        } else {
          e.update();
        }        
        if (((EntityLiving) e).w.canFire()) {
          e.fire();
        }
      } else {
        e.update();
      }
      // UPDATE DROPS
      if ( e instanceof Drop) {
        if (((Drop)e).despawned()) {
          e.dead();
        }
      }
    }
  }

  void updateCollisions() {
    ArrayList<Entity> entitiesCopy = (ArrayList) entities.clone(); 
    for (Entity e : entitiesCopy) {
      e.borderCol(); 
      e.resolveCollision(p);
    }    
    for (int i = 0; i < entitiesCopy.size ()-1; i++) {
      for (int j = i+1; j< entitiesCopy.size (); j++) {
        entitiesCopy.get(i).resolveCollision(entitiesCopy.get(j));
      }
    }
  }
}

