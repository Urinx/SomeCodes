program av2
implicit none
integer,parameter :: imax=10
real,dimension(imax) :: x
real :: average,sum
integer :: i
print *,'enter 10 numbers'
sum=0.0
do i=1,imax
	read *,x(i)
	sum=sum+x(i)
end do
average=sum/imax
print *,'the average is ',average
print *,'the numbers are'
print *,x
end