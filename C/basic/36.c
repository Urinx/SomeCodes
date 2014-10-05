/*
统计文件的字符数
*/
#include <stdio.h>
#include <stdlib.h>

int main(int argc,char *argv[]){
  char fname[80];
  FILE *rfp;
  long count;

  puts("Please input the file's name:");
  scanf("%s",fname);
  if( (rfp=fopen(fname,"r")) == NULL ){
    printf("Can't open file %s.\n",fname);
    exit(0);
  }

  count=0;
  while( fgetc(rfp)!=EOF ) count++;
  fclose(rfp);
  printf("There are %ld characters in file %s.\n",count,fname);

  puts("\nPress any key to quit...");
  getch();
  return 0;
}
