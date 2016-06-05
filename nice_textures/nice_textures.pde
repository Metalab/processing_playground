PImage bg_img;

void setup(){
  size(1280,800);
  bg_img=SomeTexture(width,height);
}

PImage SomeTexture(int w, int h)
{
  PImage img = createImage(w,h,RGB);
  
  img.loadPixels();
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      
      //float f = sin(x ^ y) + 1;
      //img.pixels[y*img.width+x] = floor((1<<24) *f);
      
      //float f = sin(x ^ y + x + y)+1;
      //img.pixels[y*img.width+x] = ((x+y)^(x-y) & (x^y))^((x^y)<<8);
      
      float f = abs(sin(x ^ y));
      img.pixels[y*img.width+x] = ((x^y^floor((1<<16) *f))<<16)|(((x+y)^(x-y) & (x^y))^((x^y)<<8))<<8;
    }
  }
  img.updatePixels();
  
  return img;
}


void draw(){
  image(bg_img,0,0);
  //saveFrame("/tmp/line-###.png");
  noLoop();
}