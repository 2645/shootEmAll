class MainMenu {
  Screen s;
  Button charSelection;
  int state;
  CharMenu charMenu;
  MainMenu(Screen s) {
    this.s = s;
    this.charSelection = new Button(width/2-100, height/10, 200, 50);
    state = 0;
    this.charMenu = new CharMenu(this);
  }

  void update() {
    switch(state) {
    case 0 :
      current();
      break;
    case 1 :
      charSelection();
      break;
    case 2 : 
      options();
      break;
    }
  }

  void current() {
    show();
  }

  void charSelection() {
    charMenu.update();
  }

  void options() {
  }

  void show() {
    background(0, 0, 0);
    textAlign(CENTER);
    text("PLEASE PRESS THE RED SQUARE TO START", width/2, height/2);
    textAlign(LEFT);
    showButtons();
  }

  void controlPressed() {
    switch(state) {
    case 0 :
      break;
    case 1 : 
      break;
    case 2 : 
      break;
    }
  }

  void controlReleased() {
    switch(state) {
    case 0 :
      break;
    case 1 : 
      break;
    case 2 : 
      break;
    }
  }

  void mouseClick() {
    switch(state) {
    case 0 :
      checkButtons();
      break;
    case 1 : 
      charMenu.mouseClick();
      break;
    case 2 : 
      break;
    }
  }

  void showButtons() {
    charSelection.show();
  }

  void checkButtons() {
    if (charSelection.clicked(mouseX, mouseY)) {
      state = 1;
    }
  }
}

