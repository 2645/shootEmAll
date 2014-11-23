abstract class EntityLiving extends Entity {

  Weapon w;
  float h;
  float maxHealth;

  EntityLiving(float x, float y, float speedFactor, Weapon w, float h, float size) {
    super(x, y, speedFactor, size);
    this.w =w;
    this.w.owner = this;
    this.h = h;
    this.maxHealth = h;
  }

  void fire() {
    this.w.fire();
  }

  void entityCol(Bullet e) {
    if (!e.e.equals(this) && this.collide(e)) {
      if (e.e instanceof Enemy && this instanceof Enemy) {
      } else {
        e.dead();
        this.h -= e.damage;
      }
      if (this.h<=0) {
        this.calculateDrop();
        this.isDead = true;
        this.dead();
        if(this instanceof Enemy && e.e instanceof Player){
          ((Player) ((Bullet) e).e).experience(((Enemy)this).exp);
        }
      }
    }
  }

  void entityCol(EntityLiving e) {
    if (this.collide(e)) {
      this.calculateBumpResult(e);
    }
  }

  void calculateBumpResult(EntityLiving e) {
    if (e instanceof Player) {
      e.h -=0.1;
    } else if (this instanceof Player) {
      this.h -=0.1;
    } else {
      float dir;
      if (this.x - e.x>=0) {
        dir = atan((this.y-e.y)/(this.x-e.x))-PI;
      } else {
        dir = atan((this.y-e.y)/(this.x-e.x));
      }
      float colX = cos(dir)*this.size/4 + e.x;
      float colY = sin(dir)*this.size/4 + e.y;
      e.x =  colX + e.size/4*cos(dir);
      e.y =  colY + e.size/4*sin(dir);
    }
  }

  void calculateDrop() {
    if (this instanceof Enemy) {
      if (((Enemy) this).ammoDropChance > random(0, 1)) {
        g.entities.add(new Ammo(this.x+random(-10, 10), this.y+random(-10, 10), this.dir));
      }
      if (((Enemy) this).healthPackDropChance > random(0, 1)) {
        g.entities.add(new HealthPack(this.x+random(-10, 10), this.y+random(-10, 10), this.dir));
      }
      if (((Enemy) this).weaponDropChance > random(0, 1)) {
        g.entities.add(new DropWeapon(this.x+random(-10, 10), this.y+random(-10, 10), this.dir, ((Enemy)this).w));
      }
    }
  }
}

