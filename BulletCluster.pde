class BulletCluster extends Bullet {

  boolean clustered;
  int amount;


  BulletCluster(float x, float y, float dir, Entity owner, int amount) {
    super(x, y, 40, dir, owner, amount * 2, 30 * amount);
    this.amount = amount;
    this.clustered = false;
  }

  void update() {
    updatePos();
    if((this.time-this.firstTime) > 500 && !this.clustered){
      updateCluster();
    }
  }

  void updateCluster() {    
      this.clustered = true;
      if (this.amount < 1) return;
      float dirDiff = TWO_PI / this.amount;
      for (int i=0; i< amount; i++) {
        float ndir = (i * dirDiff) + this.dir ;
        g.entities.add(new BulletCluster(this.x, this.y, ndir % TWO_PI, this.e, this.amount / 2));
      }
      dead();    
  }
  
  void dead(){
    if(!this.clustered){
    updateCluster();
    }
    g.entities.remove(this);
  }
}

