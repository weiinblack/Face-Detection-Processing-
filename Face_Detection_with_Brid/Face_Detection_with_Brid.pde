import gab.opencv.*;
import processing.video.*;
import java.awt.*;

Rectangle[] faces;
Capture video;
OpenCV opencv;

int imageNum = 13;
PImage[] birdArray = new PImage[imageNum];
int currentFrameID = 0;
int timestamp = 0;

void setup() {
  size(640, 480);
  loadPNG();
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
  tint(255, 255, 255);
  image(video, 0, 0 );
  noFill();
  stroke(0, 255, 0);
  strokeWeight(1);
  faces = opencv.detect();

  if (faces.length>0) {
    //rect(faces[0].x, faces[0].y, faces[0].width, faces[0].height);
    float size = faces[0].height*0.75;
    float rand = -0.25 + noise(frameCount/100.0);
    float px = faces[0].x + rand*width/3;
    float py = faces[0].y-size;
    float r = random(0,256);
    float g = random(0,256);
    float b = random(0,256);
    tint(r, g, b);
    image(birdArray[currentFrameID], px, py, size, size);
  }
  
  frameUpdate();

}

void frameUpdate(){
  if(millis() - timestamp > 50){
    currentFrameID++;
    timestamp = millis();
    if(currentFrameID >= imageNum){
      currentFrameID = 0;
    }
  }
}

void captureEvent(Capture c) {
  c.read();
}

void loadPNG(){
  for(int i = 0 ;i<imageNum ;i++){
    birdArray[i] = loadImage("bird"+String.format("%02d",i)+".png");
  }
}
