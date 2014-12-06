class Button{
  int x,y,w,h;
  Button(int x, int y, int w, int h){
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }
  
  void show(){
    fill(0,1,1);
    rect(this.x,this.y,this.w,this.h);
  }
  
  boolean clicked(int mx, int my){
    return (mx >= this.x && mx <= this.x+this.w && my >= this.y && my <= this.y+h);
  }
}
