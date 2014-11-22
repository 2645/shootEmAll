class EnemySniper extends Enemy {
  EnemySniper(float x, float y) {
    super(x, y, 10, new WeaponSniper(), 20, 40,1200);
    this.ammoDropChance = 0.7;
    this.healthPackDropChance  = 0.7;
    this.weaponDropChance = 0.01;
    this.im = rm.get("EnemySniper.png");    
  }
}

