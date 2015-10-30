#!/usr/bin/perl

package Worker;

@workers = ();
$lastupdate = undef;

sub newworker {
   my $classname = shift;
   my ($nm,$id,$slry) = @_;
   my $r = {name => $nm, id => $id, salary => $slry};
   push(@workers,$r);
   $lastupdate = localtime();
   bless($r,$classname);
   return $r;
}

sub printworker {
   my $r = shift;
   print "employee number $r->{id}, named $r->{name}, has a salary of $r->{salary}\n";
}

1;
