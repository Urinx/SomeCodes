#include <stdio.h>

struct Foo{
    int x;
    int y;
    int z;
};
struct Foo foo={.z=3,.x=5};

int a[]={[1]=2,[4]=5};

void main(){
    printf("%d\n",foo.x);
}
