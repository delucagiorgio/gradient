
PGraphics canvas;
int resolution = 10000;
int radiusRes = 10000;
float b = 0.0;
float s = 0.0;
PImage nx;

float stepX;
float stepY;

void setup(){
  size(1080,1080, P2D);
  canvas = createGraphics(1080,1080, P2D);
  nx = loadImage("noise1.jpg");
  colorMode(HSB, 360, 100, 100);
  canvas.colorMode(HSB, 360, 100, 100);
  canvas.smooth(8);
  canvas.beginDraw();
  canvas.background(255);
  canvas.endDraw();
  stepX = canvas.width * 0.5 / radiusRes;
  stepY = canvas.height * 0.5 / radiusRes;
  canvas.strokeWeight(1);
}

void draw(){
  
  canvas.beginDraw();
  canvas.background(255);
  
  float h = 0;
  
  float cx = canvas.width * 0.5;
  float cy = canvas.height * 0.5;
  float angle = 2 * PI / resolution;
  float offsetAngle = -PI*0.75;
  float lightDir = random(PI * 0.5, PI * 0.25) - offsetAngle;
  
  for(int k = 0; k < radiusRes; k++){
    for(int i = 0; i < resolution; i++){
      s = map(abs(angle * i - lightDir), 0, 2 * PI - lightDir, 5, 60);
      b = map(abs(angle * i - lightDir), 0, 2 * PI - lightDir, 90, 60);
      h = map(i, 0, resolution, 207, 360);  
      canvas.stroke(color(h,s,b));
      canvas.line(cx + 2 * stepX * k * cos(angle * i + offsetAngle),
                  cy + 2 * stepY * k * sin(angle * i + offsetAngle), 
                  cx + 2 * (k + 1) * stepX * cos(angle * i + offsetAngle),
                  cy + 2 * (k + 1) * stepY * sin(angle * i + offsetAngle));
      }
  }
  canvas.endDraw();

  image(canvas, 0,0, width, height);
  blend(nx,0,0,nx.width,nx.height,0,0, width, height, LIGHTEST);
  saveFrame("frames/1###.png");  

  noLoop();
}
