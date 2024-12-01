#!/usr/bin/perl

use strict;
use warnings;

my $file = "input01.txt";
open my $data, '<', $file or die "Could not open '$file'!\n";

my @cola;
my @colb;
while (my $line = <$data>) {
	chomp $line;
	my ($a, $b) = split /\s+/, $line;
	push @cola, $a;
	push @colb, $b;
}

my @scola = sort @cola;
my @scolb = sort @colb;

my $sum1 = 0;
for my $i (0..$#scola) {
	$sum1 += abs($scola[$i] - $scolb[$i]);
}

print "--- Part One ---\n";
print "$sum1\n";
print "\n";

my $sum2 = 0;
for my $i (0..$#scola) {
	$sum2 += $scola[$i] * grep { $_ == $scola[$i] } @scolb;
}

print "--- Part Two ---\n";
print "$sum2\n";
