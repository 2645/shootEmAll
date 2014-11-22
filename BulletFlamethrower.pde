class BulletFlamethrower extends Bullet {
  float timeEnd;
  PImage im2;
  BulletFlamethrower(float x, float y, float s, float dir, Entity owner) {
    super(x, y, s, dir, owner, 4, 1);
    this.timeEnd = 300;
    this.im = rm.get("fire.png");
    this.im2 = rm.get("fire2.png");
  }

  void update() {
    updatePos();
    if (this.time - this.firstTime > this.timeEnd) {
      dead();
    }
  }
  void show() {
    pushMatrix();
    translate(x, y);
    rotate(dir);
    if(random(0,1) < 0.9){
    image(im,0,0,size,size);
    } else{
      image(im2,0,0,size,size);
    }
    popMatrix();
  }
}

