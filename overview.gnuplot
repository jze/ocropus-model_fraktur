set boxwidth 0.5
set style fill solid 1.0 border -1
set xtics rotate
set ylabel 'recognition error'

plot 'overview.csv' u 4:xtic(1) with boxes notitle, 'overview-error.txt' u 1:2 with lines lc black notitle
plot 'overview.csv' u 7:xtic(1) with boxes notitle, 'overview-error.txt' u 1:3 with lines lc black notitle
