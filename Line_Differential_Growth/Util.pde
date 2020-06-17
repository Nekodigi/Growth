PVector lineBlend(PVector A, PVector B, float fac){
  return PVector.mult(A, 1-fac).add(PVector.mult(B, fac));
}
