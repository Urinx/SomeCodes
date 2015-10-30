#!/usr/bin/perl

use Worker;

$w1 = Worker->newworker("Cassius",12,50000);
$w2 = Worker->newworker("Penelope",5,90000);

$w1->printworker;
$w2->printworker;

print $$w1{name},"\n";
print $w2->{id},"\n";
print "time of last update: $Worker::lastupdate\n";
