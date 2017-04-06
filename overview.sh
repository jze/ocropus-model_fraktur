#!/bin/bash

# Generate a table with an overview (number of lines, number of characters, recognition error) over the books 
# used in the training process.

ocropus-rpred -q -n -m /home/jzedlitz/sandbox/ocropus-model_fraktur/fraktur.pyrnn.gz -Q6 training/*.bin.png
ocropus-rpred -q -n -m /home/jzedlitz/sandbox/ocropus-model_fraktur/fraktur.pyrnn.gz -Q6 testing/*.bin.png

ls training/*.gt.txt | cut -c 10- | sed 's/_.*//' | uniq  | while read book; do echo -ne "$book\t"; LANG=  wc -m -l training/${book}_*.gt.txt |grep total | sed 's/[^ 0-9].*//' ; done > r1.txt
ls training/*.gt.txt | cut -c 10- | sed 's/_.*//' | uniq  | while read book; do echo -ne "$book\t"; LANG=  wc -m -l testing/${book}_*.gt.txt |grep total | sed 's/[^ 0-9].*//' ; done > r2.txt

ls training/*.gt.txt | cut -c 10- | sed 's/_.*//' | uniq  | while read book; do echo -ne "$book\t"; ocropus-errs -e training/${book}_*.gt.txt |grep ^0; done > r3.txt
ls training/*.gt.txt | cut -c 10- | sed 's/_.*//' | uniq  | while read book; do echo -ne "$book\t"; ocropus-errs -e testing/${book}_*.gt.txt |grep ^0; done> r4.txt

echo -e "# book\ttraining lines\ttraining characters\ttraining error\ttest lines\ttest characters\ttest error"  > overview.csv
join r1.txt r3.txt  | join - r2.txt | join - r4.txt | tr ' ' \\t |sed 's/\t\t/\t/' >> overview.csv

echo "Result can be found in 'overview.csv'."
rm -f r1.txt r2.txt r3.txt r4.txt
