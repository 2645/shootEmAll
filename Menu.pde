class Menu {
  Screen s;
  Button playButton;
  Menu(Screen s) {
    this.s = s;
    this.playButton = new Button(width/2-100,height/10,200,50);
  }

  void update() {
    background(0, 0, 0);
    textAlign(CENTER);
    text("PLEASE PRESS THE UP KEY\n( Z OR W DEPENDING ON QWERTY OR AZERTY )", width/2, height/2);
    textAlign(LEFT);
    showButtons();
  }
  
  void controlPressed(){
  }
  void controlReleased(){
  }
  void mouseClick(){
    checkButtons();
  }
  void showButtons(){
    playButton.show();
  }
  void checkButtons(){
    if(playButton.clicked(mouseX,mouseY)){
      s.state = 1;
    }
  }
}

