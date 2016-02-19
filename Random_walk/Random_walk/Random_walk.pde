class Walker {
 int x;
 int y;  
 int h;
 int s;
 int v; 

  Walker() {
    x = width/2;
    y = height/2;
    h = int(random(100)) + 1;
    s = int(random(100)) + 1;
    v = 100;
    
  }

  void display() {
    stroke(h,s,v);
    point(x,y);
  }

  void step() {
    int choice = int(random(4));
    h = int(random(100)) + 1;
    s = int(random(100)) + 1;

    if (choice == 0){
      x++;
    } else if (choice == 1) {
      x--;
    } else if (choice == 2) {
      y++;
    } else if (choice == 3) {
      y--;
    }
  }
}

Walker w;

void setup() {
  colorMode(HSB,100);
  size(600,600);
  background(99);
  w = new Walker();
}

void draw() {
  w.step();
  w.display();
}
  
  
