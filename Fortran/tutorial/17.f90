program twodra
implicit none
integer,dimension(2,3) :: a
integer :: row,col,count
count=0
!creates an array with 3 cols and 2 rows
!sets col 1 to 1, col2 to 2 and so on
do row=1,2
	count=0
	do col=1,3
		count=count+1
		a(row,col)=count
	end do
end do

do row=1,2
	do col=1,3
		print *,a(row,col)
	end do
end do
end