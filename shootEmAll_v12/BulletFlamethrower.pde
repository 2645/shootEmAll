class BulletSprayer extends Bullet {
  
  
  float timeEnd;
  
  BulletSprayer(float x, float y, float s, float dir, Entity owner){
    super(x,y,s,dir,owner, 4, 1);
    this.timeEnd = 300;
  }
  
  void update() {
    updatePos();
    if(this.time - this.firstTime > this.timeEnd){
      g.entities.remove(this);
    }
  }
  
}

