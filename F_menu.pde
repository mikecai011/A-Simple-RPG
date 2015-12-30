void menu() {
  if (!menuBGM.isPlaying()) {
    menuBGM.play();
  }
  pushStyle();
  imageMode(CENTER);
  image(menuBackground, width/2, height/2, width, height);
  if (width*0.20-startButton.width/2<mouseX&&mouseX<width*0.20+startButton.width/2&&height*0.13-startButton.height/2<mouseY&&mouseY<height*0.13+startButton.height/2) {
    image(startButton, width*0.20+4, height*0.13);
    if (mousePressed&&mouseButton == LEFT) {
      screen=Screen.Explore;
    }
  } else {
    image(startButton, width*0.20, height*0.13);
  }
  popStyle();
}

