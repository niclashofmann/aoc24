#!/usr/bin/perl

use strict;
use warnings;

my $file = "input04.txt";
open my $data, '<', $file or die "Could not open '$file'!\n";

my @lines;
while (my $line = <$data>) {
	chomp $line;
	push @lines, $line;
}

my $sum1 = 0;
for my $line (@lines) {
    while ($line =~ m/XMAS/g) {
	++$sum1;
    }
    while ($line =~ m/SAMX/g) {
	++$sum1;
    }
}

for my $i (0..length($lines[0])) {
    my $col = join "", map { substr $_, $i, 1 } @lines;
    while ($col =~ m/XMAS/g) {
	++$sum1;
    }
    while ($col =~ m/SAMX/g) {
	++$sum1;
    }
}

for my $i (0..$#lines-3) {
    for my $j (0..length($lines[0])-3) {
	if (substr($lines[$i], $j, 1) =~ m/X/
	    && substr($lines[$i+1], $j+1, 1) =~ m/M/
	    && substr($lines[$i+2], $j+2, 1) =~ m/A/
	    && substr($lines[$i+3], $j+3, 1) =~ m/S/) {
	    ++$sum1;
	}
	if (substr($lines[$i], $j, 1) =~ m/S/
	    && substr($lines[$i+1], $j+1, 1) =~ m/A/
	    && substr($lines[$i+2], $j+2, 1) =~ m/M/
	    && substr($lines[$i+3], $j+3, 1) =~ m/X/) {
	    ++$sum1;
	}
    }
}

for my $i (3..$#lines) {
    for my $j (0..length($lines[0])-3) {
	if (substr($lines[$i], $j, 1) =~ m/X/
	    && substr($lines[$i-1], $j+1, 1) =~ m/M/
	    && substr($lines[$i-2], $j+2, 1) =~ m/A/
	    && substr($lines[$i-3], $j+3, 1) =~ m/S/) {
	    ++$sum1;
	}
	if (substr($lines[$i], $j, 1) =~ m/S/
	    && substr($lines[$i-1], $j+1, 1) =~ m/A/
	    && substr($lines[$i-2], $j+2, 1) =~ m/M/
	    && substr($lines[$i-3], $j+3, 1) =~ m/X/) {
	    ++$sum1;
	}
    }
}

print "--- Part One ---\n";
print "$sum1\n";
print "\n";

my $sum2 = 0;
for my $i (1..$#lines-1) {
    for my $j (1..length($lines[0])-1) {
	if (substr($lines[$i], $j, 1) =~ m/A/) {
	    my $tlr = substr($lines[$i-1], $j-1, 1) . substr($lines[$i+1], $j+1, 1);
	    my $blr = substr($lines[$i+1], $j-1, 1) . substr($lines[$i-1], $j+1, 1);
	    if ($tlr =~ m/MS|SM/ && $blr =~ m/MS|SM/) {
		++$sum2;
	    }
	}
    }
}

print "--- Part Two ---\n";
print "$sum2\n";
