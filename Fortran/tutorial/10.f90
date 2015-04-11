program readdata
implicit none
!reads data from a file called mydata.txt
real :: x,y,z
open(10,file='mydata.txt')
read(10,*) x,y,z
print *,x,y,z
end