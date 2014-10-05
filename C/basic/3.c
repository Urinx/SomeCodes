/*输入两个浮点数，输出其中较大的数*/
#include <stdio.h>
main(){
  float x,y,c;
  puts("Please input x and y:");
  scanf("%f%f",&x,&y);
  c=x>y?x:y;
  printf("MAX of (%f,%f) is %f",x,y,c);
}