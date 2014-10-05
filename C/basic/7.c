/*计算数列的和*/
#include <stdio.h>
main(){
  int i,j,n;
  long int sum=0,temp;
  puts("Please input a number to n:");
  scanf("%d",&n);

  if(n<1){
    puts("The n must be no less than 1!");
    return;
  }

  for(i=1;i<=n;i++){
    temp=0;
    for(j=1;j<=i;j++) temp+=j;
    sum+=temp;
  }

  printf("The sum of the sequence(%d) is %d\n",n,sum);
}