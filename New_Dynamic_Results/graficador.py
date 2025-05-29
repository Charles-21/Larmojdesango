import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D  # Necesario para 3D

# Carga de datos
data = np.loadtxt("0.29_+5/alpha.rt")
t = data[:, 0]
r = data[:, 1]
f = data[:, 2]

# Crear figura
fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')

# Superficie 3D: lo convertimos en malla
from scipy.interpolate import griddata

# Crear una malla regular
ti = np.linspace(min(t), max(t), 200)
ri = np.linspace(min(r), max(r), 100)
T, R = np.meshgrid(ti, ri)
F = griddata((t, r), f, (T, R), method='linear')

# Gráfica 3D
surf = ax.plot_surface(T, R, F, cmap='plasma', edgecolor='none')

# Títulos y etiquetas
ax.set_title("alpha.rt en 0.29_+5")
ax.set_xlabel("t")
ax.set_ylabel("r")
ax.set_zlabel("f(r,t)")
ax.set_box_aspect([1, 1, 0.5])  # X:Y:Z

# VISTA "tipo paper"
# Azimuth = 90 grados (mirada lateral), Elevation = 90 (mirada desde un eje)
ax.view_init(elev=0, azim=0)

# Barra de color (opcional)
fig.colorbar(surf, shrink=0.5, aspect=5)

# Guardar en alta calidad
plt.savefig("grafica_alpha_lateral.png", dpi=150, bbox_inches="tight")

