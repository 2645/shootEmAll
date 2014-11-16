class DropWeapon extends Drop {

  Weapon w;
  float pickUpTimer;

  DropWeapon(float x, float y, float dir, Weapon w) {
    super(x, y, dir);
    this.w = w;
    this.w.triggered = false;
    this.pickUpTimer = millis();
  }

  void show() {
    pushMatrix();
    translate(x, y);
    rotate(dir);
    image(w.im, 0, 0);
    //rect(0, 0, size, size*2);
    popMatrix();
  }

  void entityCol(Player e) {
    if (this.collide(e)) {
      if (this.canPickup()&&e.pickUp) {
        g.entities.add(new DropWeapon(e.x+random(-10, 10), e.y+random(-10, 10), e.dir, (Weapon ) (e.w.clone())));
        e.w = this.w;
        e.w.owner =e;
        g.entities.remove(this);
      }
    }
  }

  boolean canPickup() {
    return millis()-pickUpTimer>1000;
  }
}

