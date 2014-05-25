class Star {
  Star(float x, float y, float vx, float vy, float r, float g, float b, float a) {
    this.x = x;
    this.y = y;
    this.ox = x;
    this.oy = y;
    this.vx = vx;
    this.vy = vy;
    this.r = r;
    this.g = g;
    this.b = b;
    this.a = a;
  }
  
  float x, y, ox, oy, vx, vy, r, g, b, a;
  
  void draw() {
    stroke(r, g, b, a);
    line(x, y, ox - 1, oy - 1);
  }
}
