#!/usr/bin/perl

use strict;
use warnings;
use Test::More;
use FindBin qw($Bin);
use lib "$Bin/.."; #location of includes.pm
use includes; #file with paths to PsN packages

use nmtablefile;

my $dir = $includes::testfiledir;

# parse nmtable
my $t = nmtablefile->new(filename => "$dir/output/nm73/pheno5.ext");
is (scalar(@{$t->tables}), 1, "nmtablefile number of tables");
is ($t->tables->[0]->table_number, 1, "nmtablefile table_number");
is ($t->tables->[0]->method, "First Order", "nmtablefile method");
is ($t->tables->[0]->goal_function, "MINIMUM VALUE OF OBJECTIVE FUNCTION", "nmtablefile goal function");
is ($t->tables->[0]->problem, "1", "nmtablefile goal function");
is ($t->tables->[0]->subproblem, "0", "nmtablefile subproblem");
is ($t->tables->[0]->superproblem1, "0", "nmtablefile superproblem1");
is ($t->tables->[0]->iteration1, "0", "nmtablefile iteration1");
is ($t->tables->[0]->superproblem2, "0", "nmtablefile superproblem2");
is ($t->tables->[0]->iteration2, "0", "nmtablefile iteration2");
is_deeply ($t->tables->[0]->header, { "ITERATION" => 0, "THETA1" => 1, "THETA2" => 2, "SIGMA(1,1)" => 3, "OMEGA(1,1)" => 4, "OMEGA(2,1)" => 5, "OMEGA(2,2)" => 6, "OBJ" => 7 }, "nmtablefile header"); 
is_deeply ($t->tables->[0]->columns, [ [ '0', '16', '-1000000000', '-1000000004' ],
        [ '1.05000E-02', '4.77584E-03', '4.77584E-03', '0.00000E+00' ],
        [ '1.05000E+00', '1.41760E+00', '1.41760E+00', '0.00000E+00' ],
        [ '4.00000E-02', '7.38437E-03', '7.38437E-03', '8.59324E-02' ],
        [ '4.00000E-01', '1.82661E-01', '1.82661E-01', '4.27388E-01' ],
        [ '0.00000E+00', '0.00000E+00', '0.00000E+00', '0.00000E+00' ],
        [ '2.50000E-01', '8.25286E-02', '8.25286E-02', '2.87278E-01' ],
        [ '68.115784446648021', '51.680929191096922', '51.680929191096922', '0.0000000000000000' ]
    ], "nmtablefile columns");
is_deeply ($t->table_lookup,{1=> 0},'nmtable table index');
is_deeply ($t->problem_lookup->{1},{0 => 0},'nmtable problem index');

		   
$t = nmtablefile->new(filename => "$dir/output/nm73/pheno5.ext", is_ext_file => 1);
is (scalar(@{$t->tables}), 1, "nmtablefile is_ext_file number of tables");
is ($t->tables->[0]->table_number, 1, "nmtablefile is_ext_file table_number");
is ($t->tables->[0]->method, "First Order", "nmtablefile is_ext_file method");
is ($t->tables->[0]->goal_function, "MINIMUM VALUE OF OBJECTIVE FUNCTION", "nmtablefile is_ext_file goal function");
is ($t->tables->[0]->problem, "1", "nmtablefile is_ext_file goal function");
is ($t->tables->[0]->subproblem, "0", "nmtablefile is_ext_file subproblem");
is ($t->tables->[0]->superproblem1, "0", "nmtablefile is_ext_file superproblem1");
is ($t->tables->[0]->iteration1, "0", "nmtablefile is_ext_file iteration1");
is ($t->tables->[0]->superproblem2, "0", "nmtablefile is_ext_file superproblem2");
is ($t->tables->[0]->iteration2, "0", "nmtablefile is_ext_file iteration2");
is_deeply ($t->tables->[0]->header, { "ITERATION" => 0, "THETA1" => 1, "THETA2" => 2, "SIGMA(1,1)" => 3, "OMEGA(1,1)" => 4, "OMEGA(2,1)" => 5, "OMEGA(2,2)" => 6, "OBJ" => 7 }, "nmtablefile is_ext_file header"); 
is_deeply ($t->tables->[0]->columns, [ [ '-1000000000', '-1000000004' ],
        [ '4.77584E-03', '0.00000E+00' ],
        [ '1.41760E+00', '0.00000E+00' ],
        [ '7.38437E-03', '8.59324E-02' ],
        [ '1.82661E-01', '4.27388E-01' ],
        [ '0.00000E+00', '0.00000E+00' ],
        [ '8.25286E-02', '2.87278E-01' ],
        [ '51.680929191096922', '0.0000000000000000' ]
    ], "nmtablefile is_ext_file columns");

