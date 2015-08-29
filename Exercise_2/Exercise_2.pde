/*
Sage Ridge Robotics
Example 2

Controlling the Basic/Color/Hue example with the Arduino

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
int barWidth = 20;
int lastBar = -1;

// Set the canvas size, color mode (hue, saturation, value),
// aliasing, drawing stroke, background color, 
// and open the serial port|file.
// The clear method of the serial class ensures that we receive
// a complete line of values from the Arduino the first time.
void setup() 
{
  size(640, 360);
  colorMode(HSB, height, height, height);  
  noStroke();
  background(0);
  
  myPort = new Serial(this, portName, 9600);
  myPort.clear();

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
      int whichBar = esPenState[0] / barWidth;
      if (whichBar != lastBar) {
        int barX = whichBar * barWidth;
        fill(esPenState[1], height, height);
        rect(barX, 0, barWidth, height);
        lastBar = whichBar;
      }
    } 
  }
}


