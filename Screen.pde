class Screen {

  Game g;
  float timer;
  boolean first =true;
  float startingTime;
  int state;
  Screen(Game g) {
    this.g = g;
    this.startingTime = millis();
    this.state = 0;
  }

  void update() {
    switch(state) {
    case 0:
      updateMainMenu();
      break;
    case 1:
      updateGame();
      break;
    }
  }

  void updateMainMenu() {
    background(0, 0, 0);
    textAlign(CENTER);
    text("PLEASE PRESS THE UP KEY\n( Z OR W DEPENDING ON QWERTY OR AZERTY )",width/2,height/2);
    textAlign(LEFT);
  }

  void updateGame() {
    background(0, 0, 0);
    ellipseMode(CENTER);
    rectMode(CENTER);
    g.update();
    rectMode(CORNERS);
    time();
    level();
    expLevel();
    itemInfo();
  } 

  void time() {
    String s = "TIME : ";
    if ((millis()-startingTime)/1000/60 < 10) {
      s+="0";
    }
    s+=floor((millis()-startingTime)/1000/60) +":";
    if ((millis()-startingTime)/1000%60 < 10) {
      s+="0";
    }
    s+=floor((millis()-startingTime)/1000%60);
    fill(0, 0, 1);
    text(s, 0, 36);
  }

  void level() {
    String s = "LEVEL : "+round(g.level);
    fill(0, 0, 1);
    text(s, 0, 72);
  }

  void expLevel(){
    String s = "expLevel : "+ g.p.lvl;
    text(s,0,108);
    float border = g.p.exp/g.p.expNeeded*100;
    fill(33,0.7,1);
    rect(0,144,border,164);
    fill(0,0,1);
    rect(border,144,101,164);
  }
  
  void restart() {
    this.g = new Game();
  }

  void itemInfo() {
    fill(0, 1, 1);
    rect(0, height-100, width, height);
    fill(0, 0, 1);
    text("health : ", 100, height-64);
    text(getHealth(), 100, height-28);
    text("weapon : "+getWeapon(), 100+width/3, height-64);
    text("damage : "+getDamage(), 100+width/3, height-28);
    text("ammo : ", 100+2*width/3, height-64);
    text(getAmmo(), 100+2*width/3, height-28);
  }

  String getHealth() {
    return (round(g.p.h) + "/" + round(g.p.maxHealth));
  }

  String getWeapon() {
    return g.p.w.n;
  }

  String getAmmo() {
    return (round(g.p.w.ammo)+ "/" + round(g.p.w.maxAmmo));
  }

  String getDamage() {
    return (round(g.p.w.bullet.damage)+"");
  }
}

