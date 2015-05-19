module Double_Pendulum
    implicit none
    private
    public :: init,test
    real :: m1,m2,l1,l2,xo,yo,g,tau
    integer :: n

contains

    subroutine init(m1_,m2_,l1_,l2_)
        implicit none
        real :: m1_,m2_,l1_,l2_
        m1=m1_ !球1质量
        m2=m2_ !球2质量
        l1=l1_ !杆1长度
        l2=l2_ !杆2长度
        !原点坐标
        xo=0.0
        yo=0.0
        g=0.005 !重力加速度
        tau=1.0
        n=3
    end subroutine init

    ! Lagrange equations
    function L_p1(p1,p2,w1,w2)
        implicit none
        real :: L_p1,p1,p2,w1,w2
        L_p1=w1
    end function L_p1

    function L_p2(p1,p2,w1,w2)
        implicit none
        real :: L_p2,p1,p2,w1,w2
        L_p2=w2
    end function L_p2

    function L_w1(p1,p2,w1,w2)
        implicit none
        real :: L_w1,p1,p2,w1,w2,tmp
        tmp=l1*(2*m1+m2-m2*cos(2*p2-2*p1))
        L_w1=(-g*(2*m1+m2)*sin(p1)+m2*g*sin(p1-2*p2)-2*sin(p1-p2)*m2*(w2*w2*l2+w1*w1*l1*cos(p1-p2)))/tmp
    end function L_w1

    function L_w2(p1,p2,w1,w2)
        implicit none
        real :: L_w2,p1,p2,w1,w2
        L_w2=(2*sin(p1-p2)*(w1*w1*l1*(m1+m2)+g*(m1+m2)*cos(p1)+w2*w2*l2*m2*cos(p1-p2)))/(l2*(2*m1+m2-m2*cos(2*p2-2*p1)))
    end function L_w2

    ! Hamilton Equations
    function H_a1(a1,a2,p1,p2)
        implicit none
        real :: H_a1,a1,a2,p1,p2
        H_a1=(p1*l2-p2*l1*cos(a1-a2))/(l1*l1*l2*(m1+m2*sin(a1-a2)*sin(a1-a2)))
    end function H_a1

    function H_a2(a1,a2,p1,p2)
        implicit none
        real :: H_a2,a1,a2,p1,p2
        H_a2=(p2*(m1+m2)*l1-p1*m2*l2*cos(a1-a2))/(m2*l1*l2*l2*(m1+m2*sin(a1-a2)*sin(a1-a2)))
    end function H_a2

    function H_p1(a1,a2,p1,p2)
        implicit none
        real :: H_p1,a1,a2,p1,p2,A_1,A_2,tmp
        A_1=(p1*p2*sin(a1-a2))/(l1*l2*(m1+m2*sin(a1-a2)*sin(a1-a2)))
        tmp=2*l1*l1*l2*l2*(m1+m2*sin(a1-a2)*sin(a1-a2))*(m1+m2*sin(a1-a2)*sin(a1-a2))
        A_2=(p1*p1*m2*l2*l2-2*p1*p2*m2*l1*l2*cos(a1-a2)+p2*p2*(m1+m2)*l1*l1)*sin(2*a1-2*a2)/tmp
        H_p1=-(m1+m2)*g*l1*sin(a1)-A_1+A_2
    end function H_p1

    function H_p2(a1,a2,p1,p2)
        implicit none
        real :: H_p2,a1,a2,p1,p2,A_1,A_2,tmp
        A_1=(p1*p2*sin(a1-a2))/(l1*l2*(m1+m2*sin(a1-a2)*sin(a1-a2)))
        tmp=2*l1*l1*l2*l2*(m1+m2*sin(a1-a2)*sin(a1-a2))*(m1+m2*sin(a1-a2)*sin(a1-a2))
        A_2=(p1*p1*m2*l2*l2-2*p1*p2*m2*l1*l2*cos(a1-a2)+p2*p2*(m1+m2)*l1*l1)*sin(2*a1-2*a2)/tmp
        H_p2=-m2*g*l2*sin(a2)+A_1-A_2
    end function H_p2

    function Hamiltonian(a1,a2,p1,p2)
        implicit none
        real :: Hamiltonian,a1,a2,p1,p2,T,V
        T=(p1*p1*m2*l2*l2-2*p1*p2*m2*l1*l2*cos(a1-a2)+p2*p2*(m1+m2)*l1*l1)/(2*m2*l1*l1*l2*l2*(m1+m2*sin(a1-a2)*sin(a1-a2)))
        V=-(m1+m2)*g*l1*cos(a1)-m2*g*l2*cos(a2)
        Hamiltonian=T+V
    end function Hamiltonian

    ! Four Order Runge-Kutta Method
    function rk4(z,f1,f2,f3,f4)
        implicit none
        real :: f1,f2,f3,f4
        real :: rk4(0:3),z(0:3),K1(0:3),K2(0:3),K3(0:3),K4(0:3),a,b,c,d
        integer :: i
        a=z(0)
        b=z(1)
        c=z(2)
        d=z(3)
        do i=1,n
            K1(0)=f1(a,b,c,d)*tau
            K1(1)=f2(a,b,c,d)*tau
            K1(2)=f3(a,b,c,d)*tau
            K1(3)=f4(a,b,c,d)*tau
            K2(0)=f1(a+K1(0)/2,b+K1(1)/2,c+K1(2)/2,d+K1(3)/2)*tau
            K2(1)=f2(a+K1(0)/2,b+K1(1)/2,c+K1(2)/2,d+K1(3)/2)*tau
            K2(2)=f3(a+K1(0)/2,b+K1(1)/2,c+K1(2)/2,d+K1(3)/2)*tau
            K2(3)=f4(a+K1(0)/2,b+K1(1)/2,c+K1(2)/2,d+K1(3)/2)*tau
            K3(0)=f1(a+K2(0)/2,b+K2(1)/2,c+K2(2)/2,d+K2(3)/2)*tau
            K3(1)=f2(a+K2(0)/2,b+K2(1)/2,c+K2(2)/2,d+K2(3)/2)*tau
            K3(2)=f3(a+K2(0)/2,b+K2(1)/2,c+K2(2)/2,d+K2(3)/2)*tau
            K3(3)=f4(a+K2(0)/2,b+K2(1)/2,c+K2(2)/2,d+K2(3)/2)*tau
            K4(0)=f1(a+K3(0),b+K3(1),c+K3(2),d+K3(3))*tau
            K4(1)=f2(a+K3(0),b+K3(1),c+K3(2),d+K3(3))*tau
            K4(2)=f3(a+K3(0),b+K3(1),c+K3(2),d+K3(3))*tau
            K4(3)=f4(a+K3(0),b+K3(1),c+K3(2),d+K3(3))*tau
            a=a+(K1(0)+2*K2(0)+2*K3(0)+K4(0))/6
            b=b+(K1(1)+2*K2(1)+2*K3(1)+K4(1))/6
            c=c+(K1(2)+2*K2(2)+2*K3(2)+K4(2))/6
            d=d+(K1(3)+2*K2(3)+2*K3(3)+K4(3))/6
        end do
        rk4=(/ a,b,c,d /)
    end function rk4

    ! 角度转弧度
    function angle2rad(a) result(r)
        implicit none
        real :: r,a
        r=a/180.0*3.1415926
    end function angle2rad

    ! 弧度转角度
    function rad2angle(r) result(a)
        implicit none
        real :: r,a
        a=r/3.1415926*180.0
    end function rad2angle

    ! 获取小球位置
    function get_position(a1,a2) result(p)
        implicit none
        real :: a1,a2,p(0:3)
        !球1坐标
        p(0)=xo+l1*sin(a1)
        p(1)=yo-l1*cos(a1)
        !球2坐标
        p(2)=p(0)+l2*sin(a2)
        p(3)=p(1)-l2*cos(a2)
    end function get_position

    subroutine test()
        implicit none
        real :: z(0:3),p(0:3)
        integer :: i
        z=(/ angle2rad(90.0),angle2rad(90.0),0.0,0.0 /)

        open(101,file='data.txt')
        print '(5x,a,12x,a,10x,a)','a1','a2','H'
        do i=1,1000
            z=rk4(z,H_a1,H_a2,H_p1,H_p2)
            !z=rk4(z,L_p1,L_p2,L_w1,L_w2)
            p=get_position(z(0),z(1))
            write(101,'(f7.3,f7.3,i4,f10.6)') p(2),p(3),i,Hamiltonian(z(0),z(1),z(2),z(3))
            
            if (i<10) then
                print '(f9.6,5x,f10.6,5x,f9.6)',z(0),z(1),Hamiltonian(z(0),z(1),z(2),z(3))
            else if (i==990) then
                print *,'...'
            else if (i>990) then
                print '(f9.6,5x,f10.6,5x,f9.6)',z(0),z(1),Hamiltonian(z(0),z(1),z(2),z(3))
            end if
        end do
        close(101)
        print *
        print *,'Save data in data.txt'
    end subroutine test

end module Double_Pendulum

program main
    use Double_Pendulum
    implicit none

    call init(1.0,1.0,1.0,1.0)
    call test()
end program main