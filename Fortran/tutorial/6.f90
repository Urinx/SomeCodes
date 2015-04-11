program test
implicit none
!uuse of a simple menu
real :: x,y,answer
integer :: choice
!set up the menu - the user may enter 1,2 or 3
print *,'Choose an option'
print *,'1 Multiply'
print *,'2 Divide'
print *,'3 Add'
read *,choice
x=3.4
y=2.9
!the following line has 2 consecutive
!equals signs - (no spaces in between)
if (choice == 1) then
	answer=x*y
end if

if (choice == 2) then
	answer=x/y
end if

if (choice == 3) then
	answer=x+y
end if

print *,'result = ',answer
end