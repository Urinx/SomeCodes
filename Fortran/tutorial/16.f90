program alloc
implicit none
real,dimension(10) :: a,b,c,d
open(10,file='data.txt')
read(10,*) a
b=a*10
c=b-a
d=1
print *,'a= ',a
print *,'b= ',b
print *,'c= ',c
print *,'d= ',d
end