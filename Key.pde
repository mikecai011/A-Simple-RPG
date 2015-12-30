class Key {
  PImage keyPic;
  PVector initialLocation;
  PVector location;  //this uses screen coordinates
  boolean taken;  //true when player has already picked up the keys, and false when player hasn't

  Key(float x_, float y_) {
    location= new PVector( x_+mainMap.mapPos.x, y_+mainMap.mapPos.y);
    initialLocation=new PVector( x_+mainMap.mapPos.x, y_+mainMap.mapPos.y);
    keyPic=loadImage("Data\\key/Key.png");
    keyPic.resize(keyPic.width/10, keyPic.height/10);
    taken=false;
  }
  //since keys are part of the map, they would be drawn in map section.

  boolean checkTaking() {
    if (taken==false&&location.x-keyPic.width/2<me.position.x&&me.position.x<location.x+keyPic.width/2&&location.y-keyPic.height/2<me.position.y&&me.position.y<location.y+keyPic.height/2) {
      return true;
    } else {
      return false;
    }
  }
}

