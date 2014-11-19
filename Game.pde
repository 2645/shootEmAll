class Game {

  final int minCoord;
  final int maxCoord;
  Player p;
  ArrayList<Entity> entities;
  float time, level, breakTime;
  PImage map;

  Game() {
    this.minCoord = -1000;
    this.maxCoord = 1000;
    this.p = new Player(500, 500, 20, new WeaponDev(), 100, 40);
    this.entities = new ArrayList<Entity>();
    this.time = millis();
    this.breakTime=0;
    this.level = 0;    
    this.map = rm.get("MAP.png");
    map.loadPixels();
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
        spawnEnemies();
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
    image(map, 0, 0);
  }

  boolean lvlCompleted() {
    for (Entity e : entities) {
      if (e instanceof Enemy) {
        return false;
      }
    }
    return true;
  }

  void spawnEnemies() {
    int amount = round(random(10+level*3, 20+level*5));
    for (int i = 0; i <  amount; i++) {
      spawnEnemy();
    }         
    time = millis();
  }
  
  void spawnEnemy(){
  float type = random(0,10);
  if(type<8){
    entities.add(new EnemyRegular(minCoord,maxCoord));
  }else{
    entities.add(new EnemySniper(minCoord,maxCoord));
  }
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
          entities.remove(e);
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

