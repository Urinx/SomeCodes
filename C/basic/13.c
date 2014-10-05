/*计算二维数组的最大最小值*/
#include <stdio.h>
#define MAXN 20
int a[MAXN][MAXN];

main(){
  int min,max;
  int row,col,n;
  puts("Please input the order of the matrix:");
  scanf("%d",&n);
  printf("Please input the elements of the matrix,\n from a[0][0] to a[%d][%d]:\n",n-1,n-1);
  for(row=0;row<n;row++)
    for(col=0;col<n;col++) scanf("%d",&a[row][col]);

  for(min=a[0][0],row=0;row<n;row++){
    for(max=a[row][0],col=1;col<n;col++)
      if(max<a[row][col]) max=a[row][col];
    if(min>max) min=max;
  }
  printf("The minimum of maximum number is %d\n",min);

  for(max=a[0][0],row=0;row<n;row++){
    for(min=a[row][0],col=1;col<n;col++)
      if(min>a[row][col]) min=a[row][col];
    if(max<min) max=min;
  }
  printf("The maximum of minimum number is %d\n",max);
}