program convert
!This example shows the use of integer and character variables.
implicit none
integer :: pounds,pence,total
character :: name*10
print *,'What is your name?'
read *,name
print *,'Hi ',name,'!Enter number of pounds and pence'
read *,pounds,pence
total=100*pounds+pence
print *,'the total money in pence is ',total
end