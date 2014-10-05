/*
字符替换函数
rep(char *s,char *s1,char *s2)
将已知字符串 s 中所有属于字符串 s1 中的字符都用字符串 s2 中的对应字符代替。
*/
#include <stdio.h>
#include <stdlib.h>
#define MAX 50

void rep(char *s,char *s1,char *s2){
  char *p;
  //顺序访问字符串s中的每个字符
  for(;*s;s++){
    //*检查当前字符是否在字符串s1中出现
    for(p=s1;*p&&*p!=*s;p++);
    //当前字符在字符串s1中出现，用字符串s2中的对应字符代替s中的字符
    if(*p) *s=*(p-s1+s2);
  }
}

int main(int argc, char *argv[]){
  char s[MAX];
  char s1[MAX],s2[MAX];
  //clrscr();
  system("cls");

  puts("Please input the string for s:");
  scanf("%s",s);
  puts("Please input the string for s1:");
  scanf("%s",s1);
  puts("Please input the string for s2:");
  scanf("%s",s2);
  rep(s,s1,s2);

  puts("The string of s after displace is:");
  printf("%s\n",s);

  puts("\n Press any key to quit...");
  getch();
  return 0;
}