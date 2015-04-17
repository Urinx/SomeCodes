program main
implicit none
integer,parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind),external :: f,df,g1,g2
real,external :: dg1
call Jacobi(f,g1,1.5)
call Jacobi(f,g2,1.5)
call Jacobi(f,g2,-1.5)
call NewtonDownhill(f,df,1.5)
call NewtonDownhill(f,df,0.5)
call PostAcceleration(f,g1,dg1,0.5)
call Aitken(f,g1,1.5)
end program main

!================= Functions =================
function f(x)
implicit none
integer,parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind) :: x,f
f=x*x*x/3.0_ikind-x
end function f

function df(x)
implicit none
integer,parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind) :: x,df
df=x*x-1
end function df

function g1(x)
implicit none
integer,parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind) :: x,f,g1
g1=f(x)+x
end function g1

function dg1(x)
implicit none
real :: x,dg1
dg1=x*x
end function dg1

function g2(x)
implicit none
integer,parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind) :: x,g2
g2=sign( abs(3.0_ikind*x)**(1.0_ikind/3._ikind), x)
end function g2

!=============== Subroutines ================
! Jacobi Method
! f: functions
! g: functions
! x0: initial value x
subroutine Jacobi(f,g,x0)
implicit none
integer,parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind),external :: f,g
real (kind=ikind) :: x,x_
real :: x0,e1,e2
integer :: k,k_max
print *,'==========================================='
print *,'Jacobi...'
!Select proper initial value x0
x=x0
print *,'Set initial x=',x0
e1=0.000000000001
e2=0.000000000001
print *,'Set e1=',e1,'e2=',e2
print *
k=0
k_max=100
write(*,"(5x,'  k',5x,'        x(k)',10x,'    x(k)-x(k-1)')")
do
	k=k+1
	x_=x
	x=g(x)
	write(*,100) k,x,x-x_
	100 format(5x,i3,5x,f19.15,5x,f19.15)

	if (f(x)<=e1 .and. abs(x-x_)<=e2) then
		print *
		print *,'Iteration end!'
		print *,'x=',x
		exit
	else if (k>=k_max) then
		write(*,"(5x,'...')")
		write(*,"(5x,'Too many iterations!')")
		exit
	end if
end do
print *,'==========================================='
end subroutine Jacobi

!============================================
! Newton Downhill Method
! f: functions
! df: functions
! x0: initial value x
subroutine NewtonDownhill(f,df,x0)
implicit none
integer,parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind),external :: f,df
real (kind=ikind) :: x,x_
real :: x0,delta,lambda,e1,e2,el
integer :: k
print *,'==========================================='
print *,'Newton Downhill...'
x=x0
lambda=1
print *,'Set initial x0=',x,'Lambda=',lambda
e1=0.000000000001
e2=0.000000000001
el=0.000000000001
delta=0.000000000001
print *,'Set e1=',e1,'e2=',e2
print *,'    el=',el,'delta=',delta
print *
k=0
write(*,"(5x,'  k',5x,'        x(k)',10x,'    x(k)-x(k-1)')")
do
	k=k+1
	x_=x
	x=x-lambda*f(x)/df(x)
	write(*,100) k,x,x-x_
	100 format(5x,i3,5x,f19.15,5x,f19.15)

	if (f(x)<=f(x_)) then
		if (f(x_)<=e1 .and. abs(x-x_)<=e2) then
			print *
			print *,'Iteration end!'
			print *,'x=',x
			exit
		end if
	else
		if (lambda > el) then
			lambda=lambda/2
		else
			x=x_+delta
		end if
	end if
end do
print *,'==========================================='
end subroutine NewtonDownhill

!============================================
! Post Accelerating Method
! f: functions
! g: functions
! dg: functions
! x0: initial value x
subroutine PostAcceleration(f,g,dg,x0)
implicit none
integer,parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind),external :: f,g
real (kind=ikind) :: x,x_
real,external :: dg
real :: x0,e1,e2,L
integer :: k,k_max
print *,'==========================================='
print *,'Post Accelerating...'
x=x0
L=dg(x0)
print *,'Set initial x0=',x,'L=',L
e1=0.000000000001
e2=0.000000000001
print *,'Set e1=',e1,'e2=',e2
print *
k=0
k_max=100
write(*,"(5x,'  k',5x,'        x(k)',10x,'    x(k)-x(k-1)')")
do
	k=k+1
	x_=x
	x=(g(x)-L*x)/(1-L)
	write(*,100) k,x,x-x_
	100 format(5x,i3,5x,f19.15,5x,f19.15)

	if (f(x_)<=e1 .and. abs(x-x_)<=e2) then
		print *
		print *,'Iteration end!'
		print *,'x=',x
		exit
	else if (k>=k_max) then
		write(*,"(5x,'...')")
		write(*,"(5x,'Too many iterations!')")
		exit
	end if
end do
print *,'==========================================='
end subroutine PostAcceleration

!============================================
! Aitken Method
! f: functions
! g: functions
! x0: initial value x
subroutine Aitken(f,g,x0)
implicit none
integer,parameter :: ikind=selected_real_kind(p=15)
real (kind=ikind),external :: f,g
real (kind=ikind) :: x,x_
real :: x0,e1,e2
integer :: k,k_max
print *,'==========================================='
print *,'Aitken...'
x=x0
print *,'Set initial x0=',x
e1=0.000000000001
e2=0.000000000001
print *,'Set e1=',e1,'e2=',e2
print *
k=0
k_max=100
write(*,"(5x,'  k',5x,'        x(k)',10x,'    x(k)-x(k-1)')")
do
	k=k+1
	x_=x
	x=g(x_)
	x=g(x)-(g(x)-x)**2/(g(x)-2*x+x_)
	write(*,100) k,x,x-x_
	100 format(5x,i3,5x,f19.15,5x,f19.15)

	if (f(x)<=e1 .and. abs(x-x_)<=e2) then
		print *
		print *,'Iteration end!'
		print *,'x=',x
		exit
	else if (k>=k_max) then
		write(*,"(5x,'...')")
		write(*,"(5x,'Too many iterations!')")
		exit
	end if
end do
print *,'==========================================='
end subroutine Aitken