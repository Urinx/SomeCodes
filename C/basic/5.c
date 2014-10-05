/*输出不同类型所占的字节数*/
#include <stdio.h>
main(){
  puts("The bytes of the variables are:");
  printf("int:%d bytes\n",sizeof(int));
  printf("char:%d bytes\n",sizeof(char));
  printf("short:%d bytes\n",sizeof(short));
  printf("long:%d bytes\n",sizeof(long));
  printf("float:%d bytes\n",sizeof(float));
  printf("double:%d bytes\n",sizeof(double));
  printf("long double:%d bytes\n",sizeof(long double));
}