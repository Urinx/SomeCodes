#include <stdio.h>

int add(int a,int b){
    if(a*b!=0)
        return printf("%*c%*c",a,'\r',b,'\r');
    else return a!=0?a:b;
}

int Add(int x,int y){
    if(y==0)
        return x;
    else
        return Add(x^y,(x&y)<<1);
}

void main(){
    int A=3,B=12;
    printf("%d\n",add(A,B));
}
