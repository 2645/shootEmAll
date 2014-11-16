class WeaponShotgun extends Weapon {
  
  float spread;
  float bullets;
  int speedMax;
  int speedMin;
  
  WeaponShotgun() {
    super("Shotgun", 2, 20);
    this.im = loadImage("DEV.png");
    this.bullet = new BulletShotgun(0,0,0,0,new Entity());
    this.spread = 0.08;
    this.speedMax = 80;
    this.speedMin = 40;
    this.bullets = 10;
  }
  

  void fire() {
    if (this.owner instanceof Player) {
      this.ammo -= 1;
    }
    float diff = TWO_PI * this.spread;
    float diffBullet = diff / this.bullets;
    float extraDiff = diff * this.spread; 
    float halfDiff = extraDiff/2;
    float start = this.owner.dir - (diff / 2);
    for(int i = 0; i < (this.bullets); i++){
      float inaccurcy = random(0, extraDiff) - halfDiff;
      g.entities.add(new BulletShotgun(this.owner.x, this.owner.y, random(this.speedMin, this.speedMax), start + (diffBullet * i) + inaccurcy, this.owner));
    }
  }
  
  Weapon clone(){
    WeaponShotgun w = new WeaponShotgun();
    w.ammo = this.ammo;
    return w; 
  }
}
