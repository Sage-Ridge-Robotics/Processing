/*
Sage Ridge Robotics
Example 4

 Modifed Follow 2  
 based on code from Keith Peters. 
  
 A two-segmented arm (linkage) follows the cursor position. 
 The relative angle between the segments is calculated with 
 atan2() and the position calculated with sin() and cos().
 

Adapted from Processing.org

*/

// Import the serial library. Unlinke Arduino, serial 
// communication functions are in a loadable library
// in Processing.
import processing.serial.*;


// Instantiate objects of the Serial and esPen classes
// Data received from the serial port. esPen is defined at
// the end of this sketch. The serial port needs to be
// manually defined. The exmaple here is for OSX (Mac).
Serial myPort;
String inBuffer = null;      
String portName = "/dev/tty.usbmodemfa141"; 
int lt = 10;

float[] x = new float[2];
float[] y = new float[2];
float segLength = 50;


// Set the canvas size, color mode (hue, saturation, value),
// aliasing, drawing stroke, background color, 
// and open the serial port|file.
// The clear method of the serial class ensures that we receive
// a complete line of values from the Arduino the first time.
void setup() 
{
  
  myPort = new Serial(this, portName, 9600);
  myPort.clear();
  
  size(640, 360);
  strokeWeight(20.0);
  stroke(255, 100);

}

// Processing uses draw() rather than loop(). Like Arduino,
// this is an infinite loop.  This example replaces mouseX and 
// mouseY from the Hue example with values from the Arduino
// transmitted over the serial link.

// If a third and fourth potentiometer where added, then
// the color fill could be completely controlled for
// hue, saturation, and brightness.
void draw() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readStringUntil(lt);
    if (inBuffer != null) {
      int[] esPenState = int(split(inBuffer,','));
      // println(esPenState[0] + " " + esPenState[1] + " " + esPenState[2] + "\n"); 
      background(0);
      dragSegment(0, esPenState[0], esPenState[1]);
      dragSegment(1, x[0], y[0]);

    } 
  }
}

// We have to create two functions here. One to drag the
// segment around and a second to crete a segment
void dragSegment(int i, float xin, float yin) {
  float dx = xin - x[i];
  float dy = yin - y[i];
  float angle = atan2(dy, dx);  
  x[i] = xin - cos(angle) * segLength;
  y[i] = yin - sin(angle) * segLength;
  segment(x[i], y[i], angle);
}

void segment(float x, float y, float a) {
  pushMatrix();
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
  popMatrix();
}

