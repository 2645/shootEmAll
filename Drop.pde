abstract class Drop extends Entity {
  
  float life;
  Drop(float x, float y, float dir) {
    super(x, y, 0, dir, 10);
    this.life = millis();
  }

  boolean despawned(){
   return millis()-this.life>20000; 
  }  
  
  void entityCol(Player e){
    if(this instanceof HealthPack){
      ((HealthPack) this).entityCol((Player ) e);
    }else if (this instanceof Ammo){
      ((Ammo) this).entityCol((Player) e);
    }else if (this instanceof DropWeapon){
      ((DropWeapon) this).entityCol((Player) e);
    }else{
      this.entityCol(e);
    }
  }
}

