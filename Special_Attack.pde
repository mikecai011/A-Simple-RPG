class Yoshi {

  boolean fire;
  float x, y;
  float firex, firey; //x and y coordinates
  float recharge;
  PImage yoshi;
  PImage fireBall;
  Yoshi () {
    yoshi=loadImage("Data\\character/Yoshi/Yoshi/yoshi0001.png");
    yoshi.resize(yoshi.width/2, yoshi.height/2);
    fireBall=loadImage("Data\\character/Yoshi/FireBall/FireBall0001.png");
    fire=false;
    recharge=1800;
    x=width/2;
    y=height/2;
    firex=0;
    firey=height-fireBall.height/2;
  }

  void display() {

    if (recharge==1800) {
      image(yoshi, x, y);
      fireDisplay();
    }

    x+=random(-2, 2);
    y+=random(-2, 2);

    damage();
  }

  void fireDisplay() {
    firex+=10;
    image(fireBall, firex, firey);

    if (firex-fireBall.width/2 >= width) { //checks if attack leaves screen
      firex=0;
      recharge=0;
      f.special=false;
      x=width/2;
      y=height/2;
    }
  }

  void rechargebar() {
    rectMode(CORNER);

    noStroke();
    fill(0, 255, 0);
    rect(10, 10, recharge/3.6, 10);

    stroke(0);
    noFill();
    rect(10, 10, 1800/3.6, 10);
  }

  void damage() {
    for (int i=0; i<badguys.size (); i++) {
      if (firex-fireBall.width/2 <= badguys.get(i).x && badguys.get(i).x<= firex+fireBall.width/2 && badguys.get(i).y== height-badguys.get(i).Enemy.height/2) {
        badguys.get(i).health-=5;
      }
    }
    for (int i=0; i<shooters.size (); i++) {
      if (firex-fireBall.width/2 <= shooters.get(i).x && shooters.get(i).x <= firex+fireBall.width/2 && shooters.get(i).y== height-shooters.get(i).Enemy.height/2 ) {
        shooters.get(i).health-=5;
      }
    }
  }

  void recharging() {
    recharge+=1;
  }
}
