class WeaponSniper extends Weapon {
  WeaponSniper() {
    super("sniper", 0.5, 80);
    this.im = rm.get("sniper.png");
    this.bullet = new BulletSniper(0, 0, 0, new Entity());
  }
  void fire() {
    if (this.owner instanceof Player) {
      this.ammo -=1;
    }
    g.entities.add(new BulletSniper(this.owner.x, this.owner.y, this.owner.dir, this.owner));
  }
}

