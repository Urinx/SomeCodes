/*猜数字游戏*/
#include <stdio.h>
#include <conio.h>
main(){
  int Password=0,Number=0,price=58,i=0;
  printf("\n====This is a Number Guess Game!====\n");
  while(Password!=1234){
    if(i>=3){
      printf("\n Please input the right password!\n");
      return;
    }
    i++;
    puts("Please input Password:");
    scanf("%d",&Password);
  }

  i=0;
  while(Number!=price){
    do{
      puts("Please input a number between 1 and 100:");
      scanf("%d",&Number);
      printf("Your input number is %d\n",Number);
    }while(!(Number>=1 && Number<=100));

    if(Number>=90){
      puts("Too Bigger! Press any key to try again!");
    }
    else if(Number>=70 && Number<90){
      puts("Bigger!");
    }
    else if(Number>1 && Number<30){
      puts("Too Small! Press any key to try again!");
    }
    else if(Number>30 && Number<=50){
      puts("Small! Press any key to try again!");
    }
    else{
      if(Number==price) puts("OK! You are right! Bye Bye!");
      else if(Number<price) puts("Sorry,Only a little smaller! Press any key to try again!");
      else if(Number>price) puts("Sorry,Only a little bigger! Press any key to try again!");
    }
    //getch();
  }
}