my $t = nmtablefile->new(filename => "$dir/sdtab");
is (scalar(@{$t->tables}), 2, "nmtablefile stdtab number of tables");
is ($t->tables->[0]->table_number, 2, "nmtablefile sdtab table_number");
is ($t->tables->[0]->method, undef, "nmtablefile sdtab method");
is ($t->tables->[0]->goal_function, undef, "nmtablefile sdtab goal function");
is ($t->tables->[0]->problem, undef, "nmtablefile sdtab goal function");
is ($t->tables->[0]->subproblem, undef, "nmtablefile sdtab subproblem");
is ($t->tables->[0]->superproblem1, undef, "nmtablefile sdtab superproblem1");
is ($t->tables->[0]->iteration1, undef, "nmtablefile sdtab iteration1");
is ($t->tables->[0]->superproblem2, undef, "nmtablefile sdtab superproblem2");
is ($t->tables->[0]->iteration2, undef, "nmtablefile sdtab iteration2");
is_deeply ($t->tables->[0]->header, { "ID" => 0, "TIME" => 1, "DV" => 2, "PRED" => 3, "IPRED" => 4 }, "nmtablefile sdtab header"); 
is_deeply ($t->tables->[0]->columns, [ [ '1.0000E+00', '1.0000E+00' ],
                                  [ '0.0000E+00', '2.0000E+00' ],
                                  [ '0.0000E+00', '1.7300E+01' ],
                                  [ '1.8707E+01', '1.8552E+01' ],
                                  [ '1.7806E+01', '1.7675E+01' ] ], "nmtable sdtab columns");
is ($t->tables->[1]->table_number, 2, "nmtablefile sdtab table_number");
is ($t->tables->[1]->method, undef, "nmtablefile sdtab method");
is ($t->tables->[1]->goal_function, undef, "nmtablefile sdtab 2  goal function");
is ($t->tables->[1]->problem, undef, "nmtablefile sdtab 2 goal function");
is ($t->tables->[1]->subproblem, undef, "nmtablefile sdtab 2 subproblem");
is ($t->tables->[1]->superproblem1, undef, "nmtablefile sdtab 2 superproblem1");
is ($t->tables->[1]->iteration1, undef, "nmtablefile sdtab 2 iteration1");
is ($t->tables->[1]->superproblem2, undef, "nmtablefile sdtab 2 superproblem2");
is ($t->tables->[1]->iteration2, undef, "nmtablefile sdtab 2 iteration2");
is_deeply ($t->tables->[1]->header, { "ID" => 0, "TIME" => 1, "DV" => 2, "PRED" => 3, "IPRED" => 4 }, "nmtablefile sdtab 2 header");

is_deeply ($t->tables->[1]->columns, [ [ '5.9000E+01', '5.9000E+01' ],
                                  [ '1.4480E+02', '1.4680E+02' ],
                                  [ '0.0000E+00', '4.0200E+01' ],
                                  [ '3.0093E+01', '2.9844E+01' ],
                                  [ '4.0432E+01', '4.0089E+01' ] ], "nmtable sdtab 2 column");
 
