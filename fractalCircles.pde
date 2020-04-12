int WIDTH= 800;
int HEIGHT= 800;
int depth= 4;

Cirq dots= new Cirq(600, 3, WIDTH/2, HEIGHT/2);

void setup() 
{
  size(800, 800);
}

void draw() {
  background(255);
  dots.recurCirq(depth, dots.origin[0], dots.origin[1], dots.radius, dots.count);
  dots.inc();
  //frameRate(10);
}

void keyPressed(){
    if (key == CODED){
      if (keyCode == UP){
        dots.count += 1;
      }
      if (keyCode == DOWN){
        if (dots.count > 2){
          dots.count -= 1;
        }
      }
      if (keyCode == RIGHT){
        depth += 1;
      }
      if (keyCode == LEFT){
        if (depth > 0){
          depth -= 1;
        }
      }
    }
}
class Cirq{
  float radius; int count; float origin[]= new float[2]; float[] pointList[]= new float[count][3];
  float t= PI;
  float i= PI;
  float p= 1;
  Cirq(float r, int c, float x, float y){
    this.radius= r;
    this.count= c;
    this.origin[0] = x; this.origin[1] = y;
    this.pointList= new float[count][3];
    for (int i= 1; i <= count; i++){
      int red= (255/count)*i;
      float Ppoint[]= new float[]{(float)(sin(((2*PI)/count)*i)*r)+origin[0], (float)(cos(((2*PI)/count)*i)*r)+origin[1], red};
      this.pointList[i-1]= Ppoint;
    }
  }
  
  void drawDots(){
    circle(this.origin[0], this.origin[1], this.radius+this.radius);
    for (float[] pointt : this.pointList){
      noFill();
      stroke((int)pointt[2], 200, 20);
      //circle((float)(pointt[0]), (float)(pointt[1]), (float)(sin(t)*this.radius+sin(i)*(this.radius/3)));
      circle((pointt[0]), (pointt[1]), this.radius);
      i += PI/(map(noise(p), 0.0, 1.0, 600.0, 2000.0));
      p += 0.005;
    }
  }
  
  void inc(){
    t += PI/64;
  }
  
  float vary3(float v1, float v2, float r){
    if (v1 < 140 && v2 < 50){
      return abs(3*(sin(t-PI)*r+sin(t-PI)*(r/3)+50));
    } else if (v1 < 200 && v2 < 80) {
      return abs(2*(sin(t-PI)*r+sin(t-PI)*(r/3)+50));
    } else if (v1 < 200 && v2 < 100) {
    return abs(sin(t-PI)*r+sin(t-PI)*(r/3)+50);
    } else return 0;
    }
    
  void recurCirq(int d, float x, float y, float r, float c){
    if (d == 0){
      float vary= sin(t)*r+sin(t)*(r/3)+50;
      float red= abs(map(vary, 50, r+r/3+50, 100, 240));
      float vary2= cos(t)*r+cos(t)*(r/3)+50;
      float green= abs(map(vary2, 50, r+r/3+50, 40, 120));
      float blue= vary3(red, green, r);
      noFill();
      //stroke(map(vary, 50, r+r/3+50, 100, 240), map((1/vary), 1/(r+r/3+50), 1/50, 40, 100), 0);
      stroke(red, green, blue);
      println("red is: " + red + ", green is: " + 
      green + ", blue is: " + blue);
      circle(x, y, vary);
    } else {
      noFill();
      //circle(x, y, r);
      for (int i= 1; i <= c; i++){
        recurCirq(d-1,
        (float)(sin(((2*PI)/c)*i)*(r/2.71828)+x), 
        (float)(cos(((2*PI)/c)*i)*(r/2.71828)+y), r/2.71828, c);
      }
  }
  }
  
  }
  
