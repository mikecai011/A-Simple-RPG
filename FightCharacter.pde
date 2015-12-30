class FightCharacter {
  Yoshi y;
  String CharacterChoice;
  PVector location;
  PImage fighter;
  int shrink;
  int framenum;
  int enemyNum;
  float jumpFrameSpeed;
  float runFrameSpeed;
  float walkFrameSpeed;
  float attackFrameSpeed;
  float speed;
  float normalSpeed;
  float fighterHeight;
  float attackDistance;
  float jumpspeed;
  float jumptime;
  float absJumptime;
  float count;
  float maxJumpHeight;
  float maxJumpDistance;
  float jumpDistance;
  float jumpHeight;
  float verticleShift;
  float health, maxHealth, healthBarRatio;
  float reload;
  float attackPower;
  boolean direction; //true=right, false=left
  boolean idle;
  boolean running;
  boolean jumping;
  boolean attacking;
  boolean ground;
  boolean dead;
  boolean hit;
  boolean special;
  ArrayList<PImage> walk;
  ArrayList<PImage> run;
  ArrayList<PImage> jump;
  ArrayList<PImage> attack;
  ArrayList<String> movement;
  ArrayList <Bullet> firedBullets;
  //String tmovement;
  ArrayList<String> movementCommands;
  ArrayList<String> jumpCommands;
  ArrayList<String> attackCommands;
  ArrayList<String> specialCommand;  

  FightCharacter(float tx, float ty, int tenemyNum, String character) {
    enemyNum=tenemyNum;
    framenum=0; //used to replace frameCount, gives programmer more control
    dead= false;
    hit = false;
    location = new PVector (tx, ty);
    direction= true;
    idle=true;
    jumping=false;
    running=false;
    attacking=false;
    ground=true;
    special=false;
    walk= new ArrayList<PImage>();
    run= new ArrayList<PImage>();
    jump= new ArrayList<PImage>();
    attack= new ArrayList<PImage>();
    movementCommands=new ArrayList<String>();
    movementCommands.add("none");
    jumpCommands=new ArrayList<String>();
    jumpCommands.add("none");
    attackCommands=new ArrayList<String>();
    attackCommands.add("none");
    specialCommand=new ArrayList<String>();
    specialCommand.add("none");
    y=new Yoshi();//special attack
    CharacterChoice=character;


    if (CharacterChoice=="King Leo") {
      jumpFrameSpeed=1.5; //frame change speed for jumps
      runFrameSpeed=2; //frame change speed for running
      walkFrameSpeed=2; //frame change speed for walking
      attackFrameSpeed=0.8; //frame change speed for attacking
      attackDistance=60; //distance to hit
      maxHealth=3000; // health
      health=maxHealth; 
      healthBarRatio=maxHealth/500;
      jumpspeed = 0.3;
      absJumptime = 15; //length of jump timewise
      jumptime=-absJumptime;
      normalSpeed=0.8;
      speed=normalSpeed;
      maxJumpHeight=1;
      jumpHeight=maxJumpHeight;
      maxJumpDistance=.5;
      jumpDistance=maxJumpDistance;
      verticleShift=  (jumpDistance* pow(jumptime, 2)); // constant value in jumping parabola
      shrink=2;
      attackPower=50;
      //walking
      loadData(walk, "Adam", "King Leo Walking", 30);
      //running
      loadData(run, "Adam", "King Leo Running", 62);
      // jumping
      loadData(jump, "Adam", "King Leo jumping", 72);
      //FOR NARNIA!!!!
      loadData(attack, "Adam", "King Leo Striking", 29);
    } else if (CharacterChoice=="Knight") {
      jumpFrameSpeed=1.5;
      runFrameSpeed=2;
      walkFrameSpeed=2;
      attackFrameSpeed=0.8;
      attackDistance=40;
      maxHealth=5000;
      health=maxHealth;
      healthBarRatio=maxHealth/500;
      jumpspeed = 0.3;
      absJumptime = 15;
      jumptime=-absJumptime;
      normalSpeed=2;
      speed=normalSpeed;
      maxJumpHeight=1;
      jumpHeight=maxJumpHeight;
      maxJumpDistance=.5;
      jumpDistance=maxJumpDistance;
      verticleShift=  (jumpDistance* pow(jumptime, 2));
      shrink=2;
      attackPower=20;
      //walking
      loadData(walk, "Jason", "knightrun", 20);
      //running
      loadData(run, "Jason", "run", 20);
      // jumping
      loadData(jump, "Jason", "jump", 1);
      //FOR NARNIA!!!!
      loadData(attack, "Jason", "knightattack", 15);
    } else if (CharacterChoice=="Robot") {
      reload=0;
      jumpFrameSpeed=4.5;
      runFrameSpeed=10;
      walkFrameSpeed=3;
      attackFrameSpeed=0.8;
      attackDistance=40;
      maxHealth=2000;
      health=maxHealth;
      healthBarRatio=maxHealth/500;
      jumpspeed = 0.3;
      absJumptime = 15;
      jumptime=-absJumptime;
      normalSpeed=2;
      speed=normalSpeed;
      maxJumpHeight=3;
      jumpHeight=maxJumpHeight;
      maxJumpDistance=.25;
      jumpDistance=maxJumpDistance;
      verticleShift=  (jumpDistance* pow(jumptime, 2));
      shrink=2;
      firedBullets=new ArrayList<Bullet>();
      //walking
      loadData(walk, "Richard", "Walking", 22);
      //running
      loadData(run, "Richard", "Running", 2);
      // jumping
      loadData(jump, "Richard", "jump", 1);
      //FOR NARNIA!!!!
      loadData(attack, "Richard", "Walking", 1);
    }

    fighter = walk.get(int(framenum/4.5) % walk.size());
    fighterHeight=fighter.height/2;
    location.y=height-fighterHeight;
  }

  void loadData(ArrayList<PImage> arl, String character, String move, int amount) {
    for (int a=1; a<=amount; a++) {
      arl.add(loadImage("Data\\character/"+character+"/"+move+"/"+move+(character.equals("Kirby")?"_":"")+ (character.equals("Kirby")==false&&a<1000?"0":"")+(a<100? "0":"")+(a<10? "0":"")+ (a) + ".png"));
      arl.get(a-1).resize(arl.get(a-1).width/shrink, arl.get(a-1).height/shrink);
    }
  }

  void move() {
    if (health==0) {
      dead=true;
    }

    framenum+=1;
    reload+=1;

    imageMode(CENTER);
    count=framenum/walkFrameSpeed;
    healthbar();
    y.rechargebar();

    if (CharacterChoice=="Robot") {
      bulletedge();
      for (int i=0; i<firedBullets.size (); i++) {
        firedBullets.get(i).display();
      }
    }      
    if (jumpCommands.get(jumpCommands.size()-1).equals("jump")) { //checks if jumping command given

      jumping=true;
    }

    if (y.recharge<1800) {
      y.recharging();
      removeSpecialCommand("special");
    }

    if (attackCommands.get(attackCommands.size()-1).equals("attack")) { //checks if attacking command given
      attacking=true;
    } else {
      attacking=false;
    }

    if (specialCommand.get(specialCommand.size()-1).equals("special")) {
      special=true;
    }

    if (attacking==true) {
      count=framenum/attackFrameSpeed;

      if (CharacterChoice=="Robot") {
        if (reload%20==0) {
          firedBullets.add(new Bullet (location.x+5, location.y, "blue", direction));
          reload=0;
        }
      }
    }

    if (running==true) { //checks for running command
      speed=normalSpeed*1.5;
      count=framenum/runFrameSpeed;
    } else {
      speed=normalSpeed;
    }

    if (running==true && jumping==false) {
      jumpDistance=maxJumpDistance*0.8;
      jumpHeight=maxJumpHeight*1.5;
      verticleShift=  (jumpDistance* pow(jumptime, 2));
    } 

    if (jumping==true) {
      location.y =(height-fighterHeight) - jumpHeight * (-jumpDistance * (pow (jumptime, 2))+verticleShift);
      jumptime+=jumpspeed;
      if (jumptime >= absJumptime +jumpspeed) {
        jumptime=-absJumptime;
        jumping=false;
        location.y = height-fighterHeight;
        jumpHeight = maxJumpHeight;
        jumpDistance=maxJumpDistance;
        verticleShift=  (jumpDistance* pow(jumptime, 2));
      } 

      if (location.y+fighterHeight >= height) {
        framenum=0;
      }
      count=framenum/jumpFrameSpeed;
    }

    if (movementCommands.get(movementCommands.size()-1).equals("right")) {
      edges();

      location.x+=speed;
      direction=true;
      show(count, true);
    } else if (movementCommands.get(movementCommands.size()-1).equals("left")) {
      edges();

      location.x-=speed;
      direction=false;
      show(count, false);
    } else {
      show(count, direction);
    }

    if ((movementCommands.size()>=2 || attackCommands.size()>=2) || jumping==true) {
      idle=false;
    } else {
      idle=true;
    }
  }

  void show(float a, boolean lr) {

    if (special==true) {
      y.display();
    }
    if (idle==true) {
      a=1;
    } 
    if (running==false) {

      fighter=walk.get(int(a)%walk.size());
    } else if (running==true) {
      if (idle==true) {
        a=1;
      }
      fighter=run.get(int(a)%run.size());
    } 
    if (jumping==true) {
      fighter=jump.get(int(a)%jump.size());
    }
    if (attacking==true) {
      fighter=attack.get(int(a)%attack.size());
    }
    damage();
    if (lr==true) {
      image(fighter, location.x, location.y);
    } else {
      pushMatrix();
      scale(-1, 1);
      image(fighter, -location.x, location.y);
      popMatrix();
    }
  }

  boolean findMoveCommand(String command) {
    for (int i=0; i<=movementCommands.size ()-1; i++) {
      if (movementCommands.get(i).equals(command)) {
        return true;
      }
    }
    return false;
  }

  boolean findSpecialCommand(String command) {
    for (int i=0; i<=specialCommand.size ()-1; i++) {
      if (specialCommand.get(i).equals(command)) {
        return true;
      }
    }
    return false;
  }

  boolean findJumpCommand(String command) {
    for (int i=0; i<=jumpCommands.size ()-1; i++) {
      if (jumpCommands.get(i).equals(command)) {
        return true;
      }
    }
    return false;
  }

  boolean findAttackCommand(String command) {
    for (int i=0; i<=attackCommands.size ()-1; i++) {
      if (attackCommands.get(i).equals(command)) {
        return true;
      }
    }
    return false;
  }

  void removeMoveCommand(String command) {
    for (int i = 0; i<=movementCommands.size ()-1; i++) {
      if (movementCommands.get(i).equals(command)) {
        movementCommands.remove(i);
      }
    }
  }

  void removeJumpCommand(String command) {
    for (int i = 0; i<=jumpCommands.size ()-1; i++) {
      if (jumpCommands.get(i).equals(command)) {
        jumpCommands.remove(i);
      }
    }
  }

  void removeAttackCommand(String command) {
    for (int i = 0; i<=attackCommands.size ()-1; i++) {
      if (attackCommands.get(i).equals(command)) {
        attackCommands.remove(i);
      }
    }
  }

  void removeSpecialCommand(String command) {
    for (int i = 0; i<=specialCommand.size ()-1; i++) {
      if (specialCommand.get(i).equals(command)) {
        specialCommand.remove(i);
      }
    }
  }

  void edges() {
    if (movementCommands.get(movementCommands.size()-1).equals("right") && location.x+speed+fighter.width/2>=width) {
      speed=0;
    } else if (movementCommands.get(movementCommands.size()-1).equals("left")&& location.x-speed-fighter.width/2<=0) {
      speed=0;
    }
  }

  void damage() {
    if (CharacterChoice=="Robot") {
      if (badguys.size()>0 && firedBullets.size()>0) {
        for (int n = badguys.size ()-1; n>=0; n--) {
          for (int i=firedBullets.size ()-1; i >= 0; i--) {
            if (firedBullets.get(i).y > height - badguys.get(n).Enemy.height && badguys.get(n).y == height-badguys.get(n).Enemy.height/2) {
              if (badguys.get(n).x - firedBullets.get(i).x >=-50 && badguys.get(n).x - firedBullets.get(i).x <=50) {
                badguys.get(n).health-=40;
                firedBullets.remove(i);
              }
            }
          }
        }
      }
      if (shooters.size()>0 && firedBullets.size()>0) {
        for (int n = shooters.size ()-1; n >= 0; n--) {
          for (int i=firedBullets.size ()-1; i >= 0; i--) {
            if (firedBullets.get(i).y > height - shooters.get(n).Enemy.height && shooters.get(n).y == height-shooters.get(n).Enemy.height/2) {
              if (shooters.get(n).x - firedBullets.get(i).x >=-50 && shooters.get(n).x - firedBullets.get(i).x <=50) {
                shooters.get(n).health-=40;
                firedBullets.remove(i);
              }
            }
          }
        }
      }
    } else if (attacking==true) {
      for (int i=0; i<badguys.size (); i++) {
        if (direction==true && location.x - badguys.get(i).x >= -attackDistance && location.x -badguys.get(i).x <= 0 && abs(badguys.get(i).y-location.y) <=fighter.height/2) {
          badguys.get(i).health -= 10;
          badguys.get(i).hit=true;
        } else if (direction==false && location.x-badguys.get(i).x<= attackDistance && location.x - badguys.get(i).x >=0 && abs(badguys.get(i).y-location.y) <=fighter.height/2) {
          badguys.get(i).health -= 10;
          badguys.get(i).hit=true;
        }
      }
      for (int i=0; i < shooters.size (); i++) {
        if (direction==true && location.x - shooters.get(i).x >= -attackDistance && location.x -shooters.get(i).x <= 0 && abs(shooters.get(i).y-location.y) <=fighter.height/2) {
          shooters.get(i).health -= 10;
          shooters.get(i).hit=true;
        } else if (direction==false && location.x-shooters.get(i).x<= attackDistance && location.x - shooters.get(i).x >=0 && abs(shooters.get(i).y-location.y) <=fighter.height/2) {
          shooters.get(i).health -= 10;
          shooters.get(i).hit=true;
        }
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
    rect(width-10-500, 10, health/healthBarRatio, 10);

    stroke(0);
    noFill();
    rect(width-10-500, 10, maxHealth/healthBarRatio, 10);
  }

  void bulletedge() {
    for (int i=firedBullets.size ()-1; i>=0; i--) {
      if (firedBullets.get(i).x + firedBullets.get(i).bullet.width/2 >= width ||firedBullets.get(i).x - firedBullets.get(i).bullet.width/2 <=0) {
        firedBullets.remove(i);
      }
    }
  }
}

