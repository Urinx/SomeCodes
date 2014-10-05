/*输入字符，输出通过转义字符控制的字符*/
#include <stdio.h>
main(){
  char c1,c2,c3;
  puts("Plaese input chars to c1,c2,c3:");
  scanf("%c%c%c",&c1,&c2,&c3);
  printf("%s\n%c\n\t%c %c\n %c%c\t\b%c\n","The output is:",c1,c2,c3,c1,c2,c3);
}