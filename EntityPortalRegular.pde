class EntityPortalRegular extends EntityPortal {

  EntityPortalRegular() {
    super(random(g.minCoord+400,g.maxCoord-400), random(g.minCoord+400,g.maxCoord-400), 40);
    this.spawnCounter = floor(1+g.level/4);
    this.spawnAmount  = 5;
  }

  Enemy enemy() {
    float random = random(0, 1);
    if (random > 0.8) {
      return new EnemySniper(random(this.x-200, this.x+200), random(this.y-200, this.y+200));
    } else {
      return new EnemyRegular(random(this.x-200,this.x+200) , random(this.y-200, this.y+200));
    }
  }
}

