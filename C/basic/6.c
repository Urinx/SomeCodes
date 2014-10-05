/*自增运算符的应用*/
#include <stdio.h>
main(){
  int a=5,b,c,i=10;
  b=a++;//b=5
  c=++b;//c=6

  printf("a=%d,b=%d,c=%d\n",a,b,c);//a=6,b=6,c=6
  printf("i,i++,i++=%d,%d,%d\n",i,i++,i++);//12,11,10
  printf("%d\n",++i);//13
  printf("%d\n",--i);//12
  printf("%d\n",i++);//12,i=13
  printf("%d\n",i--);//13,i=12
  printf("%d\n",-i++);//-12,i=13
  printf("%d\n",-i--);//-13,i=12
}