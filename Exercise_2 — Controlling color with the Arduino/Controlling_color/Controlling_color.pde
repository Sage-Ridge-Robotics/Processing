/*
Sage Ridge Robotics
Example 2

Controlling color with an Arduino.

This sketch draws a series of vertical colored bars
across the canvas. Hue is determined by the data
streaming from the Arduino over a serial link. 

Minimum hue is 0. Maximum hue is 1023. Adjust
accroding to your needs.

Adapted from Processing.org

*/

// Import the serial library.
import processing.serial.*;


// Instantiate objects of the Serial and esPen classes
// Data received from the serial port. esPen is defined at
// the end of this sketch. The serial port needs to be
// manually defined. The exmaple here is for OSX (Mac).
// Make sure that you indicate the correct COM port that
// the Arduino is connected to for Windows.
Serial myPort;
String inBuffer = null;      
String portName = "/dev/tty.usbmodemfa141"; // Set to the correct tty (OSX, Linux) or COM (Windows) port
int lt = 10;
int barWidth = 20;
int lastBar = -1;

// Set the canvas size, color mode (hue, saturation, value),
// aliasing, drawing stroke, background color, and open the serial port.
// The clear method of the serial class ensures that we receive
// a complete line of values from the Arduino the first time.
void setup() 
{
  size(1000, 500);                           
  colorMode(HSB, 1023);                      // Set the color mode to HSB with a maximum value of 1023. 
  noStroke();                                // The rectangle we draw will have no perimeter stroke.
  background(500, 500, 500);                 // Set the background to a neutral gray.
  
  myPort = new Serial(this, portName, 9600);
  myPort.clear();

}

// Processing using draw() rather than loop(). Like Arduino,
// this is an infinite loop. 

// While myPort is available we read lines of data streaming
// from the Arduino and store the received value an array. The
// numerical value sent from the Arduino is then used to control
// the characteristics of the rectangle drawn on the canvas.
void draw() {
  while ( myPort.available() > 0 ) {
    String inBuffer = myPort.readStringUntil(lt);
    if (inBuffer != null) {
      int[] esPenState = int(split(inBuffer,','));
      int whichBar = esPenState[0] / barWidth;
      if (whichBar != lastBar) {
        int barX = whichBar * barWidth;
        fill(esPenState[0], 1024, 1024);
        rect(barX, 0, barWidth, height);
        lastBar = whichBar;
      }
    } 
  }
}