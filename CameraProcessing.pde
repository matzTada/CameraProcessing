/**
 * Getting Started with Capture.
 * 
 * Reading and displaying an image from an attached Capture device. 
 */

import processing.video.*;

Capture cam;

void setup() {
  size(800, 600);
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

void draw() {
  if (cam.available() == true) {
    cam.read();
  }

  //drawDigitalizedImageRectTint(cam, 20, 15, 0, 0, width, height);

   image(cam, 0, 0, width/2, height/2);
   drawDigitalizedImageEllipse(cam, 40, 60, width/2, 0, width/2, height/2);
   drawDigitalizedImageEllipseRandom(cam, 40, 30, 0, height/2, width/2, height/2);
   drawDigitalizedImageRect(cam, 40, 30, width/2, height/2, width/2, height/2);

  // The following does the same as the above image() line, but 
  // is faster when just drawing the image without any additional 
  // resizing, transformations, or tint.
  //set(0, 0, cam);
}

void drawDigitalizedImageRect(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
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

void drawDigitalizedImageRectTint(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
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

void drawDigitalizedImageEllipse(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
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

void drawDigitalizedImageEllipseRandom(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
  _img.loadPixels();
  for (int i = 0; i < 400; i++) {
    int imgX = int(random(_img.width));
    int imgY = int(random(_img.height));
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