program matrixmul
!demonstrates use of matmul array function and dynamic allocation of array
real, allocatable, dimension(:,:) :: ra1,ra2,ra3
integer :: size

!initialize the arrays
print *,'Shows array manipulation using SQUARE arrays.'
print *,'Allocate the space for the array at run time.'
print *,'Enter thr size of your array'
read *,size
allocate(ra1(size,size),ra2(size,size),ra3(size,size))
print *,'enter matrix elements for ra1 row by row'
call fill_array(size,ra1)
print *,'enter matrix elements for ra2 row by row'
call fill_array(size,ra2)

!echo the arrays
print *,'ra1'
call outputra(size,ra1)
print *,'ra2'
call outputra(size,ra2)

!demonstrate the use of matmul and reanspose intrinsic functions
ra3=matmul(ra1,ra2)
print *,'matmul of ra1 and ra2'
call outputra(size,ra3)
ra3=transpose(ra1)
print *,'transpose of ra1'
call outputra(size,ra3)
deallocate(ra1,ra2,ra3)
end program matrixmul

subroutine outputra(size,ra)
implicit none
!will output a real square array nicely
integer :: size,row,col
real,dimension(size,size) :: ra
character :: reply*1
do row=1,size
	write(*,10) (ra(row,col),col=1,size)
	10 format(100f10.2)
end do
print *,'_____________________________________'
print *,'Hit a key and press enter to continue'
read *,reply
end subroutine outputra

subroutine fill_array(size,ra)
implicit none
!fill the array by prompting from keyboard
integer :: row,col,size
real :: num
real,dimension(size,size) :: ra
do row=1,size
	do col=1,size
		print *,'row=',row,',col=',col
		read *,num
		ra(row,col)=num
	end do
end do
end subroutine fill_array