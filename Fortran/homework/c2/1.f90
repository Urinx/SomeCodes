program main
implicit none
real,dimension(9,10) :: matrix
integer :: i,j

! Read data from file
open(10,file='mat.txt')
read(10,*) ((matrix(i,j),j=1,10),i=1,9)

! Start
print *
print *,'=============='
print *,'The matrix is:'
print *,'=============='
print *
call printMat(matrix)
print *
call gauss_elimination(matrix)
call doolittle_decomposition(matrix)
call gauss_seidel(matrix)
call over_relaxation(matrix)

end program main

! ==========================
! Print the matrix on screen
subroutine printMat(m)
implicit none
real,dimension(9,10) :: m
integer :: i,j,a,b
a=size(m(:,1))
b=size(m(1,:))
write(*,"(f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4)") ((m(i,j),j=1,b),i=1,a)
end subroutine printMat

subroutine printMat2(m)
implicit none
real,dimension(9,9) :: m
integer :: i,j,a,b
a=size(m(:,1))
b=size(m(1,:))
write(*,"(f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4)") ((m(i,j),j=1,b),i=1,a)
end subroutine printMat2

! ============================
! Change row i and j of matrix
subroutine change_row(m,i,j)
implicit none
real,dimension(9,10) :: m
real,dimension(10) :: t
integer :: i,j
t=m(i,:)
m(i,:)=m(j,:)
m(j,:)=t
end subroutine change_row

! =============================
! Exchange Column Pivot Element
! c: Column
subroutine column_pivot(m,c)
implicit none
real,dimension(9,10) :: m
real :: t
integer :: i,j,c
t=0.0
j=c
do i=c,size(m(:,1))
	if (abs(m(i,c)) > t) then
		t=abs(m(i,c))
		j=i
	end if
end do
call change_row(m,c,j)
end subroutine column_pivot

! ================================
! Row i=i+c*j
subroutine row_i_plus_Cxj(m,i,j,c)
implicit none
real,dimension(9,10) :: m
real :: c
integer :: i,j
m(i,:)=m(i,:)+c*m(j,:)
end subroutine row_i_plus_Cxj

! =======================================================
! Triangularization
! - Transform augmented matrix into upper triangular matrix
subroutine triangularization(m)
implicit none
real,dimension(9,10) :: m
integer :: i,j,n
n=size(m(:,1))

do j=1,n-1
	call column_pivot(m,j)
	do i=j+1,n
		call row_i_plus_Cxj(m,i,j,-m(i,j)/m(j,j))
	end do
end do

end subroutine triangularization

! ===========================
! Solve upper diagonal matrix
subroutine solve_upper_diagonal(m,x)
real,dimension(9,10) :: m
real,dimension(9) :: x
real :: s
integer :: n,i,j
n=size(m(:,1))

x(n)=m(n,n+1)/m(n,n)
do i=n-1,1,-1
    s=0.0
    do j=i+1,n
        s=s+m(i,j)*x(j)
    end do
    x(i)=(m(i,n+1)-s)/m(i,i)
end do

end subroutine solve_upper_diagonal

! ===========================
! Solve lower diagonal matrix
subroutine solve_lower_diagonal(m,x)
real,dimension(9,10) :: m
real,dimension(9) :: x
real :: s
integer :: n,i,j
n=size(m(:,1))

x(n)=m(n,n+1)/m(n,n)
do i=1,n
    s=0.0
    do j=1,i-1
        s=s+m(i,j)*x(j)
    end do
    x(i)=(m(i,n+1)-s)/m(i,i)
end do

end subroutine solve_lower_diagonal

! ===================================
! Gauss Elimination Method
subroutine gauss_elimination(matrix)
implicit none
real,dimension(9,10) :: m,matrix
real,dimension(9) :: x=0
integer :: i,j
m=matrix

