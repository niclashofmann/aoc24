#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(pairs);

sub violates_rules {
    my $update = shift;
    my $rules = shift;
    
    for my $i (1..scalar @$update - 1) {
        for my $j (0..$i) {
            for my $rule (@$rules) {
                if ($rule->[0] eq $update->[$i] && $rule->[1] eq $update->[$j]) {
                    return 1;
                }
            }
        }
    }
    
    return 0;
}

sub fix_update {
    my $update = shift;
    my $rules = shift;
    
    for my $i (0..scalar @$update - 1) {
        for (my $j = scalar @$update - 1; $j > $i; --$j) {
            for my $rule (@$rules) {
                if ($rule->[0] eq $update->[$j] && $rule->[1] eq $update->[$i]) {
                    ($update->[$i], $update->[$j]) = ($update->[$j], $update->[$i]);
                    $j = scalar @$update;
                    last;
                }
            }
        }
    }
}

my $file = "input05.txt";
open my $data, '<', $file or die "Could not open '$file'!\n";

my @rules;
while (my $line = <$data>) {
    chomp $line;
    
    if ($line =~ /(\d+)\|(\d+)/) {
        push @rules, $1, $2;
    } else {
        last;
    }
}
@rules = pairs @rules;

my $sum1 = 0;
my $sum2 = 0;
while (my $line = <$data>) {
    chomp $line;
    
    if ($line =~ /\d+(,\d+)+/) {
        my @update = split /,/, $line;
        
        if (!violates_rules(\@update, \@rules)) {
            $sum1 += $update[$#update/2];
        } else {
            fix_update(\@update, \@rules);
            $sum2 += $update[$#update/2];
        }
    }
}

print "--- Part One ---\n";
print "$sum1\n";
print "\n";

print "--- Part Two ---\n";
print "$sum2\n";