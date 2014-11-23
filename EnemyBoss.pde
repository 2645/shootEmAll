class EnemyBoss extends Enemy{
  EnemyBoss(){
    super(0,0,0,new WeaponSmg(),200,150,1000);
    this.healthPackDropChance = 1;
    this.ammoDropChance = 1;
    this.weaponDropChance = 1;
  }
  
  void dead(){
    g.entities.remove(this);
  }
}
