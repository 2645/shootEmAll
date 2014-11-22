class WeaponSmg extends Weapon {
  WeaponSmg() {
    super("smg", 5, 300);
    this.im = rm.get("smg.png");
    this.bullet = new BulletSmg(0, 0, 0, new Entity());
  }
  void fire() {
    if (this.owner instanceof Player) {
      this.ammo -=1;
    } 
    g.entities.add(new BulletSmg(this.owner.x, this.owner.y, this.owner.dir, this.owner));
  }
}

