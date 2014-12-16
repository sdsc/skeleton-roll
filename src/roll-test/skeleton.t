#!/usr/bin/perl -w
# skeleton roll installation test.  Usage:
# skeleton.t [nodetype]
#   where nodetype is one of "Compute", "Dbnode", "Frontend" or "Login"
#   if not specified, the test assumes either Compute or Frontend

use Test::More qw(no_plan);

my $appliance = $#ARGV >= 0 ? $ARGV[0] :
                -d '/export/rocks/install' ? 'Frontend' : 'Compute';
my $installedOnAppliancesPattern = '.';
my $isInstalled = -d '/opt/skeleton';
my $output;

my $TESTFILE = 'tmpskeleton';

if($appliance =~ /$installedOnAppliancesPattern/) {
  ok($isInstalled, 'skeleton installed');
} else {
  ok(! $isInstalled, 'skeleton not installed');
}
SKIP: {

  skip 'skeleton not installed', 4 if ! $isInstalled;
  $output = `module load skeleton; echo 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 | skeleton 2>&1`;
  like($output, qr/That is correct/, 'skeleton runs');
  `/bin/ls /opt/modulefiles/applications/skeleton/[0-9]* 2>&1`;
  ok($? == 0, 'skeleton module installed');
  `/bin/ls /opt/modulefiles/applications/skeleton/.version.[0-9]* 2>&1`;
  ok($? == 0, 'skeleton version module installed');
  ok(-l '/opt/modulefiles/applications/skeleton/.version',
     'skeleton version module link created');

}

`rm -fr $TESTFILE*`;
