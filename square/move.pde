//Stepper motor classes

int dX(int x)
{
  return (x - absX);
}
int dY(int y)
{
  return (y - absY);
}
int m4(int x, int y)
{
  if(dX(x) == 0){
    return 32767;
  } else {
    return (4 *dY(y))/dX(x);
  }
}

void move(int x, int y)
{
	if(dY(y) == 0 && dX(x) == 0){
		return; //no change in x and y means no movement
	}
	
	if(dY(y) != 0 && dX(x) != 0 && diagLines == 1)
	{ //nonzero slope
		if(diagLines2 == 1){
			//slope >= 2
			while(m4(x,y) >= 8 && x > absX){
				umove(1, 2);}
			while(m4(x,y) >= 8 && x < absX){
				umove(-1, -2);}
			
			//slope <= -2
			while(m4(x,y) <= -8 && x > absX){
				umove(1, -2);}
			while(m4(x,y) <= -8 && x < absX){
				umove(-1, 2);}
		}
		
		//slope >= 1
		while(m4(x,y) >= 4 && x > absX){
			umove(1, 1);}
		while(m4(x,y) >= 4 && x < absX){
			umove(-1, -1);}
		
		//slope <= -1
		while(m4(x,y) <= -4 && x > absX){
			umove(1, -1);}
		while(m4(x,y) <= -4 && x < absX){
			umove(-1, 1);}
		
		if(diagLines2 == 1){
			//slope >= 1/2
			while(m4(x,y) >= 2 && x > absX){
				umove(2, 1);}
			while(m4(x,y) >= 2 && x < absX){
				umove(-2, -1);}
			
			//slope <= -1/2
				while(m4(x,y) <= -2 && x > absX){
				umove(2, -1);}
			while(m4(x,y) <= -2 && x < absX){
				umove(-2, 1);}
		}
	}
	
	if(selFull == 1){ //full stepping where possible
		//slope = 0
		while(dX(x) > 2){
			umove(2, 0);}
		while(dX(x) < -2){
			umove(-2, 0);}

		//slope = infinity
		while(dY(y) > 2){
			umove(0, 2);}
		while(dY(y) < -2){
			umove(0, -2);}
	}
	
	//else slope = 0
	while(x > absX){
		umove(1, 0);}
	while(x < absX){
		umove(-1, 0);}
	
	//else slope = infinity
	while(y < absY){
		umove(0, -1);}
	while(y > absY){
		umove(0, 1);}
}

void umove(int changeA, int changeB)
{
  static int motorA;
  static int motorB;
  int pos[8] = {1, 3, 2, 6, 4, 12, 8, 9};
  
  absX = absX + changeA;
  absY = absY + changeB;
  motorA = motorA + changeA;
  motorB = motorB + changeB;
  
  if(motorA < 0){
    motorA = motorA + 8;}
  if(motorA > 7){
    motorA = motorA - 8;}
  if(motorB < 0){
    motorB = motorB + 8;}
  if(motorB > 7){
    motorB = motorB - 8;}
  
  //outb(pos[motorA] + 16 * pos[motorB], addr);
  PORTD = laser + 16 * pos[motorA] + 4; //+4 for pullup on pin 3
  PORTB = pos[motorB];
  
  if(abs(changeA) == 1 && abs(changeB) == 1){
    usleep(uwait);
  } else {
    usleep(uwait2);
  }
  
  /*if(debug == 1){
    Serial.println("  (%d, %d)\n", absX, absY);}*/
}

void laserOff()
{
  PORTD = PORTD | B00001000; //digitalWrite is too slow
  laser = B00000000;
  if(debug == 1){
    Serial.println("Laser Off\n");}
}

void laserOn()
{
  PORTD = ~(PORTD | B11110111);
  laser = B00001000;
  if(debug == 1){
    Serial.println("Laser On\n");}
}
