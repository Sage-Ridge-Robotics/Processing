/**
 * Track the color red in the computer's camera
 * This sketch has been modified from O'ullivan and Igoe'
 * version to work with the Processing (2) libraries.
 * Parts of the code are derived from Processing.org's example
 * usage.
 *
 */

// Import the video library
import processing.video.*; 

// Declare objects and variables
Capture myCamera;
float worldRecord = 1000.00;
float colorDiff;
int xFound = width/2;
int yFound = height/2;
boolean goodTrack = false;
color targetColor = color(255,0,0); // RGB red

// Standard setup section
void setup() {
  
     // Here we set the size of the display frame.
     size(600,400);
     
     // We want to determine if any cameras are connected to the
     // system and to print the list of cameras if true.
     String[] cameras = Capture.list();
     if (cameras.length == 0) {
          println("There are no cameras available for capture.");
          exit();
     } 
     else {
          println("Available cameras:");
          for (int i = 0; i < cameras.length; i++) {
               println(cameras[i]);
          }
     }
     
     // All we really need is the following. cameras[0] is the
     // first camera found. We initialize the camera with .start.
     myCamera = new Capture(this, cameras[0]);
     myCamera.start();
}

//  Standard main loop
void draw()
{
     // Render to current frame on screen and draw
     // a small dot (ellipse) on a good match 
     image(myCamera, 0, 0);
     if (goodTrack){
          fill(targetColor);
          ellipse(xFound, yFound, 10, 10);
     }
}

// Define Capture.captureEvent to be called for each
// available new frame
void captureEvent(Capture myCamera)
{
     // Read and update linear pixel array from 
     // the myCamera object we instantiated in setup() if 
     // it is available
     if (myCamera.available() == true) {
          myCamera.read();
     }

     // We have not yet identified pixels that match
     // the target color
    goodTrack = false;

     // Scan image array for matching pixels
     for(int row=0; row < height; row++){
          for(int column=0; column < width; column++){
               color pixelColor = 
                 myCamera.pixels[row*width+column];
                 colorDiff = (
                 abs(red(targetColor) - red(pixelColor)) +
                 abs(green(targetColor) - green(pixelColor)) +
                 abs(blue(targetColor) - blue(pixelColor))
               )/3;

               if(colorDiff<=worldRecord){
                    worldRecord = colorDiff;
                    yFound = row;
                    xFound = column;
                    goodTrack = true;
               }
          }
     }
}

// Allow the user to change the value of the target 
// color by clicking on a pixel in the image with
// the mouse.
void mousePressed(){
     targetColor = 
      myCamera.pixels[mouseY*width+mouseY];
     fill(targetColor);
     ellipse(mouseX, mouseY, 10, 10);
}


