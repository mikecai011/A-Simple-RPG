import ddf.minim.*;
Minim minim;
AudioPlayer menuBGM;
Screen screen;  //Variable name "screen", variable type Screen

//--------------------------Menu
PImage menuBackground;
PImage startButton;
//--------------------------Explore
MainCharacter me;
Map mainMap;
//---------------------------Keys
ArrayList<Key> keys;
//---------------------------Choose character before fighting
PImage kingLeo, knight, robot, background;
float adjustment;
//---------------------------Fighting
FightCharacter f;
ArrayList<Shooter> shooters;
ArrayList<BadGuy> badguys;
int enemyNum, shooterNum;
PImage fightBackground;
boolean fightSetUp;

void setup() {
  size(displayWidth/4*3, displayHeight/4*3);
  frame.setResizable(true);
  screen=Screen.Menu;
  minim = new Minim(this);  //this is used for audio library
  //------------------Menu
  menuBackground=loadImage("Data\\menu/Menu Background.png");
  startButton=loadImage("Data\\menu/Start Button.png");
  menuBGM=minim.loadFile("Data\\music/Furui Ningyou.mp3");
  //------------------Explore
  me=new MainCharacter (width/2, height/2);
  mainMap=new Map("map01");
  //------------------Keys
  keys=new ArrayList <Key>();
  loadKeys();
  //------------------Choose character
  kingLeo=loadImage("Data\\choose_character/King Leo Walking0001.png");
  knight=loadImage("Data\\choose_character/knightrun0001.png");
  robot=loadImage("Data\\choose_character/Walking0001.png");
  background=loadImage("Data\\choose_character/Arena.jpg");
  //------------------Fighting
  f = new FightCharacter(width/2, height/2, enemyNum, "King Leo");
  fightBackground=loadImage("Data\\Background/Dark Room/Dark Room0001.png");
  fightBackground.resize(width, height);
  shooters = new ArrayList<Shooter>();
  badguys = new ArrayList<BadGuy>();
}

void draw() {
  if (screen==Screen.Menu) {
    menu();
  } else if (screen==Screen.Explore) {
    explore();
  } else if (screen==Screen.Choosecharacter) {
    chooseCharacter();
  } else if (screen==Screen.Fightscene) {
    fighting();
  }
}

void keyPressed() {
  //-----------------------------------------Explore
  if (screen==Screen.Explore) {
    if (keyCode == LEFT&&me.searchDirCommand("left")==false) {
      me.directionCommands.add("left");
    } else if (keyCode==RIGHT&&me.searchDirCommand("right")==false) {
      me.directionCommands.add("right");
    } else if (keyCode == UP&&me.searchDirCommand("up")==false) {
      me.directionCommands.add("up");
    } else if (keyCode==DOWN&&me.searchDirCommand("down")==false) {
      me.directionCommands.add("down");
    }
  }
  //--------------------------------------------Fight Scene
  else if (screen==Screen.Fightscene) {
    if (keyCode == RIGHT && f.findMoveCommand("right")==false) { //checks if command has been given already
      f.movementCommands.add("right");
    } else if (keyCode == LEFT && f.findMoveCommand("left")==false) {//checks if command has been given already
      f.movementCommands.add("left");
    }
    if (keyCode == 'c' || keyCode == 'C') {
      f.running=true;
    }
    if (keyCode == UP && f.findJumpCommand("jump")==false) {//checks if command has been given already
      f.jumpCommands.add("jump");
    }
    if (keyCode == 'a' || keyCode == 'A' && f.findAttackCommand("attack")==false) {//checks if command has been given already
      f.attackCommands.add("attack");
    }
    if (keyCode=='s'||keyCode=='S' && f.findSpecialCommand("special")==false) {//checks if command has been given already
      f.specialCommand.add("special");
    }
  }
}


void keyReleased() {
  if (screen==Screen.Explore) {
    if (keyCode==LEFT) {
      me.removeDirCommand("left");
    } else if (keyCode==RIGHT) {
      me.removeDirCommand("right");
    } else if (keyCode==UP) {
      me.removeDirCommand("up");
    } else if (keyCode==DOWN) {
      me.removeDirCommand("down");
    }
  }
  //----------------------------------------------------Fight Scene
  else if (screen==Screen.Fightscene) {
    if (keyCode==LEFT) {
      f.removeMoveCommand("left"); //removes given command
    } else if (keyCode==RIGHT) {
      f.removeMoveCommand("right");
    }
    if (keyCode == 'c' || keyCode == 'C') {
      f.running=false;
    }
    if (keyCode == UP ) {
      f.removeJumpCommand("jump");//removes given command
    }
    if (keyCode == 'a'||keyCode=='A') {
      f.removeAttackCommand("attack");//removes given command
    }
    if (keyCode=='s'||keyCode=='S') {
      f.removeSpecialCommand("special");//removes given command
    }
  }
}


void stop() {  //this is necessary when using ddf.minim.* library
  menuBGM.close();
  minim.stop();

  super.stop();
}

