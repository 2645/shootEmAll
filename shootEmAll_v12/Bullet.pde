class Bullet extends Entity {

  Entity e;
  float damage;

  Bullet(float x, float y, float s, float dir, Entity e, float size, float damage) {
    super(x, y, s, dir, size);
    this.e = e;
    this.damage = damage;
  }

  void show() {
    pushMatrix();
    translate(x, y);
    rotate(dir);
    fill(63, 1, 1);
    rect(0, 0, size, size);
    popMatrix();
  }

  void borderCol() {    
    if (this.x+this.size/2>= g.maxCoord || this.x-this.size/2<= g.minCoord || this.y+this.size/2 >= g.maxCoord || this.y-this.size/2 <= g.minCoord) {
      g.entities.remove(g.entities.indexOf(this));
    }
  }
}

