/*
字符排列
用已知字符串s中的字符，生成由其中n个字符组成的所有字符排列。
*/
#include <stdio.h>
#include <string.h>
#define N 20

char w[N];

void perm(int n,char *s){
  char s1[N];
  int i;
  if(n<1) printf("%s\n",w);
  else{
    strcpy(s1,s);
    for(i=0;*(s1+i);i++){
      *(w+n-1)=*(s1+i);
      *(s1+i)=*s1;
      *s1=*(w+n-1);
      perm(n-1,s1+1);
    }
  }
}

int main(int argc,char *argv[]){
  int n=2;
  char s[N];
  w[n]='\0';

  puts("This is a char permutation program!");
  puts("Please input a string:");
  scanf("%s",s);
  puts("Please input the char number of permuted:");
  scanf("%d",&n);
  puts("The permuted chars are:");
  perm(n,s);

  puts("\nPress any key to quit...");
  getch();
  return 0;
}