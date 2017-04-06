set terminal pngcairo size 800,600 enhanced
set boxwidth 0.5
set style fill solid 1.0 border -1
set xtics rotate 
set xtics font ", 9"


set output 'images/overview-characters.png'
set title "number of characters used for training/testing"
set key left top
set ylabel 'characters'
plot 'overview.csv' u 3:xtic(1) with boxes title 'training', '' u 6:xtic(1) with boxes title 'testing'

set output 'images/overview-lines.png'
set title "number of lines used for training/testing"
set key left top
set ylabel 'lines'
plot 'overview.csv' u 2:xtic(1) with boxes title 'training', '' u 5:xtic(1) with boxes title 'testing'


set output 'images/overview-training.png'
set title "character precision for training data"
set yrange [0:0.1]
set ylabel 'recognition error'
plot 'overview.csv' u 4:xtic(1) with boxes notitle, 'overview-error.txt' u ($1-0.5):2 with lines lc black notitle

set output 'images/overview-testing.png'
set title "character precision for test data"
set yrange [0:0.1]
set ylabel 'recognition error'
plot 'overview.csv' u 7:xtic(1) with boxes notitle, 'overview-error.txt' u ($1-0.5):3 with lines lc black notitle
