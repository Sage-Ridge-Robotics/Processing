
/*
Sage Ridge Robotics
Example 3

Controlling Processing drawing functions with potentiometers. This sketch takes
two comma-delimited numbers from the serial stream and uses them to control
a virtual linkage on the canvas.

The angle of each segment is controlled with the two
potenitometer values. The transformations applied to the first 
segment are also applied to the second segment because 
they are inside the same pushMatrix() and popMatrix() group.
Adapted from Processing.org

*/

// Import the serial library.
import processing.serial.*;

// Instantiate objects of the Serial and esPen classes
// Data received from the serial port. esPen is defined at
// the end of this sketch. The serial port needs to be
// manually defined. The exmaple here is for OSX (Mac).
Serial myPort;
String inBuffer = null; 
String portName = "/dev/tty.usbmodemfa141"; 
int lt = 10;
float x, y;
float angle1 = 0.0;
float angle2 = 0.0;
float segLength = 100;

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
  strokeWeight(30);
  stroke(255, 160);

  x = width * 0.3;
  y = height * 0.5;

}

// Processing uses draw() rather than loop(). Like Arduino,
// this is an infinite loop. This example replaces mouseX and 
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
      println(esPenState[0] + " " + esPenState[1] + " " + esPenState[2] + "\n"); 
      background(0);

      angle1 = (esPenState[0]/float(width) - 0.5) * -PI;
      angle2 = (esPenState[1]/float(height) - 0.5) * PI;

      pushMatrix();
        segment(x, y, angle1); 
        segment(segLength, 0, angle2);
      popMatrix();
    } 
  }
}

// We need to create our own function
void segment(float x, float y, float a) {
  translate(x, y);
  rotate(a);
  line(0, 0, segLength, 0);
}