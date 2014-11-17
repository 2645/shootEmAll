class WeaponCluster extends Weapon {
  WeaponCluster() {
    super("cluster", 2, 20);
    this.im = rm.get("cluster.png");
    this.bullet = new BulletCluster(0,0,0,new Entity(), 10);
  }

  void fire() {
    if (this.owner instanceof Player) {
      this.ammo -= 1;
    }
    g.entities.add(new BulletCluster(this.owner.x, this.owner.y, this.owner.dir, this.owner, 10));
  }
  
  Weapon clone(){
    WeaponCluster w = new WeaponCluster();
    w.ammo = this.ammo;
    return w; 
  }
}
