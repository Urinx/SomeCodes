#!/usr/bin/perl

open(INFILE, $ARGV[0]);

$line_count = 0;
$word_count = 0;

while ($line = <INFILE>) {
   $line_count++;
   @words_on_this_line = split(" ", $line);
   $word_count += scalar(@words_on_this_line);
}

print "the file contains ",$line_count," lines and ",$word_count," words.\n";
