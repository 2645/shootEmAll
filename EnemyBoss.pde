class EnemyBoss extends Enemy{
  EnemyBoss(){
    super(0,0,0,new WeaponCluster(),1000,150,1000);
    this.healthPackDropChance = 1;
    this.ammoDropChance = 1;
    this.weaponDropChance = 1;
  }
}
