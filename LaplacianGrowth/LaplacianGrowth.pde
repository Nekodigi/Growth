Lightning lightning = new Lightning();
float h = 1;
float eta = 4;

int iter = 10;

void setup(){
  size(1000, 1000);
  lightning.eta = eta;
  lightning.h = h;
  lightning.start(new Vec(0, 0));
  colorMode(HSB, 360, 100, 100);
}
  
void draw(){
  if(mousePressed)lightning.start(new Vec(mouseX-width/2, mouseY-height/2));
  
  //change eta           \/(experimental)
  //eta = map(mouseX, 0, width, 0.1, 5);
  //lightning.eta = eta;
  //                     /\
  background(360);
  for(int i=0; i<iter; i++){
    lightning.grow();
  }
  translate(width/2, height/2);
  noStroke();
  //println(lightning.phis.size(), lightning.potentials.size(), lightning.charges.size(), lightning.candidateSites.size());
  fill(360);
  float size = 1;//grid visualization size
  for(int i=0; i<lightning.charges.size(); i++){
    Vec charge = lightning.charges.get(i);
    rect(charge.x*size, charge.y*size, size, size);
  }
  for(int i=0; i<lightning.candidateSites.size(); i++){
    Vec charge = lightning.candidateSites.get(i);
    //fill(lightning.potentials.get(i), lightning.phis.get(i), 0);
    fill(i < lightning.phis.size() ? lightning.phis.get(i)*360 : 0, 100, 100);//cramp index 
    rect(charge.x*size, charge.y*size, size, size);
  }
}
