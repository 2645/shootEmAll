class WeaponPistol extends Weapon {
  WeaponPistol() {
    super("pistol", 2, 100);
    this.im = rm.get("pistol.png");
    this.bullet = new BulletPistol(0, 0, 0, new Entity());
  }

  void fire() {
    if (this.owner instanceof Player) {
      this.ammo -=1;
    } 
    g.entities.add(new BulletPistol(this.owner.x, this.owner.y, this.owner.dir, this.owner));
  }
}

