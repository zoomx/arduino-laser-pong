//Pong itself

#define WIDTH 20
#define HEIGHT 16
#define BAT_HEIGHT 4

unsigned long time; //time in screen refreshes since on
char ballX, ballY, ballXvel, ballYvel;
unsigned char scoreA, scoreB;
unsigned char batA, batB;
char ballVel[] = {-1, 1};

void pongSetup()
{
  resetBall();
}

void pongLoop()
{
  checkPause();
  moveBats();
  moveBall();
  draw();
  time++;
}

void draw()
{
  drawBats();
  drawBall();
  //drawScore();
}

void drawBats()
{
  rect(0,batA, BAT_HEIGHT);
  rect(WIDTH,batB, BAT_HEIGHT);
}

void moveBats()
{
  batA = getPotA(HEIGHT - BAT_HEIGHT);
  batB = getPotB(HEIGHT - BAT_HEIGHT);
}

void drawBall()
{
  square(ballX,ballY, 1);
}

void resetBall()
{
  int i;
  for(i = 1; i < 20; i++){
    draw();
    drawScore();
  }
  
  ballX = WIDTH / 2;
  ballY = HEIGHT / 2;
  ballXvel = ballVel[rand() % 2];
  ballYvel = ballVel[rand() % 2];
  
  for(i = 1; i < 20; i++){
    moveBats();
    draw();
    //drawScore();
  }
}

void moveBall()
{
  if(ballY + 1 >= HEIGHT){ //too far up
    ballYvel = -1;
  } else if(ballY <= 0){ //too far down
    ballYvel = 1;
  }
  if(ballX + 1 >= WIDTH) //too far right
  {
    if((ballY >= batB) && ((ballY + 1) <= (batB + BAT_HEIGHT))){
      ballXvel = -1;
    } else {
      scoreA++;
      resetBall();
    }
  } else if(ballX <= 1) //too far left
  {
    if((ballY >= batA) && ((ballY + 1) <= (batA + BAT_HEIGHT))){
      ballXvel = 1;
    } else {
      scoreB++;
      resetBall();
    }
  }
  ballX = ballX + ballXvel;
  ballY = ballY + ballYvel;
}

void drawScore()
{
  char score[10];
  sprintf(score, "%d-%d", scoreA, scoreB);
  //laserPrint(WIDTH / 2 - 1, HEIGHT / 2, score);
  int charX = WIDTH/2 - 1;
  int charY = HEIGHT/2;
  laserPrint(0,-1, score);
}

void checkPause()
{
  while(digitalRead(2) == HIGH){
    draw();
    drawScore();
  }
}
