import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Rectangle[] faces;
Capture video;
OpenCV opencv;
PGraphics pg;

void setup() {
  size(640, 480);
  video = new Capture(this, width/2, height/2);
  opencv = new OpenCV(this, width/2, height/2);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);

  video.start();
  pg = createGraphics(width, height);
}

void draw() {
  scale(2);
  opencv.loadImage(video);
  image(video, 0, 0 );
  detectFaces();
  scale(0.5);
  paint();
  image(pg, 0, 0);
}

void paint() {
  pg.colorMode(HSB);
  pg.beginDraw();
  pg.noStroke();

  for (int j = 0; j < faces.length; j++) {
    pg.translate((faces[j].x + faces[j].width/2)*2, (faces[j].y + faces[j].height/2)*2);
    float faceSize = faces[j].width/2.0;
    for (int i = 0; i < 10; i++) {
      pg.fill(random(0, 255), 255, 255,150);
      PVector pos = new PVector(random(-faceSize, faceSize), random(-faceSize, faceSize));
      float circleSize = faceSize - pos.dist(new PVector());
      pg.ellipse(pos.x, pos.y, circleSize, circleSize);
    }
  }

  pg.endDraw();
  pg.filter(ERODE);

  image(pg, 0, 0);
}

void detectFaces() {
  noFill();
  stroke(0, 255, 0);
  strokeWeight(1);
  faces = opencv.detect();

  for (int i = 0; i < faces.length; i++) {
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}


void captureEvent(Capture c) {
  c.read();
}
