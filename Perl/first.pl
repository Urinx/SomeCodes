#!/usr/bin/perl
print 'Hi \n haha';
print "Hi there!\n";

$i = 5;
$pie_flavor = 'apple';
$constitution = "We the People, etc.";

$count_report = "There are $i apples.";
print "The report is: $count_report\n";

$a = 5;
$b = $a + 10;
$c = $b * 10;
$a = $a - 1;

$a++;
$a += 10;
$a /= 2;
$b = int(1.23);

$a = "8";
$b = $a + "1"; # $b is 9
$c = $a . "1"; # $c is "81"

@lotto_numbers = (1,2,3,4,5,6);
@months = ("July", "August", "September");

print $months[0];
$months[2] = "Smarch";

$winter_months[0] = "December";

print $#months; # length of array - 1

%days_in_summer = ("July" => 31, "August" => 31, "September" => 30);
print $days_in_summer{"September"};
$days_in_summer{"February"} = 29;

@month_list = keys %days_in_summer;

for $i (1,2,3,4,5) {
   print "$i\n";
}

@one_to_ten = (1..10);
$top_limit = 25;
for $i (@one_to_ten, 15, 20 .. $top_limit) {
   print "$i\n";
}

for $i (keys %days_in_summer) {
   print "$i has $days_in_summer{$i} days.\n";
}
