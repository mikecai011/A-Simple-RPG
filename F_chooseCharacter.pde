void chooseCharacter() {
  pushStyle();
  background(0);
  imageMode(CENTER);  
  adjustment=width*1.0/background.width;
  image(background, width/2, height/2, background.width*adjustment, background.height*adjustment);
  //image height should be 35% of the screen height
  adjustment=height*0.35/kingLeo.height;
  if (width*0.1-kingLeo.width*adjustment/2<mouseX&&mouseX<width*0.1+kingLeo.width*adjustment/2&&height*0.7-kingLeo.height*adjustment/2<mouseY&&mouseY<height*0.7+kingLeo.height*adjustment/2) { 
    image(kingLeo, width*0.1+5, height*0.7, kingLeo.width*adjustment, kingLeo.height*adjustment);
    if (mousePressed&&mouseButton == LEFT) {
      f = new FightCharacter(width/2, height/2, enemyNum, "King Leo");
      fightSetUp=true;
      screen=Screen.Fightscene;
    }
  } else {
    image(kingLeo, width*0.1, height*0.7, kingLeo.width*adjustment, kingLeo.height*adjustment);
  }
  adjustment=height*0.35/knight.height;
  if (width*0.33-knight.width*adjustment/2<mouseX&&mouseX<width*0.33+knight.width*adjustment/2&&height*0.7-knight.height*adjustment/2<mouseY&&mouseY<height*0.7+knight.height*adjustment/2) {
    image(knight, width*0.33+5, height*0.7, knight.width*adjustment, knight.height*adjustment);
    if (mousePressed&&mouseButton == LEFT) {
      f = new FightCharacter(width/2, height/2, enemyNum, "Knight");
      fightSetUp=true;
      screen=Screen.Fightscene;
    }
  } else {
    image(knight, width*0.33, height*0.7, knight.width*adjustment, knight.height*adjustment);
  }
  adjustment=height*0.35/robot.height;
  if (width*0.55-knight.width*adjustment/2<mouseX&&mouseX<width*0.55+knight.width*adjustment/2&&height*0.7-knight.height*adjustment/2<mouseY&&mouseY<height*0.7+knight.height*adjustment/2) {
    image(robot, width*0.55+5, height*0.7, robot.width*adjustment, robot.height*adjustment);
    if (mousePressed&&mouseButton == LEFT) {
      f = new FightCharacter(width/2, height/2, enemyNum, "Robot");
      fightSetUp=true;
      screen=Screen.Fightscene;
    }
  } else {
    image(robot, width*0.55, height*0.7, robot.width*adjustment, robot.height*adjustment);
  }
  popStyle();
}

