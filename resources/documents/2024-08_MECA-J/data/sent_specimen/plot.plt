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
set key fixed left top

# Set ticks
set xtics autofreq 2e-6
set ytics autofreq 200

# Define line styles
set style line 1 lc rgb "#003162" lw 2
set style line 2 lc rgb "#40d2a7" lw 2
set style line 3 lc rgb "#f1443a" lw 2

# Define the labels
set xlabel "Displacement [m]" textcolor rgb "#003162" offset 0,0.6
set ylabel "Force [N]" textcolor rgb "#003162" offset 2.5,0

# All plot settings  
set output 'sent_f_u_1_gnuplot.svg'
plot 'LEFM_equilibrium_path.csv' using 7:8 title 'LEFM' with lines ls 1

set output 'sent_f_u_2_gnuplot.svg'
plot 'LEFM_equilibrium_path.csv' using 7:8 title 'LEFM' with lines ls 1, \
     'uimp/ell_over_h_8.csv' using 10:($4*1e-3) title 'DISP' with lines ls 2

set output 'sent_f_u_3_gnuplot.svg'
plot 'LEFM_equilibrium_path.csv' using 7:8 title 'LEFM' with lines ls 1, \
     'uimp/ell_over_h_8.csv' using 10:($4*1e-3) title 'DISP' with lines ls 2, \
     'cmsi/ell_over_h_8.csv' using 10:($4*1e-3) title 'CMSI' with lines ls 3
