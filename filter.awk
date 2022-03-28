#!/usr/bin/awk -f

# name:    filter.awk
# author:  nbehrnd@yahoo.com
# license: GPL v2, 2022
# date:    <2022-03-23 Wed>
# edit:    <2022-03-28 Mon>

# Retain "reasonable" SMILES strings OpenBabel may process gently.
#
# For a successful application of this filter, this AWK script depends
# on a running installation of OpenBabel and AWK.  (Tests suggest you may
# use GNU AWK/gawk and nawk instead of AWK as well.)
#
# Write a list of SMILES into the same directory as this AWK script, e.g.,
# as file check01.smi.  Then deploy this filter e.g., by
#
# awk -f filter.awk check01.smi
#
# to process the content of the list of SMILES.  The output is a list of
# canonical SMILES which OpenBabel has no difficulty to process.  Entries
# which cause a warning by OpenBabel (i.e., a five-line output during the
# test conversion) are not reported back.

{test_convert = "obabel -:\"" $1 "\" -ocan > shuttle.txt 2>&1";
    system(test_convert);

    filter = "awk 'END{if (NR==2) {print $0;}}' shuttle.txt"
    system(filter);
}
