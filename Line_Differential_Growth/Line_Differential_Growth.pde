float r = 11;//node radius
float rlim = 11;//limit length(avoid intersecting line)
float resaLen = 10*2;//resampleLength
Rope rope;

void setup(){
  //fullScreen();
  strokeWeight(10);
  strokeJoin(ROUND);
  size(1000, 1000);
  rope = new Rope();
  Node A = new Node(0, height/2);
  Node B = new Node(width/2, height/2-30);
  Node C = new Node(width/2, height/2+30);
  Node D = new Node(width, height/2);
  //fill(255, 0, 0); B.show();fill(255);
  rope.addNode(A);
  rope.addNode(B);
  rope.addNode(C);
  rope.addNode(D);
  //frameRate(2);
}

void draw(){
  background(255);
  rope.resampleFB();
  for(int i=0; i<2; i++){
    rope.relax();
    rope.limitLength();
  }
  rope.show();
}
