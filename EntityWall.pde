class EntityWall extends Entity {
  EntityWall(float x, float y) {
    super(x, y, 0, 20);
  }

  void entityCol(EntityLiving e) {
    if (this.collide(e)) {
    }
  }
  void entityCol(Bullet e) {
    if (this.collide(e)) {
      g.entities.remove(e);
    }
  }

  void show() {
    pushMatrix();
    translate(x, y);
    rect(0, 0, size, size);
    popMatrix();
  }
}

