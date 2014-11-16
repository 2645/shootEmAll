class WeaponDev extends Weapon {
  WeaponDev() {
    super("DEV", 20, 1000);
    this.im = loadImage("DEV.png");
    this.bullet = new BulletDev(0,0,0,new Entity());
  }

  void fire(EntityLiving e) {
    if (this.owner instanceof Player) {
      this.ammo -=1;
    }
    g.entities.add(new BulletDev(e.x, e.y, e.dir, e));
  }
}
