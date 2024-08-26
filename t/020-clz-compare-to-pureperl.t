#!perl
use 5.006;
use strict;
use warnings;
use Test::More;

our $VERSION = '0.06'; 

use GCC::Builtins qw/clz ffs/;


my $z = 17;
#diag ffs($z); # find first set
my $expected = 27;
my $res = clz($z);
is($res, $expected, "clz($z) : result is $res, expected $expected");
my $res_pp = clz_correct_for_clz_coldr3ality( clz_coldr3ality($z) );
$expected = 0x80000000 >> ($res+2);
is($res_pp, $expected, "clz_coldr3ality($z) : result is $res_pp, expected $expected");

done_testing();

sub clz_correct_for_clz_coldr3ality {
	my $z = shift;
	# this returns number of leading zeros (to the left of MSSB)
	my $m = clz($z);
	# he needs 1 bit set right of the MSSB
	# this is ok:
	#$m = 0x80000000 >> ($m+1);
	# this he suggests:
	$m = 1<<( 31-( $m +1) );
	return $m;
}
sub clz_coldr3ality {
	my $z = shift;

	my $m=-4294967296&$z? -281474976710656&$z? -72057594037927936&$z?
   -1152921504606846976&$z? -4611686018427387904&$z? -9223372036854775808&$z?
                  4611686018427387904:   2305843009213693952
    : -2305843009213693952&$z?
                  1152921504606846976:   576460752303423488
   : -288230376151711744&$z? -576460752303423488&$z?
                  288230376151711744:    144115188075855872
    : -144115188075855872&$z?
                  72057594037927936:     36028797018963968
  : -4503599627370496&$z? -18014398509481984&$z?   -36028797018963968&$z?
                  18014398509481984:     9007199254740992
    : -9007199254740992&$z?
                  4503599627370496:      2251799813685248
   : -1125899906842624&$z? -2251799813685248&$z?
                  1125899906842624:      562949953421312
    : -562949953421312&$z?
                  281474976710656:       140737488355328
 : -1099511627776&$z? -17592186044416&$z? -70368744177664&$z? -140737488355328&$z?
                  70368744177664:        35184372088832
    : -35184372088832&$z?
                  17592186044416:        8796093022208
   : -4398046511104&$z? -8796093022208&$z?
                  4398046511104:         2199023255552
    : -2199023255552&$z?
                  1099511627776:         549755813888
  : -68719476736&$z? -274877906944&$z? -549755813888&$z?
                  274877906944:          137438953472
    : -137438953472&$z?
                  68719476736:           34359738368
   : -17179869184&$z? -34359738368&$z?
                  17179869184:           8589934592
    : -8589934592&$z?
                  4294967296:            2147483648
: -65536&$z? -16777216&$z? -268435456&$z? -1073741824&$z? -2147483648&$z?
                  1073741824:            536870912
    : -536870912&$z?
                  268435456:             134217728
   : -67108864&$z? -134217728&$z?
                  67108864:              33554432
    : -33554432&$z?
                  16777216:              8388608
  : -1048576&$z? -4194304&$z? -8388608&$z?
                  4194304:               2097152
    : -2097152&$z?
                  1048576:               524288
   : -262144&$z? -524288&$z?
                  262144:                131072
    : -131072&$z?
                  65536:                 32768
 : -256&$z? -4096&$z? -16384&$z? -32768&$z?
                  16384:                 8192
    : -8192&$z?   4096:                  2048
   : -1024&$z? -2048&$z?
                  1024:                  512
    : -512&$z?    256:                   128
  : -16&$z? -64&$z? -128&$z?
                  64:                    32
    : -32&$z?     16:                    8
   : -4&$z? -8&$z?
                  4:                     2
    :             2                      ;

	return $m;
}