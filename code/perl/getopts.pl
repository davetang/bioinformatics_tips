#!/usr/bin/env perl

use warnings;
use strict;
use Getopt::Long;

my $thread  = 8;
my $verbose = 0;
my $help    = 0;

GetOptions(
   "thread=i" => \$thread,   # numeric
   "verbose"  => \$verbose,  # flag
   "help"     => \$help      # flag
) or die("Error in command line arguments\n");

if ($help == 1){
   usage()
}

if (scalar @ARGV != 2){
   usage()
}
my $fastq1  = $ARGV[0];
my $fastq2  = $ARGV[1];

if ($verbose){
   print STDERR "Verbose mode\n";
}
print STDERR join("\n", "Read 1: $fastq1", "Read 2: $fastq2", "Using $thread threads"), "\n";

sub usage {
print STDERR <<EOF;
Usage: $0 [-h] [-v] [-t INT] read1 read2

positional arguments:
  read1                 first read pair
  read2                 second read pair

optional arguments:
  -h, --help            show this help message and exit
  -v, --verbose         verbose mode
  -p INT --threads INT  number of threads (default: 8)

EOF
exit();
}
