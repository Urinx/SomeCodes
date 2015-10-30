#!/usr/bin/perl

$r = \3;
print $$r,"\n";

@x = (1,2,3,4,8);
$s = \@x;
print $$s[3],"\n";
print scalar(@$s),"\n";

$x = [5,12,13];
print $x->[1],"\n";
print @$x,"\n";
$y = {name => "penelope", age => 105};
print $y->{age},"\n";
