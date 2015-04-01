#include <stdio.h>
#include <stdlib.h>

void showbyte(char *,int);
void showint(int);

void main(int argc,char *argv[]){
    int a;
    a=atoi(argv[1]);
    showint(a);
}

void showint(int a){
    printf("int a=%d\t// Hex:%x\n",a,a);
    showbyte((char *) &a, sizeof(int));
}

void showbyte(char *p, int len){
    int i;
    for (i=0;i<len;i++){
        printf("%p\t0x%.2x\n",p+i,*(p+i));
    }
    printf("\n");
}
