#!/usr/bin/env python3
#
# based on the argparse tutorial https://docs.python.org/3/howto/argparse.html
#

import argparse
parser = argparse.ArgumentParser()

#
# positional arguments
#

# default type is string
parser.add_argument(
        "echo",
        help = "display a string",
)
# specify integer type
parser.add_argument(
        "number",
        help = "display a number",
        type = int
)

#
# optional arguments
#

# short and long options
# store True if specified
parser.add_argument(
        "-v",
        "--verbose",
        help = "verbose mode",
        action = "store_true"
)

# set choices for argument and default value
parser.add_argument(
        "-p",
        "--threads",
        help = "number of threads",
        choices = range(1,9),
        default = 2,
        type = int
)

args = parser.parse_args()

if args.verbose:
    print("Verbose mode")

if args.threads:
    print("Using %d threads" % args.threads)

print("%s's type is %s" % (args.echo, type(args.echo)))
print("%s's type is %s" % (args.number, type(args.number)))

