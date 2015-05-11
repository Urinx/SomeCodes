program main

    interface

        function f(x)
            real :: f,x
        end function f

        function repeated_simpson_quadrature(f,a,b,h)
            real :: a,b,h
            real,external :: f
        end function repeated_simpson_quadrature

        function repeated_trapezoid_quadrature(f,a,b,h)
            real :: a,b,h
            real,external :: f
        end function repeated_trapezoid_quadrature

    end interface

    real :: a,b,h
    a=1.0
    b=5.0
    h=0.1

    print *
    print '(5x,a,5x,f4.1,a,f4.1,5x,a,f4.1)','f=sin(x)',a,'<= x <=',b,'h=',h
    print *
    print *,'Compute the integral...'
    print *
    print *,'Repeated Simpson Quadrature'
    print '(5x,a,f9.5)','Sm=',repeated_simpson_quadrature(f,a,b,h)
    print '(5x,a,f14.10)','Error=',(repeated_simpson_quadrature(f,a,b,h)-repeated_simpson_quadrature(f,a,b,2*h))/15
    print *
    print *,'Repeated Trapezoid Quadrature'
    print '(5x,a,f9.5)','Tn=',repeated_trapezoid_quadrature(f,a,b,h)
    print '(5x,a,f14.10)','Error=',(repeated_trapezoid_quadrature(f,a,b,h)-repeated_trapezoid_quadrature(f,a,b,2*h))/3
    print *

end program main

function f(x)
    implicit none
    real :: f,x
    f=sin(x)
end function f

function repeated_simpson_quadrature(f,a,b,h) result(Sm)
    implicit none
    real :: Sm,a,b,h,t1,t2
    real,external :: f
    integer :: n,m,i
    real,allocatable :: x(:)

    n=int((b-a)/h)
    m=n/2
    allocate(x(0:n))
    x=(/ (a+i*h,i=0,n) /)

    t1=sum( (/ (f(x(2*i+1)),i=0,m-1) /) )
    t2=sum( (/ (f(x(2*i)),i=1,m-1) /) )

    Sm=h/3*(f(a)+4*t1+2*t2+f(b))

end function repeated_simpson_quadrature

function repeated_trapezoid_quadrature(f,a,b,h) result(Tn)
    implicit none
    real :: Tn,a,b,h
    real,external :: f
    integer :: n,i
    real,allocatable :: x(:)

    n=int((b-a)/h)
    allocate(x(0:n))
    x=(/ (a+i*h,i=0,n) /)

    Tn=h/2*(f(a)+2*sum( (/ (f(x(i)),i=1,n-1) /) )+f(b))

end function repeated_trapezoid_quadrature