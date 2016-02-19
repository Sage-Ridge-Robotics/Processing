/*
Sage Ridge Robotics
Example 1

Basic serial communication with the Arduino. Remember that
the Processing sketch examples here are Java-based, whereas
the Arduino code is C and C++ based. Note the subtle 
and not so subtle differences.

Adapted from Processing.org

*/

// Import the serial library.
import processing.serial.*;


// Instantiate objects of the Serial and esPen classes
// Data received from the serial port. esPen is defined at
// the end of this sketch. The serial port needs to be
// manually defined. The exmaple here is for OSX (Mac).
// Make sure that you enter in the correct COM port that the 
// Arduino is connected to for Windows.
Serial myPort;
color initColor = color(50,50,50); // The RGB pen color
String inBuffer = null;      
String portName = "/dev/tty.usbmodemfa141"; // Set to the correct COM or tty port
int lt = 10;

// Set the canvas size, color mode (hue, saturation, value),
// aliasing, drawing stroke, background color, 
// and open the serial port|file.
// The clear method of the serial class ensures that we receive
// a complete line of values from the Arduino the first time.
void setup() 
{
  size(500, 500);
  colorMode(HSB, height, height, height);  
  noStroke();
  background(0);
  
  myPort = new Serial(this, portName, 9600);
  myPort.clear();


}

// Processing uses draw() rather than loop(). As in the case
// of the Arduino, this is an infinite loop.  
// This example reads, stores, and prints the values sent by 
// the Arduino to the Processing . Values are stored in a special variable
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

