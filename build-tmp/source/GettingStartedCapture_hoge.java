import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GettingStartedCapture_hoge extends PApplet {

/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */



Capture cam;

public void setup() {
  
  surface.setResizable(true);

  String[] cameras = Capture.list();

  if (cameras == null) {
    println("Failed to retrieve the list of available cameras, will try the default...");
    cam = new Capture(this, 640, 480);
  } 
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    printArray(cameras);

    // The camera can be initialized directly using an element
    // from the array returned by list():
    cam = new Capture(this, cameras[0]);
    // Or, the settings can be defined based on the text in the list
    //cam = new Capture(this, 640, 480, "Built-in iSight", 30);

    // Start capturing the images from the camera
    cam.start();
  }
}

public void draw() {
  if (cam.available() == true) {
    cam.read();
  }

  drawDigitalizedImageRectTint(cam, 20, 15, 0, 0, width, height);

  // image(cam, 0, 0, width/2, height/2);
  // drawDigitalizedImageEllipse(cam, 40, 60, width/2, 0, width/2, height/2);
  // drawDigitalizedImageEllipseRandom(cam, 40, 30, 0, height/2, width/2, height/2);
  // drawDigitalizedImageRect(cam, 40, 30, width/2, height/2, width/2, height/2);

  // The following does the same as the above image() line, but 
  // is faster when just drawing the image without any additional 
  // resizing, transformations, or tint.
  //set(0, 0, cam);
}

public void drawDigitalizedImageRect(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
  for (int imgX = 0; imgX < _img.width; imgX += _img.width/_numX) {
    for (int imgY = 0; imgY < _img.height; imgY += _img.height/_numY) {
      int imgLoc = imgX + imgY*_img.width;
      float imgR = red(_img.pixels[imgLoc]);
      float imgG = green(_img.pixels[imgLoc]);
      float imgB = blue(_img.pixels[imgLoc]);

      //stroke(imgR, imgG, imgB);
      //fill(0);
      fill(imgR, imgG, imgB, 100);

      float blockSizeX = _w / _numX;
      float blockSizeY = _h / _numY;

      float posX = map(imgX, 0, _img.width, 0, _w);
      float posY = map(imgY, 0, _img.height, 0, _h);

      rect(_x + posX, _y + posY, blockSizeX, blockSizeY);
    }
  }
}

public void drawDigitalizedImageRectTint(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
  for (int imgX = 0; imgX < _img.width; imgX += _img.width/_numX) {
    for (int imgY = 0; imgY < _img.height; imgY += _img.height/_numY) {
      int imgLoc = imgX + imgY*_img.width;
      float imgR = red(_img.pixels[imgLoc]);
      float imgG = green(_img.pixels[imgLoc]);
      float imgB = blue(_img.pixels[imgLoc]);

      tint(imgR, imgG, imgB);

      float blockSizeX = _w / _numX;
      float blockSizeY = _h / _numY;

      float posX = map(imgX, 0, _img.width, 0, _w);
      float posY = map(imgY, 0, _img.height, 0, _h);

      image(_img, _x + posX, _y + posY, blockSizeX, blockSizeY);
    }
  }
}

public void drawDigitalizedImageEllipse(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
  for (int imgX = 0; imgX < _img.width; imgX += _img.width/_numX) {
    for (int imgY = 0; imgY < _img.height; imgY += _img.height/_numY) {
      int imgLoc = imgX + imgY*_img.width;
      float imgR = red(_img.pixels[imgLoc]);
      float imgG = green(_img.pixels[imgLoc]);
      float imgB = blue(_img.pixels[imgLoc]);

      //stroke(imgR, imgG, imgB);
      //fill(0);
      fill(imgR, imgG, imgB, 100);

      float blockSizeX = _w / _numX;
      float blockSizeY = _h / _numY;

      float posX = map(imgX, 0, _img.width, 0, _w);
      float posY = map(imgY, 0, _img.height, 0, _h);

      ellipse(_x + posX, _y + posY, blockSizeX, blockSizeY);
    }
  }
}

public void drawDigitalizedImageEllipseRandom(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
  _img.loadPixels();
  for (int i = 0; i < 400; i++) {
    int imgX = PApplet.parseInt(random(_img.width));
    int imgY = PApplet.parseInt(random(_img.height));
    int imgLoc = imgX + imgY*_img.width;
    if (_img.pixels.length <= 0) continue;
    float imgR = red(_img.pixels[imgLoc]);
    float imgG = green(_img.pixels[imgLoc]);
    float imgB = blue(_img.pixels[imgLoc]);

    //stroke(imgR, imgG, imgB);
    //fill(0);
    noStroke();
    fill(imgR, imgG, imgB, 100);

    float blockSizeX = _w / _numX;
    float blockSizeY = _h / _numY;

    float posX = map(imgX, 0, _img.width, 0, _w);
    float posY = map(imgY, 0, _img.height, 0, _h);

    ellipse(_x + posX, _y + posY, blockSizeX, blockSizeY);
  }
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "GettingStartedCapture_hoge" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
