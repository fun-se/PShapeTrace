int MAX_NUM = 3;
float[] x = new float[MAX_NUM];

void setup() {
  size(200, 200);
  extraSettings(); // <PShapeTrace> 以下にプログラムを記述

  for (int i = 0; i < MAX_NUM; i++) {
    x[i] = width / 3 * i;
  }  
}

void drawMain() { // <PShapeTrace> 以下にプログラムを記述
  background(220);
  rect(10, 10, width - 20, height - 20);
  for (int i = 0; i < MAX_NUM; i++) {
    circle(x[i], 50, 50);
    square(x[i], 120, 50);
    x[i] += 1;
    x[i] = x[i] % width;
  }  
}
