/*输入年份，输出该年的年历*/
#include <stdio.h>

long int f(int year,int month){
  if(month<3) return year-1;
  else return year;
}

long int g(int month){
  if(month<3) return month+13;
  else return month+1;
}

long int n(int year,int month,int day){
  return 1461L*f(year,month)/4+153L*g(month)/5+day;
}

int w(int year,int month,int day){
  return (int)((n(year,month,day)%7-621049L%7+7)%7);
}

int date[12][6][7];
int day_tbl[][12]={{31,28,31,30,31,30,31,31,30,31,30,31},{31,29,31,30,31,30,31,31,30,31,30,31}};

main(){
  int sw,leap,i,j,k,wd,day,year;
  char title[]="SUN MON TUE WED THU FRI SAT";

  puts("Please input the year whose calendar you want to know:");
  scanf("%d%*c",&year);

  sw=w(year,1,1);
  leap=year%4==0&&year%100||year%400==0;
  for(i=0;i<12;i++)
    for(j=0;j<6;j++)
      for(k=0;k<7;k++)
        date[i][j][k]=0;
  for(i=0;i<12;i++)
    for(wd=0,day=1;day<day_tbl[leap][i];day++){
      date[i][wd][sw]=day;
      sw=++sw%7;
      if(sw==0) wd++;
    }

  printf("\n|================== The Calendar of Year %d =================|\n|",year);
  for(i=0;i<6;i++){
    for(wd=0,k=0;k<7;k++) wd+=date[i][5][k]+date[i+6][5][k];
    wd=wd?6:5;
    printf("%2d %s %2d %s |\n|",i+1,title,i+7,title);
    for(j=0;j<wd;j++){
      printf("  ");
      for(k=0;k<7;k++)
        if(date[i][j][k]) printf("%4d",date[i][j][k]);
        else printf("    ");
        printf("   ");
      for(k=0;k<7;k++)
        if(date[i+6][j][k]) printf("%4d",date[i+6][j][k]);
        else printf("    ");
     printf(" |\n|");
    }
  }
  puts("==============================================================|");
}