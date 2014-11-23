class EnemyBoss extends Enemy{
  EnemyBoss(float x, float y){
    super(x,y,0,new WeaponSmg(),200,150,3000);
    this.healthPackDropChance = 1;
    this.ammoDropChance = 1;
    this.weaponDropChance = 1;
  }
  
  void dead(){
    g.entities.remove(this);
  }
}
