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
  // drawDigitalizedImageEllipse(cam, 40, 60, width/2, 0, width/2, height/2);
  // drawDigitalizedImageEllipseRandom(cam, 40, 30, 0, height/2, width/2, height/2);
  // drawDigitalizedImageRect(cam, 40, 30, width/2, height/2, width/2, height/2);

  //drawDigitalizedImageMonotone_simple(cam, 32, 24, width/2, 0, width/2, height/2);
  getDigitalizedImageMonotone_simple(cam, 32, 24, width/2, height/2);
  //drawDigitalizedImageMonotone_ODMbayer(cam, 32, 24, width/2, 0, width/2, height/2);
  drawDigitalizedImageMonotone_ODMspiral(cam, 32, 24, 0, height/2, width/2, height/2);
  drawDigitalizedImageMonotone_ODMdot(cam, 32, 24, width/2, height/2, width/2, height/2);

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

void drawDigitalizedImageMonotone_simple(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
  int imgW = _img.width;
  int imgH = _img.height;
  int imgBlockW = _img.width/_numX;
  int imgBlockH = _img.height/_numY;

  for (int imgX = 0; imgX < imgW; imgX += imgBlockW) {
    for (int imgY = 0; imgY < imgH; imgY += imgBlockH) {
      //int imgLoc = imgX + imgY*imgW;
      //float imgR = red(_img.pixels[imgLoc]);
      //float imgG = green(_img.pixels[imgLoc]);
      //float imgB = blue(_img.pixels[imgLoc]);
      //float v = imgR * 0.298912 + imgG * 0.586611 + imgB * 0.114478;

      float sumV = 0.0;
      int cntV = 0;
      for (int imgBlockX = imgX; imgBlockX < imgX + imgBlockW; imgBlockX++) {
        for (int imgBlockY = imgY; imgBlockY < imgY + imgBlockH; imgBlockY++) {
          if (imgBlockX < 0 || imgW <= imgBlockX || imgBlockY < 0 || imgH <= imgBlockY) continue;
          int imgLoc = imgBlockX + imgBlockY * imgW;
          float imgR = red(_img.pixels[imgLoc]);
          float imgG = green(_img.pixels[imgLoc]);
          float imgB = blue(_img.pixels[imgLoc]);
          sumV += imgR * 0.298912 + imgG * 0.586611 + imgB * 0.114478;
          cntV++;
        }
      }
      float v = sumV / (float)cntV;

      float threshold = 128;
      noStroke();
      if (v < threshold) {
        fill(0);
      } else {
        fill(255);
      }
      float blockSizeX = _w / _numX;
      float blockSizeY = _h / _numY;

      float posX = map(imgX, 0, imgW, 0, _w);
      float posY = map(imgY, 0, imgH, 0, _h);

      rect(_x + posX, _y + posY, blockSizeX, blockSizeY);
    }
  }
}

boolean[][] getDigitalizedImageMonotone_simple(PImage _img, int _numX, int _numY, float _w, float _h) {
  int imgW = _img.width;
  int imgH = _img.height;
  int imgBlockW = _img.width/_numX;
  int imgBlockH = _img.height/_numY;

  boolean[][] rtArray = new boolean[(int)_w][(int)_h];

  for (int imgX = 0; imgX < imgW; imgX += imgBlockW) {
    for (int imgY = 0; imgY < imgH; imgY += imgBlockH) {
      //int imgLoc = imgX + imgY*imgW;
      //float imgR = red(_img.pixels[imgLoc]);
      //float imgG = green(_img.pixels[imgLoc]);
      //float imgB = blue(_img.pixels[imgLoc]);
      //float v = imgR * 0.298912 + imgG * 0.586611 + imgB * 0.114478;

      float sumV = 0.0;
      int cntV = 0;
      for (int imgBlockX = imgX; imgBlockX < imgX + imgBlockW; imgBlockX++) {
        for (int imgBlockY = imgY; imgBlockY < imgY + imgBlockH; imgBlockY++) {
          if (imgBlockX < 0 || imgW <= imgBlockX || imgBlockY < 0 || imgH <= imgBlockY) continue;
          int imgLoc = imgBlockX + imgBlockY * imgW;
          float imgR = red(_img.pixels[imgLoc]);
          float imgG = green(_img.pixels[imgLoc]);
          float imgB = blue(_img.pixels[imgLoc]);
          sumV += imgR * 0.298912 + imgG * 0.586611 + imgB * 0.114478;
          cntV++;
        }
      }
      float v = sumV / (float)cntV;

      float threshold = 128;

      int posX = (int)map(imgX, 0, imgW, 0, _w);
      int posY = (int)map(imgY, 0, imgH, 0, _h);

      boolean value;

      if (v < threshold) {
        value = false;
        //print("0 ");
      } else {
        value = true;
        //print("1 ");
      }
      rtArray[posX][posY] = value;

      //float blockSizeX = _w / _numX;
      //float blockSizeY = _h / _numY;
      //rect(_x + posX, _y + posY, blockSizeX, blockSizeY);
    }
    //println("");
  }

  return rtArray;
}

void drawDigitalizedImageMonotone_ODMbayer(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
  int [] matrix = // beyer diza
  {
    0, 8, 2, 10, 
      12, 4, 14, 6, 
      3, 11, 1, 9, 
      15, 7, 13, 5
  };
  drawDigitalizedImageMonotoneOrderedDitherMehtod(_img, _numX, _numY, _x, _y, _w, _h, matrix);
}
void drawDigitalizedImageMonotone_ODMspiral(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
  int [] matrix = // spiral
  {
    6, 7, 8, 9, 
      5, 0, 1, 10, 
      4, 3, 2, 11, 
      15, 14, 13, 12
  };
  drawDigitalizedImageMonotoneOrderedDitherMehtod(_img, _numX, _numY, _x, _y, _w, _h, matrix);
}
void drawDigitalizedImageMonotone_ODMdot(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h) {
  int [] matrix = // dot
  {
    11, 4, 6, 9, 
      12, 0, 2, 14, 
      7, 8, 10, 5, 
      3, 15, 13, 1
  };
  drawDigitalizedImageMonotoneOrderedDitherMehtod(_img, _numX, _numY, _x, _y, _w, _h, matrix);
}

void drawDigitalizedImageMonotoneOrderedDitherMehtod(PImage _img, int _numX, int _numY, float _x, float _y, float _w, float _h, int [] _matrix) {
  for (int imgX = 0; imgX < _img.width; imgX += _img.width/_numX) {
    for (int imgY = 0; imgY < _img.height; imgY += _img.height/_numY) {
      int imgLoc = imgX + imgY*_img.width;
      float imgR = red(_img.pixels[imgLoc]);
      float imgG = green(_img.pixels[imgLoc]);
      float imgB = blue(_img.pixels[imgLoc]);

      imgR /= 16;
      imgG /= 16;
      imgB /= 16;
      float threshold = _matrix[(imgX % 4) + (imgY % 4) * 4];
      float v = imgR * 0.298912 + imgG * 0.586611 + imgB * 0.114478;

      noStroke();
      if (v < threshold) {
        fill(0);
      } else {
        fill(255);
      }
      float blockSizeX = _w / _numX;
      float blockSizeY = _h / _numY;

      float posX = map(imgX, 0, _img.width, 0, _w);
      float posY = map(imgY, 0, _img.height, 0, _h);

      rect(_x + posX, _y + posY, blockSizeX, blockSizeY);
    }
  }
}