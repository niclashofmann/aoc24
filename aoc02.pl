#!/usr/bin/perl

use strict;
use warnings;

sub increasing {
	my @report = @_;
	
	for my $i (1..$#report) {
		my $diff = $report[$i] - $report[$i-1];
		if ($diff > 3 or $diff <= 0) {
			return 0;
		}
	}
	
	return 1;
}

sub decreasing {
	return increasing(reverse @_);
}

my $file = "input02.txt";
open my $data, '<', $file or die "Could not open '$file'!\n";

my @reports;
while (my $line = <$data>) {
	chomp $line;
	my @report = split / /, $line;
	push @reports, \@report;
}

my $sum1 = 0;
for my $report (@reports) {
	if (increasing(@$report) or decreasing(@$report)) {
		++$sum1;
	}
}

print "--- Part One ---\n";
print "$sum1\n";
print "\n";

my $sum2 = 0;
for my $report (@reports) {
	if (increasing(@$report) or decreasing(@$report)) {
		++$sum2;
		next;
	}
	
	for my $i (0..$#$report) {
		my @sreport = (@$report[0..$i-1], @$report[$i+1..$#$report]);
		if (increasing(@sreport) or decreasing(@sreport)) {
			++$sum2;
			last;
		}
	}
}

print "--- Part Two ---\n";
print "$sum2\n";