class Map {
  PImage currentMap;
  PImage collisionMap;
  PGraphics environment; //this would be an image containing current map and all keys
  PVector mapPos;
  Map(String name) {
    currentMap=loadImage("Data\\map/"+name+".png");
    collisionMap=loadImage("Data\\map/"+name+"_collision.png");
    mapPos=new PVector (width/2+1200, height/2+1600);
    environment = createGraphics(width, height);
  }

  void execute() {
    pushStyle();
    pushMatrix();
    display();
    popMatrix();
    popStyle();
  }

  void display() {
    environment.beginDraw();
    environment.background(0);
    environment.imageMode(CENTER);
    environment.image(currentMap, mapPos.x, mapPos.y ); 
    for (int a=0; a<keys.size (); a++) {
      if (keys.get(a).taken==false) {
        environment.image(keys.get(a).keyPic, keys.get(a).location.x, keys.get(a).location.y);
      }
    }
    environment.fill(232, 0, 0);
    environment.textSize(20);
    environment.text("Keys taken: "+me.keyTaken, width-200, 50);
    environment.endDraw();
    pushStyle();
    image(environment, 0, 0);  //here the imageMode is corner as the "environment.imageMode(CENTER)" only affects graphic named "environment"
    popStyle();
  }
}

