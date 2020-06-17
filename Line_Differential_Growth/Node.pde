class Node{
  PVector pos;
  
  Node(float x, float y){
    pos = new PVector(x, y);
  }
  
  void show(){
    ellipse(pos.x, pos.y, r*2, r*2);
  }
}
