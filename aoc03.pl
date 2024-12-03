#!/usr/bin/perl

use strict;
use warnings;

my $file = "input03.txt";
open my $data, '<', $file or die "Could not open '$file'!\n";

chomp(my @src = <$data>);

my $sum1 = 0;
for my $line (@src) {
	while ($line =~ /mul\((\d+),(\d+)\)/g) {
		$sum1 += $1 * $2;
	}
}

print "--- Part One ---\n";
print "$sum1\n";
print "\n";


my $sum2 = 0;
my $disabled = 0;
for my $line (@src) {
	if ($disabled) {
		$line =~ s/(.*?)do\(\)//;
	}
	$line =~ s/don't\(\).*?do\(\)//g;
	$disabled = $line =~ s/don't\(\).*?$//;
	while ($line =~ /mul\((\d+),(\d+)\)/g) {
		$sum2 += $1 * $2;
	}
}

print "--- Part Two ---\n";
print "$sum2\n";