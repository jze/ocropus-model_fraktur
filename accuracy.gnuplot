set terminal png
set output 'images/accuracy.png'

set grid
set ylabel "character accuracy"
set xlabel "iteration"
set key right bottom
set xrange [0:]
set yrange [0.95:1]

plot 'errors.csv' u 1:(1-$2) with lines title 'testing',\
'' u 1:(1-$3) title 'training',\
'' u 1:(1-$3) title 'exclusive testing'
