class EnemySniper extends Enemy {
  EnemySniper(float minCoord, float maxCoord) {
    super(random(minCoord, maxCoord), random(minCoord, maxCoord), 10, new WeaponSniper(), 20, 20,1200);
    this.ammoDropChance = 0.7;
    this.healthPackDropChance  = 0.7;
    this.weaponDropChance = 0.01;
    this.im = rm.get("EnemySniper.png");    
  }
}

