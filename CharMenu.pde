class CharMenu {
  MainMenu main;
  Button back,player1, player2;
  CharMenu(MainMenu main) {
    this.main = main;
    this.back = new Button(width-250,height-100,200,50);
    this.player1 = new Button(width/2-100, height/10, 200, 50);
    this.player2 =  new Button(width/2-100, 2*height/10, 200, 50);
  }

  void update() {
    show();
  }

  void show() {
    fill(33, 1, 1);
    rect(0, 0, width, height);
    showButtons();
  }

  void mouseClick() {
    checkButton();
  }

  void showButtons() {
    back.show();
    player1.show();
    player2.show();
  }

  void checkButton() {
    if (back.clicked(mouseX,mouseY)){
      main.state = 0;
    }
    if (player1.clicked(mouseX, mouseY)) {
      main.state = 0;
      main.s.state = 1;
      main.s.setType(new Player(500, 500, 20, new WeaponDev(), 100, 40));
    } else if (player2.clicked(mouseX, mouseY)) {
      main.state = 0;
      main.s.state = 1;
      main.s.setType( new Player(500, 500, 20, new WeaponCluster(), 100, 40));
    }
  }
}

