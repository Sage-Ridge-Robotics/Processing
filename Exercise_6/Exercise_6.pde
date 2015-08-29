/*

Sage Ridge Robotics
Example 6

Adapted from Objects
by hbarragan. 

*/

// Note: Code for the MRect class is at the end of this file

// Import the serial library. Unlinke Arduino, serial 
// communication functions are in a loadable library
// in Processing.
import processing.serial.*;

// Instantiate objects of the MRect and serial classes
// Data received from the serial port
MRect r1, r2, r3, r4;
Serial myPort;

String inBuffer = null;      
String portName = "/dev/tty.usbmodemfa141";
int lt = 10;



// We create a series of rectangles 
void setup()
{
  size(777, 480);
  fill(255, 204);
  noStroke();
  
  r1 = new MRect(1, 134.0, 0.532, 0.1*height, 10.0, 60.0);
  r2 = new MRect(2, 44.0, 0.166, 0.3*height, 5.0, 50.0);
  r3 = new MRect(2, 58.0, 0.332, 0.4*height, 10.0, 35.0);
  r4 = new MRect(1, 120.0, 0.0498, 0.9*height, 15.0, 60.0);
  
  myPort = new Serial(this, portName, 9600);
  myPort.clear();

}
 
void draw() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readStringUntil(lt);
    if (inBuffer != null) {
      int[] dataXYZ = int(split(inBuffer,','));
      
      background(0);

      r1.display();
      r2.display();
      r3.display();
      r4.display();
      
      r1.move(dataXYZ[0]-(width/2), dataXYZ[1]+(height*0.1), 30);
      r2.move((dataXYZ[0]+(width*0.05))%width, dataXYZ[1]+(height*0.025), 20);
      r3.move(dataXYZ[0]/4, dataXYZ[1]-(height*0.025), 40);
      r4.move(dataXYZ[0]-(width/2), (height-dataXYZ[1]), 50);

    } 
  }
}


// We create a class, rectangle that knows how to move and display
// itself on the canvas
class MRect 
{
  int w; // single bar width
  float xpos; // rect xposition
  float h; // rect height
  float ypos ; // rect yposition
  float d; // single bar distance
  float t; // number of bars
 
  MRect(int iw, float ixp, float ih, float iyp, float id, float it) {
    w = iw;
    xpos = ixp;
    h = ih;
    ypos = iyp;
    d = id;
    t = it;
  }
 
  void move (float posX, float posY, float damping) {
    float dif = ypos - posY;
    if (abs(dif) > 1) {
      ypos -= dif/damping;
    }
    dif = xpos - posX;
    if (abs(dif) > 1) {
      xpos -= dif/damping;
    }
  }
 
  void display() {
    for (int i=0; i<t; i++) {
      rect(xpos+(i*(d+w)), ypos, w, height*h);
    }
  }
}
