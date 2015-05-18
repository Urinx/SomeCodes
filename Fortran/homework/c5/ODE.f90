module ODE
    implicit none
    private
    public :: x,y,init,Basic_Euler,Improved_Euler,Four_Order_Runge_Kutta,analytic_solution

    real,allocatable :: x(:),y(:)
    real :: x0,y0,a,b,h
    integer :: n,i

contains

    function f(x,y)
        implicit none
        real :: f,x,y
        f=-x*x*y*y
    end function f

    function analytic_solution(x) result(f)
        implicit none
        real :: f,x
        f=3.0/(1+x*x*x)
    end function

    subroutine init(x0_,y0_,a_,b_,h_)
        implicit none
        real :: x0_,y0_,a_,b_,h_
        x0=x0_
        y0=y0_
        a=a_
        b=b_
        h=h_
        n=int((b-a)/h)
        allocate(x(0:n),y(0:n))
        x=(/ (a+i*h,i=0,n) /)
        y=0
        y(0)=y0
    end subroutine init

    subroutine Basic_Euler()
        implicit none
        do i=1,n
            y(i)=y(i-1)+h*f(x(i-1),y(i-1))
        end do
    end subroutine Basic_Euler

    subroutine Improved_Euler()
        implicit none
        real :: y_
        do i=1,n
            y_=y(i-1)+h*f(x(i-1),y(i-1))
            y(i)=y(i-1)+h/2*(f(x(i-1),y(i-1))+f(x(i),y_))
        end do
    end subroutine Improved_Euler

    subroutine Four_Order_Runge_Kutta()
        implicit none
        real :: k1,k2,k3,k4
        do i=1,n
            k1=f(x(i-1),y(i-1))
            k2=f(x(i-1)+h/2,y(i-1)+h/2*k1)
            k3=f(x(i-1)+h/2,y(i-1)+h/2*k2)
            k4=f(x(i-1)+h,y(i-1)+h*k3)
            y(i)=y(i-1)+h/6*(k1+2*k2+2*k3+k4)
        end do
    end subroutine Four_Order_Runge_Kutta
end module ODE


program main
    use ODE
    implicit none
    real :: x0=0.0,y0=3.0,a=0.0,b=1.5,h=0.1
    integer :: n,i,j
    character(len=512) :: filename


    print *,'The analytic solution of y(1.5)= ',analytic_solution(1.5)
    print *

    print *,'Basic Euler Method'
    print '(5x,a,f3.1,3x,a,f3.1,3x,a,f3.1,3x,a,f3.1)','Set initial  x0= ',x0,'y0= ',y0,'a= ',a,'b= ',b
    do j=0,3
        h=0.1/2**j
        print '(5x,a,f6.4)','Set h= ',h
        call init(x0,y0,a,b,h)
        n=size(x)-1
        call Basic_Euler
        print '(8x,a,f10.8)','y(1.5)= ',y(n)
        write(filename, *) j
        filename='BEM_'//Trim(AdjustL(filename))//'.txt'
        open(101,file=filename)
        write(101,'(f3.1,f10.8)') (x(i),y(i),i=0,n)
        close(101)
        deallocate(x,y)
    end do
    print *

    print *,'Improved Euler Method'
    print '(5x,a,f3.1,3x,a,f3.1,3x,a,f3.1,3x,a,f3.1)','Set initial  x0= ',x0,'y0= ',y0,'a= ',a,'b= ',b
    do j=0,3
        h=0.1/2**j
        print '(5x,a,f6.4)','Set h= ',h
        call init(x0,y0,a,b,h)
        n=size(x)-1
        call Improved_Euler
        print '(8x,a,f10.8)','y(1.5)= ',y(n)
        write(filename, *) j
        filename='IEM_'//Trim(AdjustL(filename))//'.txt'
        open(101,file=filename)
        write(101,'(f3.1,f10.8)') (x(i),y(i),i=0,n)
        close(101)
        deallocate(x,y)
    end do
    print *

    print *,'Four Order Runge-Kutta Method'
    print '(5x,a,f3.1,3x,a,f3.1,3x,a,f3.1,3x,a,f3.1)','Set initial  x0= ',x0,'y0= ',y0,'a= ',a,'b= ',b
    do j=0,3
        h=0.1/2**j
        print '(5x,a,f6.4)','Set h= ',h
        call init(x0,y0,a,b,h)
        n=size(x)-1
        call Four_Order_Runge_Kutta
        print '(8x,a,f10.8)','y(1.5)= ',y(n)
        write(filename, *) j
        filename='RKM_'//Trim(AdjustL(filename))//'.txt'
        open(101,file=filename)
        write(101,'(f3.1,f10.8)') (x(i),y(i),i=0,n)
        close(101)
        deallocate(x,y)
    end do
    print *

end program main
