/*乘法口诀表*/
#include <stdio.h>
#include <conio.h>
main(){
  int i,j,x=9,y=5;
  clrscr();//清屏
  printf("\n\n***Pithy Formula Table of Multiplication***\n\n");

  for(i=1;1<=9;i++){
    gotoxy(x,y);//移动指定的光标位置，TC下使用
    printf("%2d",i);
    x+=3;
  }

  x=7,y=6;
  for(i=1;i<=9;i++){
    gotoxy(x,y);
    printf("%2d",i);
    y++;
  }

  x=9,y=6;
  for(i=1;i<=9;i++){
    for(j=1;j<=9;j++){
      gotoxy(x,y);
      printf("%2d",i*j);
      y++;
    }
    y-=9;
    x+=3;
  }

}