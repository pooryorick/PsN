#!/etc/bin/perl


use strict;
use warnings;
use File::Path 'rmtree';
use Test::More;
use FindBin qw($Bin);
use File::Copy 'cp';
use lib ".."; #location of includes.pm
use includes; #file with paths to PsN packages and $path variable definition

#black box testing of data class and progs that are not covered by other test files

our $dir = 'misc_test';
my $model_dir = "$Bin/../test_files";

my @commands = 
	($includes::path."mcmp -n_bootstrap=5 -full=$model_dir/pheno.mod -reduced=$model_dir/pheno.mod  -dir=$dir",
	 $includes::path."cdd -case_column=ID $model_dir/pheno5.mod -xv  -dir=$dir",
	 $includes::path."cdd $model_dir/mox1.mod -case_column=DGRP  -dir=$dir",
	 $includes::path."llp $model_dir/pheno.mod -thetas=2 -omegas=1,2  -dir=$dir",
	 $includes::path."vpc -samples=20 $model_dir/mox1.mod -stratif=AGE -no_of_strata=3 -auto_bin=12  -dir=$dir",
	 $includes::path."npc -samples=20 $model_dir/mox2.mod  -dir=$dir",
	 $includes::path."data_stats $model_dir/mox_simulated.csv",
	 $includes::path."data_stats $model_dir/pheno.dta",
	 $includes::path."frem -time_var=WT,NYHA -occ=VISI -param=PHI -invar=SEX -vpc $model_dir/mox_no_bov.mod -est=3  -dir=$dir",
	 $includes::path."execute $model_dir/pheno5.mod  -dir=$dir",
	 $includes::path."ebe_npde -samples=20 $model_dir/pheno_cond.mod  -dir=$dir");



my @needed=("$model_dir/scm/pheno_with_cov.mod",
			"$model_dir/scm/pheno_ch.csv",
			"$model_dir/config_xv_scm.scm",
			"$model_dir/mox1.mod",
			"$model_dir/scm_config.scm",
			"$model_dir/mox_simulated.csv"			
	);
my $bootdir='boot_xv_scm_test';
rmtree([ "./$bootdir" ]);

mkdir($bootdir);
foreach my $file (@needed){
	cp($file,"$bootdir/.");
}
chdir($bootdir);
my @scmcommands = 
	(
	 $includes::path."boot_scm -samples=2 scm_config.scm -dummy_cov=WGT -dir=$dir",
	 $includes::path."xv_scm -groups=3 -splits=2 -seed=12345 -max_step=2 -config=config_xv_scm.scm   -dir=$dir");
foreach my $command (@scmcommands){
	print "Running $command\n";
	my $rc = system($command);
	$rc = $rc >> 8;
	ok ($rc == 0, "$command, should run ok");
	rmtree([ "./$dir" ]);
}
chdir('..');
rmtree([ "./$bootdir" ]);

rmtree([ "./$dir" ]);
foreach my $command (@commands){
	print "Running $command\n";
	my $rc = system($command);
	$rc = $rc >> 8;
	ok ($rc == 0, "$command, should run ok");
	rmtree([ "./$dir" ]);
}
rmtree([ "./$dir" ]);


done_testing();
