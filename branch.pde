public class Branch {
  PVector begin;
  PVector end;
  float rand;
  boolean finished = false;
  float rotation = 0;
  
  
  public Branch(PVector begin, PVector end) {
    this.begin = begin;
    this.end = end;
  }
  
  public void show() {
    line(this.begin.x, this.begin.y, this.end.x, this.end.y);
  }
  
  public Branch branchR() { 
    PVector dir = new PVector(this.end.x-this.begin.x, this.end.y-this.begin.y);
    dir.rotate(rad(angle+wind+rand));
    dir.mult(0.6667);
    PVector newEnd = new PVector(this.end.x+dir.x, this.end.y+dir.y);
    Branch right = new Branch(this.end, newEnd);
    return right;
  }
  
  public Branch branchL() { 
    PVector dir = new PVector(this.end.x-this.begin.x, this.end.y-this.begin.y);
    dir.rotate(rad(-angle+wind));
    dir.mult(0.6667);
    PVector newEnd = new PVector(this.end.x+dir.x, this.end.y+dir.y);
    Branch left = new Branch(this.end, newEnd);
    return left;
  }
}