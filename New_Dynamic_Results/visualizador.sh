#!/bin/bash

# Paso 1: Detectar todos los directorios solución en el directorio actual
echo "Soluciones disponibles..."
soluciones=($(find . -maxdepth 1 -type d ! -name "." -printf "%f\n"))

# Verificamos que haya al menos uno
if [ ${#soluciones[@]} -eq 0 ]; then
    echo "❌ No se encontraro soluciones"
    exit 1
fi

# Mostrar menú de soluciones
echo ""
echo " Cuál solución quieres estudiar?"
select solucion in "${soluciones[@]}"; do
    if [ -n "$solucion" ]; then
        break
    else
        echo " Selección inválid (como Clarita). Intenta de nuevo."
    fi
done

# Paso 2: Buscar archivos .rt y .t dentro del directorio elegido
echo ""
echo "Buscando archivos .rt y .t en '$solucion'..."
archivos=($(find "$solucion" -maxdepth 1 -type f \( -name "*.rt" -o -name "*.t" \) -printf "%f\n"))

# Verificar si hay archivos válidos
if [ ${#archivos[@]} -eq 0 ]; then
    echo "o se encontraron archivos .rt ni .t en $solucion"
    exit 1
fi

# Mostrar menú de funciones
echo ""
echo "¿Qué función quieres visualizar?"
select funcion in "${archivos[@]}"; do
    if [ -n "$funcion" ]; then
        break
    else
        echo " Selección inválid (como el Hawking). Intenta de nuevo."
    fi
done

# Ruta completa
ruta="$solucion/$funcion"
extension="${funcion##*.}"

# Paso 3: Generar archivo Gnuplot según el tipo
case "$extension" in
    rt)
        cat > grafica.gnuplot <<EOF
set title "$funcion en $solucion" font "Helvetica,14"
set xlabel "t" font "Helvetica,12"
set ylabel "r" font "Helvetica,12"
set zlabel "$funcion" font "Helvetica,12"
set border lw 1.5
set grid
splot "$ruta" with lines
pause -1 "Presiona enter para salir, hdlv"
EOF
        ;;
    t)
        cat > grafica.gnuplot <<EOF
set title "$funcion en $solucion" font "Helvetica,14"
set xlabel "t" font "Helvetica,12"
set ylabel "$funcion" font "Helvetica,12"
set border lw 1.5
set grid
set style line 1 lt 1 lw 2 lc rgb "#0072BD"
plot "$ruta" with lines linestyle 1
pause -1 "Presiona enter para salir, hdlv"
EOF
        ;;
    *)
        echo "o sé cómo graficar archivos con extensión .$extension"
        exit 1
        ;;
esac

# Paso 4: Ejecutar el script con Gnuplot
echo ""
echo "Lanzando gráfica con Gnuplot..."
gnuplot grafica.gnuplot

