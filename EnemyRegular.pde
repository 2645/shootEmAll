class EnemyRegular extends Enemy {
  EnemyRegular(float minCoord, float maxCoord) {
    super(random(minCoord, maxCoord), random(minCoord, maxCoord), 10, new WeaponPistol(), 50, 20,400);
    this.ammoDropChance = 0.7;
    this.healthPackDropChance  = 0.7;
    this.weaponDropChance = 0.01;
    this.im = rm.get("EnemyPistol.png");
  }
}

