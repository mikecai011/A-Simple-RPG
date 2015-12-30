class BadGuy {

  float speed; 
  float x, y;
  float health, maxHealth, healthBarRatio;
  boolean dead;
  boolean hit;
  float maxDistance; //furthest distance for enemy to reach you
  boolean lr; // left or right, true==right, false==left
  boolean showfire; //true to show fire attack, false to hide
  PImage Enemy;
  PImage Fire; //melee attack

  BadGuy (float tx, float ty, float tspeed) {
    speed=tspeed;
    x=tx;
    y=ty;
    maxHealth=400; 
    health=maxHealth; 
    healthBarRatio=maxHealth/100; //health ratio used to determine length of the health bar in pixels
    dead = false;
    hit = false;
    maxDistance=14;
    lr=true;
    Enemy=loadImage("Data\\character/Richard/enemy/enemy0001.png");
    Enemy.resize(59, 122);
    showfire=false;
    Fire=loadImage("Data\\character/Fire/fire fries.png");
  }

  void display() {
    release(); 
    imageMode(CENTER);
    if (dead==false) {
      if (lr==true) {
        image(Enemy, x, y);
      } else {
        pushMatrix();
        scale(-1, 1);
        image(Enemy, -x, y);
        popMatrix();
      }
      healthbar();
      badGuyMovement();

      attack();
    }
  }

  void healthbar() {
    rectMode(CORNER);
    if (health<=0) {
      health=0;
      dead=true;
    }

    noStroke();
    fill(255, 0, 0);
    rect(x - health/healthBarRatio/2, y-80, health/healthBarRatio, 10);

    stroke(0);
    noFill();
    rect(x - health/healthBarRatio/2, y-80, maxHealth/healthBarRatio, 10);
  }

  void badGuyMovement() {
    if (hit==true) {
      if (x > f.location.x) {
        x+=10;
      } else if (x < f.location.x) {
        x-=10;
      }
      hit=false;
    }

    if (f.location.x - maxDistance - Enemy.width/2+20 > x) {
      lr=false;
      x+=speed;
    } else if (f.location.x + maxDistance +Enemy.width/2-20 <x) {
      lr=true;
      x-=speed;
    }
  }

  void attack() {
    if (abs(x - f.location.x) <= f.attackDistance && abs(y-f.location.y) <=Enemy.height/2 ) { //checks to see if character is within attack range
      showfire=true;
      f.health-=1;
      f.hit=true;
    }
  }

  void release() {
    if (y < height-Enemy.height/2) {
      y+=2;
    } else {
      y=height-Enemy.height/2;
    }
  }
}