print *,'========================'
print *,'Gauss Elimination Method'
print *,'========================'
print *
print *,'Triangularization:'
print *
call triangularization(m)
call printMat(m)
print *
print *,'The result:'
print *
call solve_upper_diagonal(m,x)
write(*,'(f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4)') x
print *

end subroutine gauss_elimination

! ============================
! LU Decomposition - Doolittle
subroutine doolittle(m,L,U)
implicit none
real,dimension(9,10) :: m
real,dimension(9,9) :: A,L,U
real :: tmp
integer :: n,i,j,k
n=size(m(:,1))
A=m(:,1:n)

do i=1,n
    L(i,i)=1
    ! set row i of U
    do j=i,n
        tmp=0.0
        do k=1,i-1
            tmp=tmp+L(i,k)*U(k,j)
        end do
        U(i,j)=A(i,j)-tmp
    end do
    ! set col i of L
    do j=i+1,n
        tmp=0.0
        do k=1,i-1
            tmp=tmp+L(j,k)*U(k,i)
        end do
        L(j,i)=(A(j,i)-tmp)/U(i,i)
    end do
end do

end subroutine doolittle

! =======================================
! Doolittle Decomposition Method
subroutine doolittle_decomposition(matrix)
implicit none
real,dimension(9,10) :: m,matrix
real,dimension(9,9) :: L=0,U=0
real,dimension(9) :: x=0,y=0
integer :: i,j,n
m=matrix
n=size(m(:,1))

print *,'=============================='
print *,'Doolittle Decomposition Method'
print *,'=============================='
print *
print *,'Exchange Column Pivot Element'
print *
do i=1,n-1
    call column_pivot(m,i)
end do
call printMat(m)
print *
print *,'￼LU Decomposition'
print *
call doolittle(m,L,U)
print *,'* lower triangular matrix L'
print *
call printMat2(L)
print *
print *,'* upper triangular matrix U'
print *
call printMat2(U)
print *
print *,'Solve Ly=b, get y'
print *
m(:n,:n)=L
call solve_lower_diagonal(m,y)
write(*,'(f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4)') y
print *
print *,'Solve Ux=y, get x'
print *
m(:n,:n)=U
m(:,n+1)=y
call solve_upper_diagonal(m,x)
write(*,'(f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4)') x
print *

end subroutine doolittle_decomposition


! ================================
! Relaxation Iteration Method
subroutine relaxation(m,x,omiga)
implicit none
real,dimension(9,10) :: m
real,dimension(9) :: x,x_
real :: omiga,e
integer :: n,i
n=size(m(:,1))
e=0.01
print *,'set initial x0 = '
write(*,'(f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4)') x
print *
do
    x_=x
    do i=1,n
        x(i)=x(i)+omiga*(m(i,n+1)-sum(m(i,:n)*x))/m(i,i)
    end do
    if (sum(abs(x-x_)) <= e) exit
end do

end subroutine relaxation

! =============================
! Gauss-Seidel Iteration Method
! when omiga = 1
subroutine gauss_seidel(matrix)
implicit none
real,dimension(9,10) :: m,matrix
real,dimension(9) :: x=0
m=matrix

print *,'============================='
print *,'Gauss-Seidel Iteration Method'
print *,'============================='
print *
call relaxation(m,x,1.0)
print *,'The result:'
print *
write(*,'(f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4)') x
print *

end subroutine gauss_seidel

! ================================
! Over-relaxation Iteration Method
subroutine over_relaxation(matrix)
implicit none
real,dimension(9,10) :: m,matrix
real,dimension(9) :: x=0
real :: omiga=1.40
m=matrix

print *,'================================'
print *,'Over-relaxation Iteration Method'
print *,'================================'
print *
write(*,'(a,f7.4)') ' set omiga =',omiga
print *
call relaxation(m,x,omiga)
print *,'The result:'
print *
write(*,'(f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4,f9.4)') x
print *

end subroutine over_relaxation

