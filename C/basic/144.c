/*
显示目录内容
*/
#include <stdio.h>
#include <dirent.h>
#include <malloc.h>
#include <string.h>
#include <stdlib.h>

void main(int argc,char *argv[]){
  DIR *direcory_pointer;
  struct dirent *entry;
  struct FileList
  {
    char filename[64];
    struct FileList *next;
  }start,*node,*previous,*new;

  if( (direcory_pointer=opendir(argv[1]))==NULL )
    printf("Error opening %s\n",argv[1]);
  else{
    start.next=NULL;
    while( entry=readdir(direcory_pointer) ){
      previous=&start;
      node=start.next;

      while( (node) && (strcmp(entry,node->filename)>0) ){
        node=node->next;
        previous=previous->next;
      }

      new=(struct FileList *)malloc(sizeof(struct FileList));
      if(new==NULL){
        puts("Insufficient memory to store list");
        exit(0);
      }

      /*完成插入*/
      new->next=node;
      previous->next=new;
      strcpy(new->filename,entry);
    }

    closedir(direcory_pointer);
    node=start.next;

    /*输出整个链表结点的文件名*/
    while(node){
      printf("%s\n",node->filename);
      node=node->next;
    }
  }

  printf("Press any key to quit...");
  getch();
}