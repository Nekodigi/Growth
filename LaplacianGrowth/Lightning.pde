//based on this site http://gamma.cs.unc.edu/FRAC/laplacian_large.pdf
//based on this code https://github.com/ryukau/lightning_rust/blob/master/src/generator.rs

class Lightning{
  ArrayList<Vec> charges = new ArrayList<Vec>();
  ArrayList<Vec> candidateSites = new ArrayList<Vec>();
  ArrayList<Float> potentials = new ArrayList<Float>();
  ArrayList<Float> phis = new ArrayList<Float>();
  int iteration;
  float eta;
  float h = 1;//physical length of a grid cell
  float R1 = h/2;
  
  void addNeighbor(Vec pos){
    for(int i=-1; i<=1; i++){
      for(int j=-1; j<=1; j++){
          if(i==0 && j==0) continue;
          
          Vec newSite = new Vec(pos.x+i, pos.y+j);
          if(contains(charges, newSite) || contains(candidateSites, newSite))continue;
          float potential = calcNewPotential(newSite);
          potentials.add(potential);
          candidateSites.add(newSite);
      }
    }
  }
  
  float calcNewPotential(Vec site){//Eqn 10
    float value = 0;
    for(Vec charge : charges){
      int dx = charge.x - site.x;
      int dy = charge.y - site.y;
      float distance = sqrt(dx*dx + dy*dy);
      value += 1.0 - R1/distance;
    }
    return value;
  }
  
  void updatePotential(Vec charge){//Eqn 11?10?
    for(int i=0; i<candidateSites.size(); i++){
      Vec site = candidateSites.get(i);
      int dx = charge.x - site.x;
      int dy = charge.y - site.y;
      float distance = sqrt(dx*dx + dy*dy);
      potentials.set(i, potentials.get(i)+1.0 - R1/distance);
    }
  }
  
  void grow(){
    float phiMin = Float.POSITIVE_INFINITY;
    float phiMax = Float.NEGATIVE_INFINITY;
    int index = 0;
    for(int i=0; i<potentials.size(); i++){
      float x = potentials.get(i);
      phiMin = min(phiMin, x);
      phiMax = max(phiMax, x);
      if(potentials.get(index) < x)index = i;
    }
    resize(phis, potentials.size());
    for(int i=0; i<potentials.size(); i++){
      float x = potentials.get(i);
      phis.set(i, pow((x - phiMin)/(phiMax - phiMin), eta));
    }
    float rnd = random(1);
    for(int i=0; i<phis.size(); i++){
      float x = phis.get(i);
      if(x > rnd && x < phis.get(index))index = i;
    }
    potentials.remove(index);
    Vec charge = candidateSites.remove(index);
    addNeighbor(charge);
    updatePotential(charge);
    charges.add(charge);
  }
  
  void start(Vec pos){
    lightning.addNeighbor(pos);
    lightning.charges.add(pos);
  }
}
