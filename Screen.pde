class Screen {

  Game g;
  float timer;
  boolean first =true;
  float startingTime;
  int state;
  Menu mainMenu;
  Screen(Game g) {
    this.g = g;
    this.startingTime = millis();
    this.state = 0;
    this.mainMenu = new Menu(this);
    checkConfig();
  }

  BufferedReader config;
  PrintWriter output;
  void checkConfig() {
    if(fileExists()){
      executeConfig();
    }else{
      createConfig();
      checkConfig();
    }
  }
  
  void createConfig(){
    println("creating config");
    output = createWriter(dataPath("cfg/cfg.xxx"));
    output.println("qwerty: \t" + 1);
    output.flush();
    output.close();
  }
  
  void executeConfig(){
    println("reading from config");
    config = createReader(dataPath("cfg/cfg.xxx"));
    String s = "";
    try{
      s = config.readLine();
    } catch (IOException e){
    }
    String[] value  = split(s,TAB);
    if(int(value[1]) == 1){
      qwerty = true;
    }else{
      qwerty  = false;
    }
    
  }
  
  boolean fileExists(){
    File f = new File(dataPath("cfg/cfg.xxx"));
    return f.exists();
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
    mainMenu.update();
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
    if ((millis()-g.startingTime)/1000/60 < 10) {
      s+="0";
    }
    s+=floor((millis()-g.startingTime)/1000/60) +":";
    if ((millis()-g.startingTime)/1000%60 < 10) {
      s+="0";
    }
    s+=floor((millis()-g.startingTime)/1000%60);
    fill(0, 0, 1);
    text(s, 0, 36);
  }

  void level() {
    String s = "LEVEL : "+round(g.level);
    fill(0, 0, 1);
    text(s, 0, 72);
  }

  void expLevel() {
    String s = "expLevel : "+ g.p.lvl;
    text(s, 0, 108);
    float border = g.p.exp/g.p.expNeeded*100;
    fill(33, 0.7, 1);
    rect(0, 144, border, 164);
    fill(0, 0, 1);
    rect(border, 144, 101, 164);
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

  void controlPressed() {
    if (key == 'R' || key == 'r') {
      this.g = new Game();
      s.state = 1;
      loop();
    }
    switch(state) {
    case 0:
      mainMenu.controlPressed();
      break;
    case 1:
      convertControlPressed();
      break;
    }
  }

  void controlReleased() {
    switch(state) {
    case 0:
      mainMenu.controlReleased();
      break;
    case 1:
      convertControlReleased();
      break;
    }
  }

  void convertControlPressed() {   
    g.controlPressed(convertControl());
  }
  void convertControlReleased() {
    g.controlReleased(convertControl());
  }
  void mousePress() {
    switch(state) {
    case 0:
      mainMenu.mouseClick();
      break;
    case 1:
      g.mousePress();
      break;
    }
  }
  void mouseRelease() {
    switch(state) {
    case 0:
      break;
    case 1:
      g.mouseRelease();
      break;
    }
  }

  boolean qwerty = true;
  int convertControl() {
    int control =100;
    if (qwerty) {
      if (key == 'W' || key == 'w') {
        control = 1;
      } else if (key =='S' || key == 's') {
        control = 2;
      } else if (key == 'A' || key == 'a') {
        control = 3;
      } else if (key == 'D' || key == 'd') {
        control = 4;
      }
    } else {
      if (key == 'Z' || key == 'z') {
        control = 1;
      } else if (key =='S' || key == 's') {
        control = 2;
      } else if (key == 'Q' || key == 'q') {
        control = 3;
      } else if (key == 'D' || key == 'd') {
        control = 4;
      }
    }
    if (key == CODED) {
      if (keyCode == SHIFT) {
        control = 5;
      }
    }
    return control;
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

