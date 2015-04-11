program xytab
implicit none
!constructs a table of z=x/y for values of x from 1 to 2 and
!y from 1 to 4 in steps of .5
real :: x,y,z
print *,'	x	y	z'
do x=1,2
	do y=1,4,0.5
		z=x/y
		print *,x,y,z
	end do
end do
end