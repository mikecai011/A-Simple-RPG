class Shooter {
  //almost exactly the same as Bad Guy Class
  float speed;
  float x, y;
  float health, maxHealth, healthBarRatio;
  boolean dead;
  boolean hit;
  float maxDistance;

  boolean lr;
  boolean shoot;
  PImage Enemy;
  PImage bullet; //shoot attack
  ArrayList <Bullet> firedBullets;
  int reload;
  Shooter (float tx, float ty, float tspeed) {
    speed=tspeed;
    reload=0;
    x=tx;
    y=ty;
    maxHealth=400;
    health=maxHealth;
    healthBarRatio=maxHealth/100;
    dead = false;
    hit = false;
    shoot= false;
    maxDistance=14;
    lr=true;
    Enemy=loadImage("Data\\character/Richard/enemy2/enemy20001.png");
    Enemy.resize(59, 122);
    // firedBullets=new ArrayList<>();
    firedBullets=new ArrayList<Bullet>();
  }



  void display() {
    reload+=1;
    release(); 
    imageMode(CENTER);
    if (dead==false) {
      if (lr==false) {
        //fighter.resize(W, H);

        image(Enemy, x, y);
      } else {
        pushMatrix();
        scale(-1, 1);
        //fighter.resize(W, H);
        image(Enemy, -x, y);
        popMatrix();
      }
      healthbar();
      badGuyMovement();

      attack();
      bulletedge();
      bullethit();
      for (int i=0; i<firedBullets.size (); i++) {
        firedBullets.get(i).display();
      }
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
      lr=true;
      x+=speed;
    } else if (f.location.x + maxDistance +Enemy.width/2-20 <x) {
      lr=false;
      x-=speed;
    }
  }

  void attack() {
    if (reload%120==0 && y==height-Enemy.height/2) { //buffer time between each shot so its more like pistols and not rail guns
      firedBullets.add(new Bullet (x, y, "red", lr));
    }
  }

  void release() {
    if (y < height-Enemy.height/2) {
      y+=2;
    } else {
      y=height-Enemy.height/2;
    }
  }

  void bulletedge() { //checks if bullet hits edge
    for (int i=firedBullets.size ()-1; i>=0; i--) {
      if (firedBullets.get(i).x + firedBullets.get(i).bullet.width/2 >= width ||firedBullets.get(i).x - firedBullets.get(i).bullet.width/2 <=0) {
        firedBullets.remove(i);
      }
    }
  }

  void bullethit() { //checks if bullet hits person
    for (int i=firedBullets.size ()-1; i>=0; i--) {
      if (f.location.y +f.fighter.height/2 >= firedBullets.get(i).y ) {
        if (f.location.x - firedBullets.get(i).x >=-50 && f.location.x - firedBullets.get(i).x <=50) {
          f.health-=30;
          f.hit=true;
          firedBullets.remove(i);
        }
      }
    }
  }
}

