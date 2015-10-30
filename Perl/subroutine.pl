#!/usr/bin/perl

$x = $ARGV[0];
$y = $ARGV[1];

$z = min($x,$y);
print $z,"\n";

sub min {
   if ($_[0] < $_[1]) { return $_[0]; }
   else { return $_[1]; }
}

($mn,$mx) = minmax($x,$y);
print $mn," ",$mx,"\n";

sub minmax {
   $s = shift @_;
   $t = shift @_;
   # or ($s,$t) = @_
   if ($s < $t) {return ($s,$t);}
   else {return ($t,$s);}
}

sub x {
   print "this is x\n";
}

sub y {
   print "this is y\n";
}

sub w {
   $r = shift;
   &$r();
}

w \&x;
w \&y;
