#!/bin/sh

ls training/*.bin.png > train.txt 
ls testing/*.bin.png >test.txt

report_every=10 save_every=1000 ntrain=200000 dewarp=center display_every=10 test_every=10000 display_every=0 hidden=100 lrate=1e-4 save_name=frakt report_time=1 clstmocrtrain train.txt  test.txt
