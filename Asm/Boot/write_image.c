#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#define SIZE 512

int main(int argc,char *argv[]){
    int f_in;
    int f_out;
    int count;
    char buffer[SIZE];

    f_in=open("boot.bin",O_RDONLY);
    if(f_in<0){
        perror("open boot.bin error:");
        return 0;
    }
    f_out=open("floppy.vfd",O_WRONLY);
    if(f_out<0){
        perror("open floppy.vfd error:");
        return 0;
    }

    while( (count=read(f_in,buffer,SIZE))>0 ){
        write(f_out,buffer,count);
        memset(buffer,0,512);
    }
    
    printf("Write image ok!\n");
    return 1;
}
