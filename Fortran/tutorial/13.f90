program whileloop
implicit none
integer, parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind) :: sum,previoussum,x,smallnumber,error
integer :: i
sum=0.0
previoussum=0.0
smallnumber=10.0**(-15.0)
do i=1,100
	x=i
	sum=sum+1.0/(x**6)
	error=abs(sum-previoussum)
	if (error<=smallnumber) then
		print *,'sum ',sum,' number of loops ',i
		exit
	end if
	previoussum = sum
end do
end