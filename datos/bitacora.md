# Bitácora

El marco es un archivo público: no hubo campo con personas. Aquí queda de dónde y cuándo se descargó el archivo, qué versión es y qué unidades seleccionadas salieron sin dato.

## Descarga del archivo

- Fuente: https://github.com/Ketevana/Data-Science-Capstone-Project, archivo `Part_2/preview.csv`
- Versión (commit): `b567eb7854084772b51556ba867052c850e37f65`, del 30 de mayo de 2021
- md5 del archivo: `276514ccdc3774b53b205919815ea053`
- Guardado sin modificar en `datos/fuente/vestiaire_bolsos_crudo.csv`

## Construcción del marco (`R/00-marco.R`)

| Paso | Anuncios |
|---|---|
| Archivo original | 12.916 |
| Sin marca (quedan fuera del marco) | 12.308 |
| Sin duplicados | 11.990 |
| Sin el estado "Vintage" | 11.988 |

Estratos: Chanel (CH) 3.576, Hermès (HE) 2.920, Louis Vuitton (LV) 5.492.

## Piloto (`R/piloto.R`, semilla 1105)

- 10 anuncios por estrato (`datos/piloto.csv`). Sus datos solo se usaron para calcular el tamaño y no entran en la estimación.

## Selección (`R/seleccion.R`), 14 de noviembre de 2026

- Semilla: 20261113. El docente no publicó una semilla; el equipo usó la que estaba escrita en el protocolo (desviación 2 del avance).
- La selección se corrió una sola vez: 34 anuncios de CH, 89 de HE y 27 de LV (`datos/muestra.csv`). Los pesos suman 11.988.
- Comprobación (`R/comprobacion.R`): la frecuencia de selección de cada anuncio en 2.000 repeticiones está cerca de su π_k. El resultado completo está en la sección 4 del informe.

## Levantamiento de datos (`R/datos.R`), 14 de noviembre de 2026

- Los 150 anuncios seleccionados están en el archivo. Precio de reventa y estado de agotado: sin faltantes.
- Sin precio en tienda (no respuesta): 2 anuncios, ambos de LV: `A02223` y `A02500`. Se mantienen en la muestra y no se sustituyen.

## Nota del 23 de noviembre de 2026

- `datos/muestra.csv` y `datos/datos.csv` no se habían subido con el avance. Se suben con el informe. Son los que producen `R/seleccion.R` y `R/datos.R` con la semilla 20261113, y coinciden con la tasa de respuesta y las medias por marca del avance.
- Se quitan del repositorio `.RData` y `.Rhistory`, que se habían subido por error. Ya estaban en el `.gitignore`.

## Experimento computacional (modalidad conjunta, Forma B)

- 23 de noviembre de 2026: el docente autoriza unir los proyectos. Se publica `preregistro.md` (release `preregistro`) **antes** de correr el experimento.
- Tabla de corridas: `R/tabla-corridas.R`, semilla 20261123, con 240 corridas en orden aleatorio y una semilla propia para cada corrida (`datos/tabla-corridas.csv`).
- Ejecución: `R/experimento.R` corre las 240 corridas en el orden de la tabla y escribe `datos/experimento.csv`. Cada corrida es una muestra nueva de la población de su marca. Como no hay personas ni equipos, no hay incidentes de campo; si el guion se detiene, se anota aquí.
- Fecha y hora de la ejecución:
- Responsable:
