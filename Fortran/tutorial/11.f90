program io2
implicit none
real :: num
integer :: i
open(12,file='myoutput')
do i=1,100
	num = i/3.0
	write(12,*) num
end do
print *,'finished'
end