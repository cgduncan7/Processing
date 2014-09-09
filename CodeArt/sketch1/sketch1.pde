class Particle
{
  float x, y, z;
  int r;
  
  Particle(float x, float y, float z, int r)
  {
    this.x = x;
    this.y = y;
    this.z = z;
    this.r = r;
  }
  
  void move(float x, float y, float z)
  {
    this.x += x;
    this.y += y;
    this.z += z;
  }
  
  void drawMe()
  {
    noStroke();
    pushMatrix();
    translate(x,y,z);
    sphere(r);
    popMatrix();
  }
}

class ParticleSystem
{
  Particle[] particles;
  int numParticles;
  
  ParticleSystem(int numParticles, int particleRadius)
  {
    this.numParticles = numParticles;
    particles = new Particle[this.numParticles];
    for (int i = 0; i < numParticles; i++)
    {
      particles[i] = new Particle(width/2,height/2,0,particleRadius);
    }
  }
  
  void updateSystem()
  {
    for (int i = 0; i < numParticles; i++)
    {
      particles[i].move(random(-1,1),random(-1,1),random(-10,10));
    }
  }
  
  void drawSystem()
  {    for (int i = 0; i < numParticles; i++)
    {
      particles[i].drawMe();
    }
  }
}

ParticleSystem sys;

void setup()
{
  size(500,500, P3D);
  sys = new ParticleSystem(50,5);
}

void draw()
{
  background(0);
  lights();
  sys.updateSystem();
  sys.drawSystem();
}
