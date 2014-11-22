class EntityPortal extends Entity {

  float time;
  int spawnCounter;
  
  EntityPortal(float x, float y, float size) {
    super(x, y, 0, size);
    this.time = millis();
  }

  void spawn() {
    if (millis()-this.time>5000) {
      println("spawning now!!" + millis());
      for(int i = 0 ; i < 5 ; i++){
        g.entities.add(enemy());
      }
      this.time = millis();
      
      spawnCounter--;
    }
  }

  void update() {
    this.dir = map(frameCount%240, 0, 240, 0, TWO_PI);
    if(spawnCounter > 0 ){
      spawn();
    }else{
      dead();
    }    
  }

  void show() {
    pushMatrix();
    translate(x, y);
    pushMatrix();        
    rotate(dir);
    image(im, 0, 0,size,size);
    popMatrix();
    popMatrix();
  }
  
  Enemy enemy(){
    println("not implemented you dumb fuck");
    return null;
  }
}

