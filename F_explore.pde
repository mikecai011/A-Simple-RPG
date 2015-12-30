void explore() {
  background(0);
  mainMap.execute();
  me.execute();
  pushStyle();
  if (me.keyTaken>=3) {
    fill (232, 0, 0);
    textSize(50);
    text("TO BE CONTINUED", width*0.3, height*0.5);
  }
  popStyle();
}

