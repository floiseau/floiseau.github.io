# Set the output to SVG with higher resolution and antialiasing for a cleaner look
set terminal svg enhanced font "Source Sans Pro,18" linewidth 1.5 size 600,600

# Set polar mode
set polar

# Customize plot appearance
# set title "Polar Plot of f(φ) = 1 + cos(2 * (φ - θ))" font ",14" textcolor rgb "gray30"
set grid polar linewidth 0.5 linetype -1 linecolor rgb "gray80"

# Define the function

# set output "weak_1.svg"
# f(phi) = 1 / (1 + 0.1 * cos(2 * phi))
# set output "weak_2.svg"
# f(phi) = 1/ (1 + 0.5 * cos(2*(phi - 4*pi/3)))

# set output "strong_1.svg"
# f(phi) = 1/ (1 + 0.6 * cos(4 * (phi)))
set output "strong_2.svg"
f(phi) = 1/ (1 + 0.4 * cos(2 * (phi - pi/4)) + 0.3 * cos(4 * (phi - pi/3)))

# Plot settings
set angles radians       # Use radians for angles
set samples 360          # Higher sample count for a smoother curve
set trange [0:2*pi]      # Full range in radians for phi
set rrange [0:*]         # Set radial range to a fixed value for consistency

# Set equal scaling for x and y axes
set size ratio -1        # Ensures x and y scales are equal

# Customize axis and tics for a modern look
unset border
unset xtics
unset ytics

# Set colors and line styles
plot f(t) with lines linecolor rgb "#1f77b4" linewidth 2 notitle
# Close the SVG output
unset output
