abstract class EntityPortal extends Entity {

  float time;
  int spawnCounter;
  int spawnAmount;
  
  EntityPortal(float x, float y, float size) {
    super(x, y, 0, size);
    this.time = millis();
  }

  void spawn() {
    if (millis()-this.time>5000) {
      for(int i = 0 ; i < spawnAmount ; i++){
        g.entities.add(this.enemy());
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
  
  abstract Enemy enemy();
}

