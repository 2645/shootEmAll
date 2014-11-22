class EntityPortalBoss extends EntityPortal {
  
  EntityPortalBoss() {
    super(0, 0, 100);
    this.spawnCounter = floor(1 + g.level/20);
  }
  Enemy enemy(){
    return new EnemyBoss();
  }
}

