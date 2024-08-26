#!perl
use 5.006;
use strict;
use warnings;
use Test::More;

our $VERSION = '0.06';

use GCC::Builtins qw/:all/;

my $res = ffsl(2);
my $expected = "2";
if( $expected =~ /^([+-]?)(?=\d|\.\d)\d*(\.\d*)?([Ee]([+-]?\d+))?$/ ){
	my $dif = abs($res-$expected);
	ok($dif<1e-09, "called ffsl(2) returned ($res) and expected ($expected) values differ ($dif) by less than 1e-09.");
} else {
	is(lc($res), lc($expected), "called ffsl(2) returned ($res) and expected ($expected) values are identical.");
}
diag("copy-this-expected-value 'ffsl' => '$res',");

done_testing();
