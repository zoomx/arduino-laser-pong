//Character drawing methods

int fullWidth = 0;

int newX(int charPosX, int charX)
{
  if(fullWidth == 1){
    return (3 * charPosX + charX);
  } else {
    return (2 * charPosX + charX);
  }
}
int newY(int charPosY, int charY)
{
  return (3 * charPosY + charY);
}
int nline(int charPosX, int charPosY, int newX1, int newY1, int newX2, int newY2)
{
  line(newX(charPosX, newX1),newY(charPosY, newY1), newX(charPosX, newX2),newY(charPosY, newY2));
}
int nmove(int charPosX, int charPosY, int newX0, int newY0)
{
  move(newX(charPosX, newX0),newY(charPosY, newY0));
}

void charDraw(int charPosX, int charPosY, char char0)
{  
  if(char0 == '0'){ //draw a "0"
    nline(charPosX,charPosY, 1,2, 2,2);
    nline(charPosX,charPosY, 2,2, 2,0);
    nline(charPosX,charPosY, 2,0, 1,0);
    nline(charPosX,charPosY, 1,0, 1,2);
  }
  if(char0 == '1'){
    nmove(charPosX,charPosY, 2,2);
    nline(charPosX,charPosY, 2,0, 2,2);
  }
  if(char0 == '2'){
    nline(charPosX,charPosY, 1,2, 2,2);
    nline(charPosX,charPosY, 2,2, 2,1);
    nline(charPosX,charPosY, 2,1, 1,1);
    nline(charPosX,charPosY, 1,1, 1,0);
    nline(charPosX,charPosY, 1,0, 2,0);
  }
  if(char0 == '3'){
    nline(charPosX,charPosY, 1,2, 2,2);
    nline(charPosX,charPosY, 2,2, 2,0);
    nline(charPosX,charPosY, 2,0, 1,0);
    nline(charPosX,charPosY, 1,1, 2,1);
  }
  if(char0 == '4'){
    nline(charPosX,charPosY, 1,2, 1,1);
    nline(charPosX,charPosY, 1,1, 2,1);
    nline(charPosX,charPosY, 2,2, 2,0);
  }
  if(char0 == '5'){
    nline(charPosX,charPosY, 2,2, 1,2);
    nline(charPosX,charPosY, 1,2, 1,1);
    nline(charPosX,charPosY, 1,1, 2,1);
    nline(charPosX,charPosY, 2,1, 2,0);
    nline(charPosX,charPosY, 2,0, 1,0);
  }
  if(char0 == '6'){
    nline(charPosX,charPosY, 2,2, 1,2);
    nline(charPosX,charPosY, 1,2, 1,0);
    nline(charPosX,charPosY, 1,0, 2,0);
    nline(charPosX,charPosY, 2,0, 2,1);
    nline(charPosX,charPosY, 2,1, 1,1);
  }
  if(char0 == '7'){
    nline(charPosX,charPosY, 1,2, 2,2);
    nline(charPosX,charPosY, 2,2, 2,0);
  }
  if(char0 == '8'){
    nline(charPosX,charPosY, 1,2, 2,2);
    nline(charPosX,charPosY, 2,2, 2,0);
    nline(charPosX,charPosY, 2,0, 1,0);
    nline(charPosX,charPosY, 1,0, 1,2);
    nline(charPosX,charPosY, 1,1, 2,1);
  }
  if(char0 == '9'){
    nline(charPosX,charPosY, 2,1, 1,1);
    nline(charPosX,charPosY, 1,1, 1,2);
    nline(charPosX,charPosY, 1,2, 2,2);
    nline(charPosX,charPosY, 2,2, 2,0);
  }
  if(char0 == '-'){
    nline(charPosX,charPosY, 2,1, 1,1);
  }
}

void laserPrint(int strPosX, int strPosY, char string[])
{
  int i;
  for(i = strPosX; i < strPosX + strlen(string); i++){
    charDraw(i + strPosX, strPosY, string[i]);
  }
}
