/*
Sage Ridge Robotics
Example 19

This Processing sketch is intended to pair with Arduino 
Exercise 19. It receives color and luminosity data over the 
serial link from an Arduino attached to an RGB color sensor.
This sketch displays the reported color and luminosity data
graphically.

Adapted from Processing.org
This code is in the public domain.

*/

// Import the serial library
import processing.serial.*;


// Declare an object of the Serial class. The serial port 
// needs to be manually defined; here it is an OSX port.
// For Windows, use the COM port the Arduino board is attached to.
Serial myPort;
String inBuffer = null;
String portName = "/dev/tty.usbmodemfa141"; 
int lf = 10;    // Linefeed in ASCII

// Set the canvas size, color mode (hue, saturation, value),
// aliasing, drawing stroke, background color, 
// and instantiate myPort. Clear any possible garbage
// in the serial stream.
void setup() 
{
  
  size(600, 600);
  noStroke();
  background(0);
  colorMode(RGB,100,100,100);
  
  myPort = new Serial(this, portName, 9600);
  myPort.clear();

}

// 
void draw() {
  while (myPort.available() > 0) {
    String junk = myPort.readStringUntil(lf);   
    String inBuffer = myPort.readStringUntil(lf);
    if (inBuffer != null) {
      background(0);
      int esLux[] = int(split(inBuffer,','));
      println(inBuffer + "\n");
      background(int(esLux[1]), int(esLux[2]), int(esLux[3]));      }
  } 
}