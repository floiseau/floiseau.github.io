set terminal svg font "Source Sans 3,28"

# Set datafile properties
set datafile separator ','
set key autotitle columnhead

# Set text color
set key textcolor "#003162"

# Enable grid and set its color to #003162
set grid lt "dotted"
set grid lc rgb "#003162"  # line color for grid

# Set border
set border 3
set border lc rgb "#003162"

# Set legend
set key on
set key samplen 1
set key font "Source Sans 3,28"
set key fixed right top

# Set ticks
set xtics autofreq 2e-4
set ytics autofreq 1000

# Define line styles
set style line 1 lc rgb "#003162" lw 2
set style line 2 lc rgb "#40d2a7" lw 2
set style line 3 lc rgb "#f1443a" lw 2

# Define the labels
set xlabel "Displacement [m]" textcolor rgb "#003162" offset 0,0.6
set ylabel "Force [N]" textcolor rgb "#003162" offset 2.5,0

# All plot settings  
set output 'ct_f_u_1_gnuplot.svg'
plot 'lefm.csv' using 7:(-$6) title 'LEFM' with lines ls 1

set output 'ct_f_u_2_gnuplot.svg'
plot 'lefm.csv' using 7:(-$6) title 'LEFM' with lines ls 1, \
     'unstructured.csv' using (sqrt(($9-$11)**2 + ($10-$12)**2)):(-$2*1e-2) title 'CMSI' with lines ls 3

