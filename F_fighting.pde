void fighting() {
  if (fightSetUp==true) {
    me.directionCommands.clear();
    me.directionCommands.add("no");
    f.movementCommands.clear();
    f.movementCommands.add("none");
    badguys.clear();
    shooters.clear();
    enemyNum=10;   //number of mellee enemies
    shooterNum=5;   //number of distance enemies
    for (int i=0; i<enemyNum; i++) {
      badguys.add(new BadGuy(random(0, width), 0, random(0.1, 0.6)));
    }
    for (int i=0; i<shooterNum; i++) {
      shooters.add(new Shooter(random(0, width), 0, random(0.1, 0.6)));
    }
    fightSetUp=false;
  }

  pushStyle();
  background(fightBackground);
  for (int i=0; i<badguys.size (); i++) {
    if (badguys.get(i).showfire==true) {
      imageMode(CENTER);
      image(badguys.get(i).Fire, badguys.get(i).x, badguys.get(i).y, 79*1.5, 100*1.5);
      badguys.get(i).showfire=false;
    }
  }

  f.move();

  if (f.dead==true) {
    //respawn without taking the key
    me.position=new PVector (width/2, height/2);
    mainMap.mapPos=new PVector (width/2+1200, height/2+1600);
    for (int i=0; i<keys.size (); i++) {
      keys.get(i).location=new PVector(keys.get(i).initialLocation.x, keys.get(i).initialLocation.y);
    }
    keys.get(me.takingKey).taken=false;
    screen=Screen.Explore;
  }


  for (int i=0; i < badguys.size (); i++) { //loads mellee enemies
    badguys.get(i).display();
  }

  for (int i=0; i < shooters.size (); i++) { //loads shooter enemies
    shooters.get(i).display();
  }

  for (int i=badguys.size ()-1; i>=0; i--) { //checks if mellee enemies are dead
    if (badguys.get(i).dead==true) {
      badguys.remove(i);
    }
  }
  for (int i=shooters.size ()-1; i>=0; i--) { //checks if shooter enemies are dead
    if (shooters.get(i).dead==true) {
      shooters.remove(i);
    }
  }

  if (badguys.size()==0&&shooters.size()==0) {
    keys.get(me.takingKey).taken=true;
    me.keyTaken+=1;
    screen=Screen.Explore;
  }
  popStyle();
}

