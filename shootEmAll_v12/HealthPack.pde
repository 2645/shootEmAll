class HealthPack extends Drop {
  HealthPack(float x, float y, float dir) {
    super(x, y, dir);
  }
  void show() {
    pushMatrix();
    translate(x, y);
    rotate(dir);
    fill(100, .32, .92);
    rect(0, 0, size, size);
    popMatrix();
  }
  
  void entityCol(Player e){
   if (this.collide(e)) {
      e.h += e.maxHealth/5;
      g.entities.remove(this);
    }
  }
}

