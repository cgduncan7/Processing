class Particle
{
  float x, y, z, t;
  int r, age;
  
  Particle(float x, float y, float z, float t, int r)
  {
    this.x = x;
    this.y = y;
    this.z = z;
    this.t = t;
    this.r = r;
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
    pushMatrix();
    translate(x,y,z+age);
    sphere(r);
    popMatrix();
  }
}

class ParticleSystem
{
  Particle[] particles;
  int numParticles, sysRadius;
  float rotationSpeed;
  
  ParticleSystem(int numParticles, int particleRadius, int sysRadius, float rotationSpeed)
  {
    this.numParticles = numParticles;
    this.sysRadius = sysRadius;
    this.rotationSpeed = rotationSpeed;
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
    particles[index] = new Particle((width/2) + x, (height/2) + y, 0, t, 5);
  }
  
  void renewParticle(int index)
  {
    killParticle(index);
    createParticle(index);
  }
  
  void updateSystem()
  {
    for (int i = 0; i < numParticles; i++)
    {
      int age = particles[i].getAge();
      if ( age < sysRadius )
      {
        float t = (particles[i].getAngle() + rotationSpeed);
        particles[i].move((width/2)+((sysRadius-age)*cos(t)), (height/2)+((sysRadius-age)*sin(t)), 0, t);
      }
      else
      {
        if (i < numParticles-1)
        {
          renewParticle(i);
        }
        else
        { // create new particle system
          killParticle(i);
          numParticles = numParticles - 1;
          rotationSpeed = rotationSpeed * 2.5;
          print("numParticles = " + numParticles + "\n");
          print("rotationSpeed = " + rotationSpeed + "\n");
        }
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

ParticleSystem sys;

void setup()
{
  size(500,500, P3D);
  //camera(width/2.0, height/2.0, (height/2.0) / tan(PI*30.0/180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  sys = new ParticleSystem(32,5,100,.01);
}

void draw()
{
  background(0);
  strokeWeight(5);
  line(0,0,0,width,0,0);
  sys.updateSystem();
  sys.drawSystem();
}
