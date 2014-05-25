Star[] stars;
final int parts = 20000;

float power = 1;
boolean running = true;
String mode = "bounce";

void setup() {
  size(1024, 760, P3D);
  stars = new Star[parts];
  for (int i = 0; i < parts; i++) {
    stars[i] = new Star(random(width),
                        random(height),
                        0,
                        0,
                        0,
                        255,
                        255,
                        25);
  }
  power = 1;
  mode = "bounce";
  // running = true;
}

void draw() {
  //background(0);
  fill(0, 0, 0, 127);
  rect(0, 0, width, height);
  strokeWeight(2);
  
  fill(255);
  text("Power: " + power, 10, 20);
  text("FPS: " + frameRate, 10, 40);
  text("Running: " + running, 10, 60);
  text("Mode: " + mode, 10, 80);
  text("Left click to suck stars in, right click to push", 10, 100);
  text("[Space] to pause, [i] to invert power, [r] to reset, [m] to change modes, and scroll wheel to change power", 10, 120);
  
  if (mousePressed) {
    for (int i = 0; i < parts; i++) {
      float d = sqrt(sq(stars[i].x - mouseX) + sq(stars[i].y - mouseY));
      if (mouseButton == LEFT) {
        stars[i].vx -= power/d*(stars[i].x - mouseX);
        stars[i].vy -= power/d*(stars[i].y - mouseY);
      } else if (mouseButton == RIGHT) {
        stars[i].vx += power/d*(stars[i].x - mouseX);
        stars[i].vy += power/d*(stars[i].y - mouseY);
      }
    }
  }
  
  for (int i = 0; i < parts; i++) {
    if (running) {
      stars[i].ox = stars[i].x;
      stars[i].oy = stars[i].y;
      
      stars[i].x += stars[i].vx;
      stars[i].y += stars[i].vy;
      
      if (mode.equals("bounce")) {
        
        if (stars[i].x <= 0 || stars[i].x >= width) {
          stars[i].vx *= -1;
        }
      
        if (stars[i].y <= 0 || stars[i].y >= height) {
          stars[i].vy *= -1;
        }
        
      } else if (mode.equals("loop")) {
      
        if (stars[i].x < 0) {
          stars[i].x = width;
          stars[i].ox = stars[i].x;
        }
        
        if (stars[i].x > width) {
          stars[i].x = 0;
          stars[i].ox = stars[i].x;
        }
        
        if (stars[i].y < 0) {
          stars[i].y = height;
          stars[i].oy = stars[i].y;
        }
        
        if (stars[i].y > height) {
          stars[i].y = 0;
          stars[i].oy = stars[i].y;
        }
        
      } else if (mode.equals("center")) {
      
        if (stars[i].x < 0 || stars[i].x > width || stars[i].y < 0 || stars[i].y > height) {
          stars[i].x = width/2;
          stars[i].y = height/2;
          stars[i].ox = width/2;
          stars[i].oy = height/2;
        }
      
      }
      
      stars[i].vx *= 0.98;
      stars[i].vy *= 0.98;
    }
    
    stars[i].draw();
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  power -= e/8;
}

void keyTyped() {
  switch (key) {
    case ' ':
      running = !running;
      break;
    case 'r':
      setup();
      break;
    case 'i':
      power *= -1;
      break;
    case 'm':
      if (mode.equals("bounce"))
        mode = "loop";
      else if (mode.equals("loop"))
        mode = "center";
      else if (mode.equals("center"))
        mode = "bounce";
  }
}

