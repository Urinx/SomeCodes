program format
implicit none
!demonstrates use of the format statement
integer,parameter :: ikind=selected_real_kind(p=15)
real,dimension(4) :: x
integer,dimension(4) :: nums
integer :: i
real(kind=ikind),dimension(4) :: computed
!dill up the arrays with something
do i=1,4
   nums(i)=i*10
   computed(i)=cos(0.1*i)
   x(i)=computed(i)
end do
print *,'nums-integer'
write(*,1) nums
1 format(2i10)
print *,'x-real'
write(*,2) x
2 format(f6.2)
print *,'computed-double precision'
write(*,3) computed
3 format(f20.7)
end
