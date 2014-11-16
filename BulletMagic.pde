class BulletMagic extends Bullet {

  boolean didMagic;
  int amount;


  BulletMagic(float x, float y, float dir, Entity owner, int amount) {
    super(x, y, 40, dir, owner, amount * 2, 30 * amount);
    this.amount = amount;
    this.didMagic = false;
  }

  void update() {
    updatePos();
    if ((this.time - this.firstTime) > 500 && !this.didMagic) {
      this.didMagic = true;
      if (this.amount < 1) return;
      float dirDiff = TWO_PI / this.amount;
      for (int i=0; i< amount; i++) {
        float ndir = (i * dirDiff) + this.dir ;
        g.entities.add(new BulletMagic(this.x, this.y, ndir % TWO_PI, this.e, this.amount / 2));
      }
      g.entities.remove(this);
    }
  }
}