my $t = nmtablefile->new(filename => "$dir/output/nm73/anneal2_V7_30_beta.ext");
is (scalar(@{$t->tables}), 3, "nmtablefile anneal number of tables");
is_deeply ($t->table_lookup,{0 => 0, 1=> 1, 2=> 2},'nmtable table index 2');
is_deeply ($t->problem_lookup->{1},{0 => 2},'nmtable problem index 2');
is ($t->tables->[0]->method, "Chain Method Processing", "nmtablefile anneal1 method");
is ($t->tables->[1]->method, "Stochastic Approximation Expectation-Maximization", "nmtablefile anneal2 method");
is ($t->tables->[2]->method, "Objective Function Evaluation by Importance Sampling", "nmtablefile anneal3 method");
is ($t->tables->[0]->goal_function, "", "nmtablefile anneal1 function");
is ($t->tables->[1]->goal_function,  "FINAL VALUE OF LIKELIHOOD FUNCTION", "nmtablefile sdtab anneal2 function");
is ($t->tables->[2]->goal_function, "FINAL VALUE OF OBJECTIVE FUNCTION" , "nmtablefile sdtab anneal3 function");
is ($t->tables->[0]->header, undef , "nmtablefile anneal0 header");
is ($t->tables->[1]->header->{"ITERATION"}, 0 , "nmtablefile anneal1 header");
is ($t->tables->[1]->header->{"THETA4"}, 4 , "nmtablefile anneal1 header");
is ($t->tables->[1]->header->{"SAEMOBJ"}, 16 , "nmtablefile anneal1 header");
is ($t->tables->[2]->header->{"ITERATION"}, 0 , "nmtablefile anneal2 header");
is ($t->tables->[2]->header->{"THETA4"}, 4 , "nmtablefile anneal2 header");
is ($t->tables->[1]->header->{"SAEMOBJ"}, 16 , "nmtablefile anneal1 header");
is_deeply ($t->tables->[0]->columns, [], "nmtablefile anneal0 columns");
is ($t->tables->[1]->columns->[2]->[0], "6.29253E+00", "nmtablefile anneal1 columns");
is ($t->tables->[2]->columns->[3]->[1], "1.05572E+00", "nmtablefile anneal1 columns");

my $t = nmtablefile->new(filename => "$dir/output/multPROB/multEST/withSIM/multprobmix_nm730.ext", is_ext_file => 1);
is (scalar(@{$t->tables}), 13, "nmtablefile multprob number of tables 2");
is_deeply ($t->table_lookup,{1 => 0, 2=> 1, 3=> 2,4 =>3,5 =>4,6 =>5,7 =>6,8 =>7,9 =>8, 10=>9, 11=>10,12 =>11,13 => 12},'nmtable table index 3');
is_deeply ($t->problem_lookup->{1},{0 => 0},'nmtable problem index 3');
is_deeply ($t->problem_lookup->{3},{0 => 2},'nmtable problem index 4');
is_deeply ($t->problem_lookup->{4},{0 => 3},'nmtable problem index 5');
is_deeply ($t->problem_lookup->{5},{1 => 5,2=>7,3=>9},'nmtable problem index 6');
is_deeply ($t->problem_lookup->{6},{0 => 11},'nmtable problem index 7');
is_deeply ($t->problem_lookup->{7},{0 => 12},'nmtable problem index 8');


is($t->get_table(index => -1)->method,'First Order Conditional Estimation (Evaluation)','get table index');
is($t->get_table(number => 11)->method,'First Order','get table number');
is($t->get_table(problem => 5,subproblem => 3)->method,'First Order Conditional Estimation','get table prob subprob');
is($t->get_table(number => 20),undef,'get table undef');

my $t = nmtablefile->new(filename => "$dir/output/multPROB/multEST/withSIM/multprobmix_nm710.ext", is_ext_file => 1);
is($t->get_table(index => -2)->method,'First Order','get table index nm710');
is($t->get_table(number => 7)->method,'First Order Conditional Estimation','get table number nm710');

my $t = nmtablefile->new(filename => "$dir/output/multPROB/multEST/withSIM/multprobmix_nm712.ext", is_ext_file => 1);
is($t->get_table(index => -1)->method,'First Order Conditional Estimation (Evaluation)','get table index nm712');
is($t->get_table(number => 9)->method,'First Order (Evaluation)','get table number nm712');

my $t = nmtablefile->new(filename => "$dir/output/multPROB/multEST/withSIM/multprobmix_nm720.ext", is_ext_file => 1);
is($t->get_table(index => -2)->method,'First Order Conditional Estimation','get table index nm720');
is($t->get_table(problem => 5, subproblem => 1)->method,'First Order Conditional Estimation','get table number nm720');

done_testing();
