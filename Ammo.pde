class Ammo extends Drop {
  Ammo(float x, float y, float dir) {
    super(x, y, dir);
  }

  void show() {
    pushMatrix();
    translate(x, y);
    rotate(dir);
    fill(17, .83, .75);
    rect(0, 0, size, size);
    popMatrix();
  }

  void entityCol(Player e) {
    if (this.collide(e)) {
      if (e.w.ammo < e.w.maxAmmo) {
        e.w.ammo += e.w.maxAmmo/5;
        if (e.w.ammo> e.w.maxAmmo) {
          e.w.ammo = e.w.maxAmmo;
        }
        dead();
      }
    }
  }
}

