PImage bg_img;
PShape globe,cube;

void setup(){
  size(640,480,P3D);
  
  noStroke();
  bg_img = ColorXorTexture(width,height);
  colorMode(RGB, 1);
  
  globe = createShape(SPHERE, 50);
  globe.setTexture(bg_img);
  
  cube = createShape(BOX, 80);
  cube.setTexture(XorTexture(64,64));
}

PImage XorTexture(int w, int h)
{
  PImage img = createImage(w,h,RGB);
  
  img.loadPixels();
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      img.pixels[y*img.width+x] = x ^ y + x;
    }
  }
  img.updatePixels();
  
  return img;
}

PImage ColorXorTexture(int w, int h)
{
  PImage img = createImage(w,h,RGB);
  
  img.loadPixels();
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      int c = x ^ y;
      img.pixels[y*img.width+x] = ((255 - c) << 16) | (c << 8) | (c % 128) ;      
    }
  }
  img.updatePixels();
  
  return img;
}

float xmag, ymag = 0;
float newXmag, newYmag = 0;

void draw(){
  image(bg_img,0,0);
  
  lights();
  
  pushMatrix(); 
  translate(width/2, height/2, -30); 
  
  newXmag = mouseX/float(width) * TWO_PI;
  newYmag = mouseY/float(height) * TWO_PI;
  
  float diff = xmag-newXmag;
  if (abs(diff) >  0.01) {
    xmag -= diff/4.0;
  }
  
  diff = ymag-newYmag;
  if (abs(diff) >  0.01) { 
    ymag -= diff/4.0;
  }
  
  rotateX(-ymag);
  rotateY(-xmag);
  
  scale(90);
  beginShape(QUADS);
  texture(bg_img);

  fill(0, 1, 1); vertex(-1,  1,  1);
  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(1, 0, 1); vertex( 1, -1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);

  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1,  1);

  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(0, 0, 0); vertex(-1, -1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);

  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(0, 1, 1); vertex(-1,  1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);
  fill(0, 0, 0); vertex(-1, -1, -1);

  fill(0, 1, 0); vertex(-1,  1, -1);
  fill(1, 1, 0); vertex( 1,  1, -1);
  fill(1, 1, 1); vertex( 1,  1,  1);
  fill(0, 1, 1); vertex(-1,  1,  1);

  fill(0, 0, 0); vertex(-1, -1, -1);
  fill(1, 0, 0); vertex( 1, -1, -1);
  fill(1, 0, 1); vertex( 1, -1,  1);
  fill(0, 0, 1); vertex(-1, -1,  1);

  endShape();
  
  popMatrix(); 
 
  rotateX(-xmag);
  rotateY(-ymag);
  translate(200,200,0);
  shape(globe);
  translate(100,100,0);
  shape(cube);
}