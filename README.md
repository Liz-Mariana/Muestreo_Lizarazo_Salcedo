Modalidad conjunta: Diseño de Experimentos + Muestreo

# Bolsos de lujo de segunda mano: una muestra estratificada y un experimento sobre el diseño muestral

Proyecto del Corte III. Universidad El Bosque.
Karol Ximena Salcedo Ponguta y Mariana Lizarazo Buitrago. Las dos cursan ambas materias.

**Población:** los anuncios de bolsos de Louis Vuitton, Chanel y Hermès en Vestiaire Collective, según el archivo público de 2021. El marco es ese archivo, con 11.988 anuncios.

**Muestreo:** una muestra estratificada por marca de 150 anuncios. Con ella se estiman el precio medio de reventa, la proporción de anuncios agotados y la razón entre el precio de reventa y el precio en tienda.

**Diseño (Forma B):** un experimento computacional, factorial 2 × 2 en bloques: diseño muestral (aleatorio simple / estratificado por estado) × tamaño (30 / 90). Cada marca es un bloque y hay 240 corridas. La respuesta es el error relativo de la estimación del precio medio.

**El informe:** `informe.html`. Se lee en el navegador sin instalar nada.

## Carpetas

| Archivo o carpeta | Qué es |
|---|---|
| `ficha.md`, `protocolo.md`, `avance.md` | Ficha, protocolo y avance de la parte de Muestreo |
| `preregistro.md` | Preregistro conjunto |
| `informe.Rmd`, `informe.html` | Informe y su versión renderizada |
| `datos/fuente/` | Archivo original, sin modificar |
| `datos/marco.csv`, `datos/archivo-limpio.csv` | Marco y variables de cada anuncio |
| `datos/piloto.csv`, `datos/muestra.csv`, `datos/datos.csv` | Piloto, muestra y datos de la muestra |
| `datos/tabla-corridas.csv`, `datos/experimento.csv` | Tabla de corridas y datos crudos del experimento |
| `datos/bitacora.md` | Bitácora |
| `R/` | Guiones |
| `figuras/` | Gráficos del avance |

## Cómo reproducirlo

1. Clonar el repositorio y abrir `Muestreo_Lizarazo_Salcedo.Rproj` en RStudio.
2. Instalar los paquetes una vez: `install.packages(c("survey", "rmarkdown", "knitr"))`. MASS viene con R.
3. En un R recién abierto, correr en orden: `R/00-marco.R`, `R/piloto.R`, `R/seleccion.R`, `R/comprobacion.R`, `R/datos.R`, `R/tabla-corridas.R` y `R/experimento.R`. Los archivos de `datos/` que generan son idénticos a los del repositorio.
4. Abrir `informe.Rmd` y pulsar **Knit**. Tarda uno o dos minutos y produce `informe.html`.
