class Weapon {

  String n; // the name of the weapon
  float fireRate; // the fireRate of the weapon
  float lastFire;
  Entity owner;
  boolean triggered;
  float ammo, maxAmmo;
  PImage im;
  PImage bulletIm;
  Bullet bullet;

  Weapon(String n, float fireRate, float maxAmmo) {
    this.n = n;
    this.fireRate = fireRate;
    this.lastFire = millis();
    this.ammo = ammo; 
    this.maxAmmo = maxAmmo;
    this.ammo = maxAmmo/4*3;
  }

  void show() {
  }

  boolean canFire() {
    if ((millis()-lastFire)/1000>1/fireRate && this.triggered) {
      if (this.owner instanceof Player && ammo <=0) {
        return false;
      }      
      lastFire = millis();
      return true;
    }
    return false;
  }

  void fire() {
    if (this.owner instanceof Player) {
      this.ammo -=1;
    }
    g.entities.add(new Bullet(this.owner.x, this.owner.y, 1, this.owner.dir, this.owner, 100.0, 100.0));
  }

  Weapon clone() {
    Weapon w = null;
    if (this instanceof WeaponPistol) {
      w =  new WeaponPistol();
    } else if (this instanceof WeaponSmg) {
      w = new WeaponSmg();
    } else if (this instanceof WeaponSniper) {
      w = new WeaponSniper();
    } else if (this instanceof WeaponDev) {
      w = new WeaponDev();
    }
    w.ammo = this.ammo;
    return w;
  }
}

