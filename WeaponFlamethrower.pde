class WeaponFlamethrower extends Weapon {
  
  float spread;
  float bullets;
  int speedMax;
  int speedMin;
  
  WeaponFlamethrower() {
    super("Flamethrower", 30, 400);
    this.im = loadImage("DEV.png");
    this.bullet = new BulletSprayer(0,0,0,0,new Entity());
    this.spread = 0.09;
    this.speedMax = 60;
    this.speedMin = 20;
    this.bullets = 40;
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
    for(int i = 0; i < this.bullets; i++){
      float inaccurcy = random(0, extraDiff) - halfDiff;
      g.entities.add(new BulletSprayer(this.owner.x, this.owner.y, random(this.speedMin, this.speedMax), start + (diffBullet * i) + inaccurcy, this.owner));
    } 
  }
  
  Weapon clone(){
    WeaponMagic w = new WeaponMagic();
    w.ammo = this.ammo;
    return w; 
  }
}
