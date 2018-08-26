#!/usr/bin/perl

use strict;
use warnings;
use utf8;
binmode(STDIN, ':encoding(utf8)');
binmode(STDOUT, ':encoding(utf8)');
binmode(STDERR, ':encoding(utf8)');

my $filename = "201807-deduplicated-english.csv";
open(my $FILE, '<:encoding(UTF-8)', $filename) or die "Cant open file $filename";

my %hash_count = ();
my %hash_valuesum = ();

while(my $line = <$FILE>) {
	chomp($line);

	# pair = (area code, price/坪)
	my @pair = split(',', $line);

	# drop the row if price value is missing or invalid
	if(@pair == 2) {
		$hash_count{$pair[0]}++;
		$hash_valuesum{$pair[0]} += $pair[1];
	} 
	#else {print "[Invalid row]: $line\n";}
}
close($FILE);

# traverse hash
foreach my $key (keys %hash_count) {
	#print "$key => $hash_count{$key}\n";
	my $mean = $hash_valuesum{$key}/$hash_count{$key};

	print "$key $hash_count{$key} $hash_valuesum{$key} $mean\n";
}
