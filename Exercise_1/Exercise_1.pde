/*
Sage Ridge Robotics
Example 1

Basic serial communication with the Arduino

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
color initColor = color(50,50,50); // The RGB pen color
String inBuffer = null;      
String portName = "/dev/tty.usbmodemfa141"; 
int lt = 10;

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

// Processing using draw() rather than loop(). Like Arduino,
// this is an infinite loop.  This example reads, stores, 
// and prints the values of the potentiometers sent by 
// the Arduino. Values are stored in a special variable
// container called an array.
void draw() {
  while (myPort.available() > 0) {
    String inBuffer = myPort.readStringUntil(lt);
    if (inBuffer != null) {
      int[] esPenState = int(split(inBuffer,','));
      println(esPenState[0] + " " + esPenState[1] + " " + esPenState[2] + "\n"); 
      
    } 
  }
}


