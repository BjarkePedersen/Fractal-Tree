ArrayList<Branch> tree;
Branch root;
int iterations = 10;
float t, t2, colorT;

float angle = 45;
float startangle;
float startererangle = angle;

float wind = 1;
float startwind = wind;
float tempWind;

float r, g, b;
boolean mouseBegin = true;
PVector startMouse;
float tempAngle;

float friction = 0.95;
float tension = 0.1;


void setup () {
  fill(0);
  size(800, 800);
  tree = new ArrayList<Branch>();

  seed();
  plant();
}

void seed() {
  PVector dir = new PVector(0, -200);
  dir.rotate(rad(wind));

  PVector a = new PVector(width/2, height-100) ;
  PVector b = new PVector(width/2+dir.x, height+dir.y-100);
  root = new Branch(a, b);
  tree.add(root);
}
 

void plant() {
  tree.clear();
  seed();
  for (int q = 0; q < iterations; q++) {
    for (int i = tree.size()-1; i>=0; i--) {
      if (!tree.get(i).finished) {
        Branch newBranchA = tree.get(i).branchR();
        Branch newBranchB = tree.get(i).branchL();
        tree.add(newBranchA);
        tree.add(newBranchB);
        tree.get(i).finished = true;
      }
    }
  }
}

void physics() {
  wind = startwind*(cos(t))*-1;
  startwind *= friction;
  noiseSeed(1337);
  startwind += map(noise(t/51-100), 0, 1, -0.2, 0.2);
  t -= tension;

  angle = startererangle + startangle*(cos(t2));
  startangle *= friction;
  noiseSeed(42);
  startangle += map(noise(t2/50), 0, 1, -0.2, 0.2);
  t2 -= tension;
}

void draw() {
  background(25);

  if (!mousePressed) {
    physics();
    mouseBegin = true;
  } else {
    if (mouseBegin == true) {
      startMouse = new PVector(mouseX, mouseY);
      tempWind = wind;
      tempAngle = angle;
      mouseBegin = false;
    }
    wind = tempWind + map(mouseX-startMouse.x, -width, width, deg(-1), deg(1));
    startwind = abs(wind);
    t = abs((wind/abs(wind)+1)*PI/2);

    angle = abs(tempAngle + map(mouseY-startMouse.y, -height, height, deg(-1), deg(1)))+0.01;
    startangle = startererangle-angle;
    t2 = abs(((angle/abs(angle)+1))*PI/2);
  }

  plant();

  noiseSeed(1);
  float r = map(noise(colorT/50), 0, 1, 0, 255);
  noiseSeed(2);
  float g = map(noise(colorT/75), 0, 1, 0, 255);
  noiseSeed(3);
  float b = map(noise(colorT/100), 0, 1, 0, 255);
  colorT++;

  stroke(r, g, b);
  fill(r, g, b);
  rect(width/2-20, height-100, 40, 20, 3, 3, 40, 40);

  int index = 0;
  int level = 1;

  for (Branch i : tree) {
    if ((index % (pow(2, level)-1)) == 0) {
      noiseSeed(1);
      r = map(noise(colorT/50+level*0.2), 0, 1, 0, 255);
      noiseSeed(2);
      g = map(noise(colorT/75+level*0.2), 0, 1, 0, 255);
      noiseSeed(3);
      b = map(noise(colorT/100+level*0.2), 0, 1, 0, 255);

      stroke(r, g, b);
      level++;
    }
    i.show();
    index++;
  }
}