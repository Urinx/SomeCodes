/*
restrict关键词是一个限定词，可以被用在指针上。它向编译器保证，
在这个指针的生命周期内，任何通过该指针访问的内存，都只能被这个指针改变。
*/

int f(const int * restrict x, int *y)
{
    (*y)++;
    int z=*x;
    (*y)--;
    return z;
}
