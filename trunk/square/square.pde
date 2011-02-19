int debug = 0;
int laser;
int uwait = 1250; //1250 us for 9v motor, half stepping
int uwait2 = 2500; //2500 us for full stepping
char diagLines2 = 0; //diagonal lines of slope other than 1 or -1
char diagLines = 1; //enable diagonal lines
int absX, absY;
int selFull = 1;
int potApin = 0;
int potBpin = 1;

void setup()
{
  Serial.begin(9600);
  
  DDRD = DDRD | B11111000; //pins 3-7 as output
  DDRB = B00101111; //pins 8-11 and 13 as output
  
  pongSetup();
}

void loop()
{
  pongLoop();
}

int getPotA(int res)
{
  return res - map(analogRead(potApin), 0, 1023, 0, res - 1);
}
int getPotB(int res)
{
  return res - map(analogRead(potBpin), 0, 1023, 0, res - 1);
}

void usleep(int time)
{
  delayMicroseconds(time);
}

void line(int x1, int y1, int x2, int y2)
{
  laserOff();
  move(x1, y1);
  laserOn();
  move(x2, y2);
  laserOff();
}

void square(int x, int y, int size)
{
  line(x,y, x+size, y);
  line(x+size,y, x+size, y+size);
  line(x+size,y+size, x,y+size);
  line(x,y+size, x,y);
}

void rect(int x, int y, int height)
{
  line(x,y, x+1,y);
  line(x+1,y, x+1,y+height);
  line(x+1,y+height, x,y+height);
  line(x,y+height, x,y);
}
