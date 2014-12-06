class EnemyRegular extends Enemy {
  EnemyRegular(float x, float y) {
    super(x, y, 10, new WeaponPistol(), 50, 40, 400);
    this.ammoDropChance = 0.7;
    this.healthPackDropChance  = 0.7;
    this.weaponDropChance = 1;
    this.im = rm.get("EnemyPistol.png");
  }
}

