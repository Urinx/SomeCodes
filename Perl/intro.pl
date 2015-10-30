#!/usr/bin/perl

$var = "world.";
print "Hello, $var\n";
print 'Hello $var\n';
print("Hello, world\n");

$var_scalar = 1;
print $var_scalar;
print "The scalar's value is ",$var_scalar,"\n";

@var_array = (1,2,3,"a","b","c");
@var_array = qw(1 2 3 a b c);
@var_array = qw/1 2 3 a b c/;
print "The 2nd elm of var_array is $var_array[1]\n";
print @var_array[0,2],"\n";
print @var_array[0..3],"\n";

%var_hash = (a => "Apple", b => "Blizzard");
print "One elm of var_hash is $var_hash{\"b\"}\n";
my $allKeys = keys %var_hash;
my @allValues = values %var_hash;

# 常用内建变量
# $_ 默认变量
# @_ 默认数组变量，保存传递给子程序的所有参数
# $! 当前错误信息
# $0 当前脚本的文件名
# $$ 当前脚本的进程号
# @ARGV 命令行参数列表

print "abc"x3;
print "\n";

# 建议开头加上
use strict;
use warnings;

my $isOK = 1;
if ($isOK) {
   print "OK\n";
} else {
   print "Ooops...\n";
}
print "OK\n" if $isOK;

my $count = 10;
while ($count > 0) {
   print "while...$count\n";
   $count--;
}

my @array = (1,2,3,"A");
foreach my $elm (@array) {
   print $elm,"\n";
}

my $file2open = "./intro.pl";
my $fileHandle;
open($fileHandle,"<$file2open");
foreach (<$fileHandle>){
   print $_;
}

open($fileHandle,">./1.txt");
print $fileHandle "abc";

open($fileHandle,">>./1.txt");
print $fileHandle "def";
close($fileHandle);

sub subFunc1 {
   print "\nsubroutine 1\n";
}

sub subFunc2 {
   print "subroutine 2\n";
   return "i like Perl.\n";
}

sub subFunc3 {
   my ($param1,$param2) = @_;
   print $param1,$param2,"\n";
}

subFunc1();
&subFunc1;
print subFunc2();
subFunc3("Ooops...",123);

my $re_test = "Google";
if ($re_test =~ /oo/) {
   print "Bingo!\n";
}
# replace
if ($re_test = ~ s/oo/xx/) {
   print $re_test,"\n";
}

my $re_test2 = "FacebOok";
if ($re_test2 =~ /oo/i) {
   print "Bingo!\n";
}
