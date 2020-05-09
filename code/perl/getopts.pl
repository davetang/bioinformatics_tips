#!/usr/bin/env perl

use warnings;
use strict;
use Getopt::Long;

my $fastq1  = "";
my $fastq2  = "";
my $thread  = 8;
my $verbose = 0;
my $help    = 0;

GetOptions ("thread=i" => \$thread,   # numeric
            "first=s"  => \$fastq1,   # string
            "second=s" => \$fastq2,   # string
            "verbose"  => \$verbose,  # flag
            "help"     => \$help)     # flag
|| die("Error in command line arguments\n");

if ($fastq1 eq "" || $fastq2 eq "" || $help == 1){
   usage()
}

if ($verbose){
   print join("\n", "First: $fastq1", "Second: $fastq2", "Thread: $thread"), "\n";
}

sub usage {
print STDERR <<EOF;
Usage: $0 -f read1.fastq -s read2.fastq -t 8

Where:   -f, --first  FILE     first read pair
         -s, --second FILE     second read pair
         -t, --thread INT      number of threads to use (default 8)
         -v, --verbose         print out arguments
         -h, --help            this helpful usage message

EOF
exit();
}

__END__

