#!/usr/bin/env Rscript

library(optparse)

option_list <- list(
   make_option(c("-f", "--first"), type = "character",  help = "first read pair", metavar = "read1.fastq1"),
   make_option(c("-s", "--second"), type = "character", help = "second read pair", metavar = "read2.fastq"),
   make_option(c("-t", "--thread"), type = "integer", help = "number of threads to use", default = 8)
)

opt <- parse_args(OptionParser(option_list=option_list))

if(any(is.null(opt$first), is.null(opt$second))){
   print_help(OptionParser(option_list=option_list))
   quit(status = 1)
}

message(paste0("Read 1: ", opt$first, "\nRead 2: ", opt$second, "\nThread: ", opt$thread))
quit(status = 0)

