#!/usr/bin/env Rscript
#
# Example script using both positional and optional arguments. For more
# examples, see:
#
#     https://cran.r-project.org/web/packages/optparse/vignettes/optparse.html
#

suppressPackageStartupMessages(library(optparse))

# optional args
option_list <- list(
   make_option(c("-p", "--threads"), type = "integer", default = 2, help =
               "Number of threads to use (default = %default)"),
   make_option(c("-v", "--verbose"), action = "store_true", default = FALSE,
               help = "Verbose mode (default = %default)")
)

# create your own usage
opt_parse <- OptionParser(usage = "%prog [options] infile <infile2> ...",
                          option_list = option_list)

# set positional_arguments to TRUE
opt <- parse_args(opt_parse, positional_arguments = TRUE)

# print usage if no positional args provided
if (length(opt$args) == 0){
   print_help(opt_parse)
   stop("Please provide an input file")
}

if (opt$options$verbose){
   message("Verbose mode activated")
}
message(paste0("Using ", opt$options$threads, " threads"))

for (file in opt$args){
   if(!file.exists(file)){
      stop(paste0(file, " does not exist"))
   }
   message(paste0("Processing ", file))
}

message("Done")
quit()

