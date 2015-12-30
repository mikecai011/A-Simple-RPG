class Bullet {
  float x, y;
  float speed;
  PImage bullet;

  Bullet(float tx, float ty, String col, boolean dir ) {
    x=tx;
    y=ty;
    if (col=="red") { //checks bullet colour
      bullet=loadImage("Data\\character/Bullet/redlaser.png");
    } else if (col=="blue") {
      bullet=loadImage("Data\\character/Bullet/bluelaser.png");
    }
    //true is right because whatever's right means it is also true, therefore false is left
    if (dir==true) {
      speed=5;
    } else if (dir==false) {
      speed=-5;
    }
  }

  void display() {
    imageMode(CENTER);
    image(bullet, x, y);
    x+=speed;
  }
}
