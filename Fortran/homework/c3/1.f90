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

        open(101,file="newton_data.txt")
        do i=1,101
            ! There is a bug if you comment the following code，I don't know why this would happen.
            write(101,'(f9.5,f9.5)') x(i),Nn(x(i),a)
            y(i)=Nn(x(i),a)
        end do
        close(101)

    end subroutine newton_interpolation

    ! 追赶法
    subroutine chasing(matrix,x)
        implicit none
        real :: matrix(:,:),x(:)
        real,allocatable :: u(:),q(:)
        integer :: i,m,n
        m=size(matrix(1,:))
        n=size(matrix(:,1))

        allocate(u(n-1),q(n))
        u(1)=matrix(1,2)/matrix(1,1)
        q(1)=matrix(1,m)/matrix(1,1)

        do i=2,n-1
            u(i)=matrix(i,i+1)/(matrix(i,i)-u(i-1)*matrix(i,i-1))
        end do

        do i=2,n
            q(i)=(matrix(i,m)-q(i-1)*matrix(i,i-1))/(matrix(i,i)-u(i-1)*matrix(i,i-1))
        end do

        x(n)=q(n)
        do i=n-1,1,-1
            x(i)=q(i)-u(i)*x(i+1)
        end do

        deallocate(u,q)
    end subroutine chasing

    ! Cubic Spline Curve
    subroutine cubic_spline_curve(x,y)
        implicit none
        real :: h(N-1),mu(N-2),lambda(N-2),d(N-2),M(N),mat(N-2,N-1),x(:),y(:)
        integer :: i,j

        h=(/ (x_(i)-x_(i-1),i=2,N) /)
        mu=(/ (h(i)/(h(i)+h(i+1)),i=1,N-2) /)
        lambda=(/ (1-mu(i),i=1,N-2) /)
        d=(/ (6*f_(i-1,i+1),i=2,N-1) /)
        M=0

        mat=0
        do i=1,N-2
            if (i /= 1) mat(i,i-1)=mu(i)
            mat(i,i)=2
            if (i /= N-2) mat(i,i+1)=lambda(i)
            mat(i,N-1)=d(i)
        end do
        call chasing(mat,M(2:N-1))

        y=0
        do i=1,size(x)
            do j=2,size(x_)
                if ( x(i)<=x_(j) ) exit
            end do
            y(i)=M(j-1)*(x_(j)-x(i))/(6*h(j-1))
            y(i)=y(i)+M(j)*(x(i)-x_(j-1))/(6*h(j-1))
            y(i)=y(i)+(y_(j-1)-M(j-1)*h(j-1)*h(j-1)/6)*(x_(j)-x(i))/h(j-1)
            y(i)=y(i)+(y_(j)-M(j)*h(j-1)*h(j-1)/6)*(x(i)-x_(j-1))/h(j-1)
        end do

        ! 输出一些基本信息到屏幕上
        print *
        print *,'h='
        print '(f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5)',h
        print *
        print *,'mu='
        print '(f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5)',mu
        print *
        print *,'lambda='
        print '(f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5)',lambda
        print *
        print *,'d='
        print '(f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5)',d
        print *
        print *,'Solve the matrix to get M'
        print '(f6.2,f6.2,f6.2,f6.2,f6.2,f6.2,f6.2,f6.2,f6.2,f6.2,f6.2,f6.2,f6.2,f6.2,f6.2)',(mat(i,:),i=1,N-2)
        print *
        print *,'M='
        print '(f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5,f9.5)',M
        print *

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
    real :: x0(16),y0(16),x(101),y(101),r(101)

    ! init x0 & y0
    x0=(/ (-5+10.0*i/N,i=0,N) /)
    y0=(/ (f(x0(i)),i=1,N+1) /)
    x=(/ (-5+10.0*i/100,i=0,100) /)
    y=0
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
    print '(5x,f9.5,5x,f9.5,5x,f9.5)',(x(i),y(i),r(i),i=1,size(x),10)
    print *
    print *,'Write the data to file: lagrange_data.txt'
    open(101,file="lagrange_data.txt")
    write(101,'(f9.5,f9.5,f9.5)') (x(i),y(i),r(i),i=1,size(x))
    close(101)
    print *
    print *,'Newton interpolation'
    call newton_interpolation(x,y)
    print '(5x,a9,5x,a9)','x','y'
    print '(5x,f9.5,5x,f9.5)',(x(i),y(i),i=1,size(x),10)
    print *
    print *,'Write the data to file: newton_data.txt'
    print *
    print *,'Cubic spline interpolation'
    call cubic_spline_curve(x,y)
    print *
    print '(5x,a9,5x,a9)','x','y'
    print '(5x,f9.5,5x,f9.5)',(x(i),y(i),i=1,size(x),10)
    print *
    print *,'Write the data to file: cubic_data.txt'
    open(101,file="cubic_data.txt")
    write(101,'(f9.5,f9.5)') (x(i),y(i),i=1,size(x))
    close(101)
    print *

end program main

! ==================
function f(x)
    implicit none
    real :: x,f
    f=1.0/(1.0+x*x)
end function f
