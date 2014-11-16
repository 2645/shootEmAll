class WeaponMagic extends Weapon {
  WeaponMagic() {
    super("Ḿ̵̉̆ͮ̑͛͟͞͏͔̩͍̹̦̱͎͇̞͇̤̘̝̪ͅA̶̸̸̛̪̟̫̺̞͇̹̭̭͖̯̼͙̗ͧ̈́͑̐̿ͮ̽̃̇̇̈̇̾ͯ̅̃̍̑G̀ͩ͌̓̿͛̂̌ͯͬ̒̆͑̓̆ͬͮ̆̚҉̴̷̙̜̯͎͖̮̩̼͎̩̟͎̹͜ͅI̶̠̹͎͙̿͒̃ͬ̂ͧC̸̛̞̪̦̬͎͍̜͇̻ͭ̀ͫͣ̾ͯ͊̈́̅͐̎͌̈́̀́͞", 2, 20);
    this.im = loadImage("DEV.png");
    this.bullet = new BulletMagic(0,0,0,new Entity(), 10);
  }

  void fire() {
    if (this.owner instanceof Player) {
      this.ammo -= 1;
    }
    g.entities.add(new BulletMagic(this.owner.x, this.owner.y, this.owner.dir, this.owner, 10));
  }
  
  Weapon clone(){
    WeaponMagic w = new WeaponMagic();
    w.ammo = this.ammo;
    return w; 
  }
}
