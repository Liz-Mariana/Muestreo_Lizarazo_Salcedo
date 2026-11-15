# Precio de reventa de bolsos de lujo: muestreo estratificado

Proyecto integrador, Corte III, Muestreo Estadístico, Universidad El Bosque.
Karol Ximena Salcedo Ponguta y Mariana Lizarazo Buitrago.

**Qué se estima:**
- el precio medio de reventa;
- la proporción de anuncios agotados;
- la razón media entre el precio de reventa y el precio en tienda.

Las tres se estiman en total y por marca.

**Población:** los anuncios de bolsos de segunda mano de Louis Vuitton, Chanel y Hermès en Vestiaire Collective que recoge el archivo público de anuncios (mayo de 2021).

**Diseño:** estratificado por marca, aleatorio simple sin reemplazo dentro de cada estrato y asignación de Neyman. Son 150 anuncios: 34 de Chanel, 89 de Hermès y 27 de Louis Vuitton.

## Carpetas

- `datos/fuente/`: archivo original, sin modificar
- `datos/marco.csv`: marco, con un identificador y el estrato de cada anuncio
- `datos/archivo-limpio.csv`: variables de estudio de cada anuncio del marco
- `datos/piloto.csv`: piloto de 10 anuncios por estrato
- `datos/muestra.csv`: muestra seleccionada, con su probabilidad de inclusión y su peso
- `datos/datos.csv`: datos de las unidades seleccionadas, con la columna `respondio`
- `datos/bitacora.md`: bitácora
- `R/`: guiones
- `figuras/`: gráficos

## Cómo reproducirlo

Abrir el `.Rproj` en RStudio, instalar `survey` y correr en orden:

1. `R/00-marco.R`
2. `R/piloto.R`
3. `R/seleccion.R`, con la semilla publicada por el docente
4. `R/comprobacion.R`
5. `R/datos.R`
6. `R/estimacion.R`
