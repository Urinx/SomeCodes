/*
阿拉伯数字转换为罗马数字

1000->M
900->CM
500->D
400->CD
100->C
90->XC
50->L
40->XL
10->X
9->IX
5->V
4->IV
1->I

Usage:
./roman [start] end
start :Start Number(default is 1)
end   :End Number

*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#define ROWS 4
#define COLS 4

int nums[ROWS][COLS]={
  {1000,1000,1000,1000},
  {900,500,400,100},
  {90,50,40,10},
  {9,5,4,1}
};

char *roms[ROWS][COLS]={
  {"M","M","M","M"},
  {"CM","D","CD","C"},
  {"XC","L","XL","X"},
  {"IX","V","IV","I"}
};

void checknum(int);

int main(int argc, char *argv[]){
  int low,high;
  char roman[25];
  if(argc<2){
    //运行程序需带整数参数
    printf("Usage:roman decimal numbel\n");
    exit(0);
  }
  high=low=atoi(argv[1]);
  checknum(low);
  if(argc>2){
    high=atoi(argv[2]);
    checknum(high);
    if(low>high){
      low+=high;
      high=low-high;
      low-=high;
    }
  }
  else low=1;

  for(;low<=high;low++){
    to_roman(low,roman);
    printf("%d\t%s\n",low,roman);
  }

  return 0;
}

//检查参数合理性
void checknum(int val){
  if(val<1 | val>9999){
    printf("The number must be in range 1..9999\n");
    exit(0);
  }
}

//将整数转换成罗马数字表示
to_roman(int decimal,char roman[]){
  int power,index;
  roman[0]='\0';
  for(power=0;power<ROWS;power++)
    for(index=0;index<COLS;index++)
      while(decimal>=nums[power][index]){
        //strcat:把src所指字符串添加到dest结尾处(覆盖dest结尾处的'\0')并添加'\0'
        strcat(roman,roms[power][index]);
        decimal-=nums[power][index];
      }
}









