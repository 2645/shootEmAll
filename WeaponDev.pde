class WeaponDev extends Weapon {
  WeaponDev() {
    super("DEV", 20, 1000);
    this.im = loadImage("DEV.png");
    this.bullet = new BulletDev(0,0,0,new Entity());
  }

  void fire() {
    if (this.owner instanceof Player) {
      this.ammo -=1;
    }
    g.entities.add(new BulletDev(this.owner.x, this.owner.y, this.owner.dir, this.owner));
  }
}
