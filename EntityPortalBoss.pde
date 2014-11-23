class EntityPortalBoss extends EntityPortal {
  
  EntityPortalBoss() {
    super(0.0, 0.0, 100);
    this.spawnCounter = 1;
    this.spawnAmount  = floor(1+g.level/20);
  }
  
  Enemy enemy(){
    return new EnemyBoss(random(this.x-300,this.x+300),random(this.y-300,this.y+300));
  }
}

