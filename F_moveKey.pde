void moveKey(String characterDirection) {
  for (int a=0; a<keys.size (); a++) {
    if (characterDirection.equals("left")) {
      keys.get(a).location.x+=me.speed;
    } else if (characterDirection.equals("right")) {
      keys.get(a).location.x-=me.speed;
    } else if (characterDirection.equals("up")) {
      keys.get(a).location.y+=me.speed;
    } else if (characterDirection.equals ("down")) {
      keys.get(a).location.y-=me.speed;
    }
  }
}

