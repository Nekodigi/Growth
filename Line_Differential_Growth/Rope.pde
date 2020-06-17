class Rope{
  ArrayList<Node> nodes = new ArrayList<Node>();
  
  void addNode(Node node){
    nodes.add(node);
  }
  
  void relax(){
    for(int i=1; i<nodes.size()-2; i++){
      Node node = nodes.get(i);
      for(Node target : nodes){
        if(target == node)continue;
        PVector diff = PVector.sub(node.pos, target.pos);
        float dist = diff.mag();
        if(dist < 2*r){
          float rdist = 2*r-dist;
          node.pos.add(diff.setMag(rdist));
        }
      }
    }
  }
  
  void limitLength(){
    for(int i=1; i<nodes.size()-2; i++){
      Node pnode = nodes.get(i-1);
      Node node = nodes.get(i);
      Node nnode = nodes.get(i+1);
      float dist = PVector.dist(pnode.pos, node.pos) + PVector.dist(node.pos, nnode.pos);
      if(dist > rlim*4){
        node.pos = PVector.add(pnode.pos, nnode.pos).div(2);
      }
    }
  }
  
  //void resample(){//it doesn't work
  //  float accLen = 0;//accumulated length
  //  float placedLen = 0;
  //  //calculate new node
  //  ArrayList<Node> Nnodes = new ArrayList<Node>();
  //  Node lastNode = nodes.get(nodes.size()-1);
  //  Nnodes.add(nodes.get(0));
  //  for(int i = 0; i < nodes.size()-1; i++){
  //    Node A = nodes.get(i);
  //    Node B = nodes.get(i+1);
  //    PVector diff = PVector.sub(B.pos, A.pos);
  //    float len = diff.mag();
  //    float paccLen = accLen;//previous accLen
  //    accLen += len;
  //    if(accLen - placedLen > resaLen){
  //      int nSec = floor((accLen - placedLen) / resaLen);//number of section
  //      for(int j = 1; j <= nSec; j++){
  //        PVector pos = lineBlend(A.pos, B.pos, (placedLen - paccLen + j*resaLen)/len);
  //        Node node = new Node(pos.x, pos.y);
  //        Nnodes.add(node);
  //      }
  //      placedLen += nSec*resaLen;
  //    }
  //  }
  //  Nnodes.remove(Nnodes.size()-1);
  //  Nnodes.add(lastNode);
  //  nodes = Nnodes;
  //}
  
  void resampleFB(){//resample forward and backward
    float accLen = 0;//accumulated length
    float placedLen = 0;
    //calculate new node
    ArrayList<Node> Nnodes = new ArrayList<Node>();
    Node lastNode = nodes.get(0);
    Nnodes.add(nodes.get(nodes.size()-1));
    for(int i = nodes.size()-1; i >= 1 ; i--){
      Node A = nodes.get(i);
      Node B = nodes.get(i-1);
      PVector diff = PVector.sub(B.pos, A.pos);
      float len = diff.mag();
      float paccLen = accLen;//previous accLen
      accLen += len;
      if(accLen - placedLen > resaLen && len > 1){
        int nSec = floor((accLen - placedLen) / resaLen);//number of section
        for(int j = 1; j <= nSec; j++){if(len < 2)println((placedLen - paccLen + j*resaLen)/len);
          PVector pos = lineBlend(A.pos, B.pos, (placedLen - paccLen + j*resaLen)/len);
          Node node = new Node(pos.x, pos.y);
          Nnodes.add(node);
        }
        placedLen += nSec*resaLen;
      }
    }
    Nnodes.remove(Nnodes.size()-1);
    Nnodes.add(lastNode);
    nodes = Nnodes;
  }
  
  void show(){
    for(Node node : nodes){
      //node.show();
    }
    noFill();
    beginShape();
    for(Node node : nodes){
      vertex(node.pos.x, node.pos.y);
    }
    endShape();
  }
}
