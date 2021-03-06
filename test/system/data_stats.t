#!/etc/bin/perl

use strict;
use warnings;
use File::Path 'rmtree';
use Test::More tests=>2;
use File::Copy 'cp';
use FindBin qw($Bin);
use lib "$Bin/.."; #location of includes.pm
use includes; #file with paths to PsN packages and $path variable definition

#black box testing of data class and progs that are not covered by other test files

my $model_dir = $includes::testfiledir;

my @commands = 
	(
	 get_command('data_stats') . " $model_dir/mox_simulated.csv",
	 get_command('data_stats') . " $model_dir/pheno.dta",
	 );

foreach my $command (@commands) {
	print "Running $command\n";
	my $rc = system($command);
	$rc = $rc >> 8;
	ok ($rc == 0, "$command, should run ok");
}

done_testing();
