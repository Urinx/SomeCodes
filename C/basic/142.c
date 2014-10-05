/*
修改环境变量
*/
#include <stdio.h>
#include <stdlib.h>
#include <malloc.h>
#include <string.h>
#include <dos.h>

void main(void){
  char *path,*ptr;
  int i=0;

  puts("This program is to get the Path and change it.");
  ptr=getenv("PATH");

  path=(char *)malloc(strlen(ptr)+15);
  strcpy(path,"PATH=");
  strcat(path,ptr);
  strcat(path,";c:\\temp");

  putenv(path);
  while(environ[i]){
    printf(" >> %s\n",environ[i++]);
  }
  printf("Press any key to quit...\n");
  getch();
}
