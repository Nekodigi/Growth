boolean contains(ArrayList<Vec> targets, Vec value){//compare internal value
  for(Vec target : targets){
    if(target.x == value.x && target.y == value.y)return true;
  }
  return false;
}

void resize(ArrayList<Float> target, int length){
  while(target.size() < length){
    target.add(0.);
  }
  int i = target.size()-1;
  while(target.size() > length){
    target.remove(i);
  }
}

class Vec{
  int x, y;
  Vec(int x, int y){
    this.x = x;
    this.y = y;
  }
}
