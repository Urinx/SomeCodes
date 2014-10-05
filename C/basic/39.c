/*
文件的字数统计程序
统计一个或多个文件的行数、字数和字符数。
*/
#include <stdio.h>
#include <stdlib.h>

int main(int argc,char *argv[]){
  FILE *fp;
  int lflg,wflg,cflg;
  int inLine,inword;
  int ccount,wcount,lcount;
  int c;
  char *s;
  lflg=wflg=cflg=0;

  if(argc<2){
    puts("To run this program, usage: program -l -w -c file1 file2 ... filen");
    exit(0);
  }

  while( --argc>=1 && (*++argv)[0]=='-' ){
    for(s=argv[0]+1;*s!='\0';s++){
      switch(*s){
        case 'l':
          lflg=1;
          break;
        case 'w':
          wflg=1;
          break;
        case 'c':
          cflg=1;
          break;
        default:
          puts("To run this program, usage: program -l -w -c file1 file2 ... filen");
          exit(0);
      }
    }
  }

  if(lflg==0 && wflg==0 && cflg==0)
    lflg=wflg=cflg=1;
  lcount=wcount=ccount=0;

  while(--argc>=0){
    if( (fp=fopen(*argv++,"r"))==NULL ){
      fprintf(stderr,"Can't open %s.\n",*argv);
      continue;
    }
    inword=inLine=0;
    while( (c=fgetc(fp))!=EOF ){
      if(cflg) ccount++;
      if(wflg){
        if(c=='\n' || c==' ' || c=='\t') inword=0;
        else if(inword==0){
          wcount++;
          inword=1;
        }
      }
      if(lflg){
        if(c=='\n') inLine=0;
        else if(inLine==0){
          lcount++;
          inLine=1;
        }
      }
      fclose(fp);
    }
  }

  if(lflg) printf(" Lines = %d\n",lcount);
  if(wflg) printf(" Words = %d\n",wcount);
  if(cflg) printf(" Characters = %d\n",ccount);
  return 0;
}
