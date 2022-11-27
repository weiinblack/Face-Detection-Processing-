import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Rectangle[] faces;
Capture video;
OpenCV opencv;

void setup() {
  size(640, 480);
  String[] cameras = Capture.list();
  for (int i = 0; i < cameras.length; i++) {
     println(cameras[i]);
  }
  
  video = new Capture(this, width, height, cameras[0]);
  //new Capture(this, width, height, "pipeline:autovideosrc",30);
  //new Capture(this, width, height, "pipeline:avfvideosrc device-index=0 ! video/x-raw, width=640, height=480, framerate=30/1");
  
  opencv = new OpenCV(this, width, height);
  opencv.loadCascade(OpenCV.CASCADE_FRONTALFACE);
  video.start();
}

void draw() {
  opencv.loadImage(video);
  image(video, 0, 0 );
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
