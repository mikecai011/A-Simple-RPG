class MainCharacter {
  PVector position;
  PVector nextPos;
  float displayImageWidth, displayImageHeight;
  float speed;
  int W, H;   //for character sprite sheet----width and height of each small picture
  int takingKey;  //the key number the player is fighting for/trying to take now
  int keyTaken;
  String facingDirection;
  PImage characterSheet;
  color pixel;
  ArrayList<String> directionCommands;
  ArrayList<PImage> moveLeft;
  ArrayList<PImage> moveRight;
  ArrayList<PImage> moveUp;
  ArrayList<PImage> moveDown;

  MainCharacter(float x_, float y_) {
    position=new PVector (x_, y_);
    speed=3;
    keyTaken=0;
    facingDirection="right";
    directionCommands=new ArrayList<String>();
    directionCommands.add("no");
    moveLeft=new ArrayList<PImage>();
    moveRight=new ArrayList<PImage>();
    moveUp=new ArrayList<PImage>();
    moveDown=new ArrayList<PImage>();
    //------------------------------------------load character images
    loadData(moveDown, "william", 0, 3);
    loadData(moveLeft, "william", 1, 3);
    loadData(moveRight, "william", 2, 3);
    loadData(moveUp, "william", 3, 3);
  }

  void execute() {
    pushStyle();
    pushMatrix();
    imageMode(CENTER);
    movement();
    getKey();
    popMatrix();
    popStyle();
  }


  void movement() {     //--------------------------------------------check moving keys
    if ( directionCommands.get(directionCommands.size()-1).equals("no")) {
      idle();
      nextPos=new PVector(position.x, position.y);
    } else {
      if (directionCommands.get(directionCommands.size()-1).equals("left")) {
        nextPos=new PVector(position.x-speed, position.y);
        if (collision()==false) {
          if (outOfMovingArea()==true) {  //when out of moving area, move the location where map and keys are drawn
            mainMap.mapPos.x+=speed;
            moveKey("left");
          } else {
            position.x-=speed;  //move character
          }
        }
        facingDirection="left";
        display(moveLeft, false);
      } else if (directionCommands.get(directionCommands.size()-1).equals("right")) {
        nextPos=new PVector(position.x+speed, position.y);
        if (collision()==false) {
          if (outOfMovingArea()==true) {
            mainMap.mapPos.x-=speed;
            moveKey("right");
          } else {
            position.x+=speed;
          }
        }
        facingDirection="right";
        display(moveRight, false);
      } else if (directionCommands.get(directionCommands.size()-1).equals("up")) {
        nextPos=new PVector(position.x, position.y-speed);
        if (collision()==false) {
          if (outOfMovingArea()==true) {
            mainMap.mapPos.y+=speed;
            moveKey("up");
          } else {
            position.y-=speed;
          }
        }
        facingDirection="up";
        display(moveUp, false);
      } else if (directionCommands.get(directionCommands.size()-1).equals("down")) {
        nextPos=new PVector(position.x, position.y+speed);
        if (collision()==false) {
          if (outOfMovingArea()==true) {
            mainMap.mapPos.y-=speed;
            moveKey("down");
          } else {
            position.y+=speed;
          }
        }
        facingDirection="down";
        display(moveDown, false);
      }
    }
  }


  void getKey() {
    for (int a=0; a<keys.size (); a++) {
      if (keys.get(a).checkTaking()==true) {
        takingKey=a;
        screen=Screen.Choosecharacter;
      }
    }
  }


  void display(ArrayList<PImage>action, boolean idle) {
    PImage current;
    if (idle==true) {
      current = action.get(1);
    } else {
      current = action.get(int(frameCount/4.5) % action.size());
    } 
    scale(1, 1);
    displayImageWidth=current.width*1.5;
    displayImageHeight=current.height*1.5;
    image(current, position.x, position.y-displayImageHeight/2, displayImageWidth, displayImageHeight);  //y-value correction, so that the position value is at the centre of feet
  }


  void idle() {                                                        //when idle, check facing which way
    if (facingDirection.equals("right")) {
      display(moveRight, true);
    } else if (facingDirection.equals("left")) {
      display(moveLeft, true);
    } else if (facingDirection.equals("up")) {
      display(moveUp, true);
    } else if (facingDirection.equals("down")) {
      display(moveDown, true);
    }
  }


  boolean collision() {
    pushStyle();
    image(mainMap.collisionMap, mainMap.mapPos.x, mainMap.mapPos.y );  //imageMode here is CENTER
    imageMode(CORNER);
    for (int row=int (nextPos.y)-int(speed)-10; row<=int(nextPos.y); row++) {      // "-10" is to correct the looking 
      for (int column=int (nextPos.x)-10; column<=int(nextPos.x)+10; column++) {
        pixel=get(column, row);
        if (pixel==color(160, 14, 65)) {
          image(mainMap.environment, 0, 0);
          popStyle();
          return true;
        }
      }
    }
    image(mainMap.environment, 0, 0);
    popStyle();
    return false;
  }


  boolean outOfMovingArea() {
    if (nextPos.x<=width*0.2||nextPos.x>=width*0.8||nextPos.y<=height*0.2||nextPos.y>=height*0.8) {
      return true;
    } else {
      return false;
    }
  }


  void removeDirCommand(String command) {                                            //remove direction commands that are released from the keyboard
    for (int a=directionCommands.size ()-1; a >= 0; a--)
      if (directionCommands.get(a).equals(command)) {
        directionCommands.remove(a);
      }
  }


  boolean searchDirCommand(String command) {                                         //search if one direction command already exists in the array
    for (int a=0; a<=directionCommands.size ()-1; a++) {
      if (directionCommands.get(a).equals(command)) {
        return true;
      }
    }
    return false;
  }


  void loadData(ArrayList<PImage>arl, String name, int row, float amount) {            //function designed for loading images
    characterSheet=loadImage("Data\\character\\"+name+"/"+name+".png");
    W =  characterSheet.width/12;
    H =  characterSheet.height/8;
    for (int a=0; a<amount; a++) {
      arl.add(characterSheet.get(W*a, H*row, W, H));
    }
  }
}

