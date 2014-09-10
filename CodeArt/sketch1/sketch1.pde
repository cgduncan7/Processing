class Particle
{
  float x, y, z, t, hue;
  int r, age;
  
  Particle(float x, float y, float z, float t, int r, float hue)
  {
    this.x = x;
    this.y = y;
    this.z = z;
    this.t = t;
    this.r = r;
    this.hue = hue;
    age = 0;
  }
  
  float getAngle()
  {
    return t;
  }
  
  int getAge()
  {
    return age;
  }
  
  void move(float x, float y, float z, float t)
  {
    age++;
    this.x = x;
    this.y = y;
    this.z = z;
    this.t = t;
  }
  
  void drawMe()
  {
    noStroke();
    fill(color(hue,hue,hue));
    pushMatrix();
    translate(x,y,z+age);
    sphere(r);
    popMatrix();
  }
}

class ParticleSystem
{
  boolean done = false;
  Particle[] particles;
  int numParticles, sysRadius, sysGrowth;
  float rotationSpeed, hue;
  
  ParticleSystem(int numParticles, int particleRadius, int sysRadius, int sysGrowth, float rotationSpeed, float hue)
  {
    this.numParticles = numParticles;
    this.sysRadius = sysRadius;
    this.sysGrowth = sysGrowth;
    this.rotationSpeed = rotationSpeed;
    this.hue = hue;
    particles = new Particle[this.numParticles];
    
    for (int i = 0; i < numParticles; i++)
    {
      createParticle(i);
    }
  }
  
  void killParticle(int index)
  {
    particles[index] = null;
  }
  
  void createParticle(int index)
  {
    float t = radians((index/(float)numParticles)*360.0f);
    float x = sysRadius*cos(t);
    float y = sysRadius*sin(t);
    particles[index] = new Particle((width/2) + x, (height/2) + y, 0, t, 5, hue);
  }
  
  void updateSystem()
  {
    for (int i = numParticles-1; i >= 0; i--)
    {
      int age = particles[i].getAge();
      if (age < sysGrowth)
      {
        float t = (particles[i].getAngle() + rotationSpeed);
        particles[i].move((width/2)+((sysGrowth-age)*cos(t)), (height/2)+((sysGrowth-age)*sin(t)), 0, t);
      }
      else if (age < sysGrowth*2)
      {
        float t = particles[i].getAngle();
        particles[i].move((width/2)+((sysGrowth-age)*cos(t)), (height/2)+((sysGrowth-age)*sin(t)), particles[i].getAge() - sysGrowth, t);
      }
      else
      {
        done = true;
      }
    }
  }
  
  void drawSystem()
  {    for (int i = 0; i < numParticles; i++)
    {
      particles[i].drawMe();
    }
  }
}

ArrayList<ParticleSystem> systems = new ArrayList<ParticleSystem>();
int index;
ParticleSystem sys;

int NUM_PARTICLES = 32;
int RAD_PARTICLE = 5;
int RAD_SYSTEM = 200;
int SYS_GROWTH = 100;
float SPEED = 0.01;

void setup()
{
  sphereDetail(25);
  size(500,500, P3D);
  index = SYS_GROWTH;
  while (SYS_GROWTH > 60)
  {
    SPEED *= -2;
    sys = new ParticleSystem(NUM_PARTICLES, RAD_PARTICLE, RAD_SYSTEM-=5, SYS_GROWTH-=2, SPEED, (SYS_GROWTH/(float)index)*255);
    
    systems.add(sys);
  }
}

void draw()
{
  background(0);
  //lights();
  for (int i = 0; i < systems.size(); i++)
  {
    ParticleSystem sys = systems.get(i);
    if (!sys.done)
    {
      sys.updateSystem();
    }
    sys.drawSystem();
  }
}
