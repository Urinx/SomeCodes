module interpolation
    implicit none
    private
    public :: init,lagrange_interpolation,newton_interpolation,lagrange_interpolation_error_analysis,cubic_spline_curve

    real,allocatable :: x_(:),y_(:)
    integer :: N

    contains

    ! 初始化
    subroutine init(x,y)
        implicit none
        real :: x(:),y(:)
        N=size(x)
        allocate (x_(N),y_(N))
        x_=x
        y_=y
    end subroutine init

    ! 计算Li(x)的值
    function L(i,x,s,e)
        real :: L,x
        integer :: i,j,s,e
        L=1
        do j=s,e
            if (i /= j) L=L*(x-x_(j))/(x_(i)-x_(j))
        end do
    end function L

    function Ln(x,s,e)
        real :: Ln,x
        integer :: i,s,e
        Ln=0.0
        do i=s,e
            Ln=Ln+L(i,x,s,e)*y_(i)
        end do
    end function Ln

    ! 拉格朗日插值法
    subroutine lagrange_interpolation(x,y)
        implicit none
        real :: x(:),y(:)
        integer :: i
        y=(/ (Ln(x(i),1,N),i=1,size(x)) /)
    end subroutine lagrange_interpolation

    ! 误差分析
    subroutine lagrange_interpolation_error_analysis(x,r)
        implicit none
        real :: x(:),r(:),t
        integer :: m,i,j
        m=size(x)
        do i=1,m
            r(i)=(x(i)-x_(1))/(x_(1)-x_(N))*(Ln(x(i),1,N-1)-Ln(x(i),2,N))
        end do
    end subroutine lagrange_interpolation_error_analysis

    ! Difference quotient
    recursive function f_(a,b) result(r)
        implicit none
        real :: r
        integer,intent(in) :: a,b

        select case (abs(b-a))
            case (0)
                r=y_(a)
            case (1)
                r=(y_(b)-y_(a))/(x_(b)-x_(a))
            case default
                r=(f_(a+1,b)-f_(a,b-1))/(x_(b)-x_(a))
        end select
    end function f_

    ! Nn(x)
    function Nn(x,a)
        implicit none
        real :: Nn,x,a(:),t
        integer :: i,j
        do i=1,N
            t=1.0
            do j=1,i-1
                t=t*(x-x_(j))
            end do
            Nn=Nn+a(i)*t
        end do
    end function

    ! 牛顿插值法
    subroutine newton_interpolation(x,y)
        implicit none
        real :: x(:),y(:),a(N)
        integer :: i
        a=(/ (f_(1,i),i=1,N) /)
        print *,'a='
        print '(f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5)',a
        print *

        open(101,file="data.txt")
        do i=1,101
            ! There is a bug if you comment the following code，I don't know why this would happen.
            write(101,'(f9.5,f9.5)') x(i),Nn(x(i),a)
            y(i)=Nn(x(i),a)
        end do
        close(101)

    end subroutine newton_interpolation

    ! Cubic Spline Curve
    subroutine cubic_spline_curve()
        implicit none
        real :: h(N-1),mu(N-2),lambda(N-2),d(N-2),M(N-2)
        integer :: i

h=(/ (x_(i)-x_(i-1),i=2,N) /)
mu=(/ (h(i)/(h(i)+h(i+1)),i=1,N-2) /)
lambda=(/ (1-mu(i),i=1,N-2) /)
d=(/ (6*f_(i-1,i+1),i=2,N-1) /)

print *,d

    end subroutine cubic_spline_curve

end module interpolation

! ===============================================
program main
    use interpolation ! 使用差值模块
    implicit none

    ! 差值的原函数
    interface
        function f(x)
            real :: x,f
        end function f
    end interface

    integer :: i,N=15
    real :: x0(16),y0(16),x(101),y(101),r(101),y1(101)

    ! init x0 & y0
    x0=(/ (-5+10.0*i/N,i=0,N) /)
    y0=(/ (f(x0(i)),i=1,N+1) /)
    x=(/ (-5+10.0*i/100,i=0,100) /)
    y=0
    y1=0
    r=0

    print *
    call init(x0,y0)
    print *,'Set initail x='
    print '(f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5)',x0
    print *
    print *,'y='
    print '(f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5)',y0
    print *
    print *,'Lagrange interpolation'
    call lagrange_interpolation(x,y)
    call lagrange_interpolation_error_analysis(x,r)
    print '(5x,a9,5x,a9,5x,a9)','x','y','r'
    do i=1,101,10
        print '(5x,f9.5,5x,f9.5,5x,f9.5)',x(i),y(i),r(i)
    end do
    print *
    print *,'Write the data to file: data.txt'
    open(101,file="data.txt")
    write(101,'(f9.5,f9.5,f9.5)') (x(i),y(i),r(i),i=1,101)
    close(101)
    print *
    print *,'Newton interpolation'
    call newton_interpolation(x,y)
    print '(5x,a9,5x,a9)','x','y'
    do i=1,101,10
        print '(5x,f9.5,5x,f9.5)',x(i),y(i)
    end do
    print *
    print *,'Write the data to file: data.txt'
    print *
    print *,'Cubic spline interpolation'
    call cubic_spline_curve()
    print *

end program main

! ==================
function f(x)
    implicit none
    real :: x,f
    f=1.0/(1.0+x*x)
end function f
