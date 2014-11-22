class EntityPortalRegular extends EntityPortal {

  EntityPortalRegular() {
    super(random(g.minCoord+100,g.maxCoord-100), random(g.minCoord+100,g.maxCoord+100), 40);
    this.spawnCounter = floor(1 + g.level);
  }

  Enemy enemy() {
    float random = random(0, 1);
    if (random > 0.8) {
      return new EnemySniper(random(this.x-50, this.x+50), random(this.y-50, this.y+50));
    } else {
      return new EnemyRegular(random(this.x-50,this.x+50) , random(this.y-50, this.y+50));
    }
  }
}

