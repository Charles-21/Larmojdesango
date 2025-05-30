set title "masa.t en 0.18_0" font "Helvetica,14"
set xlabel "t" font "Helvetica,12"
set ylabel "masa.t" font "Helvetica,12"
set border lw 1.5
set grid
set style line 1 lt 1 lw 2 lc rgb "#0072BD"
plot "0.18_0/masa.t" with lines linestyle 1
pause -1 "Presiona enter para salir, hdlv"
