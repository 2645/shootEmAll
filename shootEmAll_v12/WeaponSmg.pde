class WeaponSmg extends Weapon {
  WeaponSmg() {
    super("smg", 5, 300);
    this.im = loadImage("smg.png");
    this.bullet = new BulletSmg(0.0, 0.0, 0.0, new Entity());
  }
  void fire(EntityLiving e) {
    if (this.owner instanceof Player) {
      this.ammo -=1;
    }
    g.entities.add(new BulletSmg(e.x, e.y, e.dir, e));
  }
}

