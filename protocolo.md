# Protocolo

## 1. Objetivo y parámetros

Para la población y para cada marca (los dominios coinciden con los estratos) se estiman:

- el precio medio de reventa, en libras;
- la proporción de anuncios agotados;
- la razón media entre el precio de reventa y el precio en tienda.

## 2. Población objetivo

Los anuncios de bolsos de segunda mano de Louis Vuitton, Chanel y Hermès publicados en Vestiaire Collective cuando se recogió el archivo. La versión publicada del archivo es de mayo de 2021.

## 3. Marco y cobertura

El marco es el archivo público `Part_2/preview.csv` del repositorio [Ketevana/Data-Science-Capstone-Project](https://github.com/Ketevana/Data-Science-Capstone-Project), versión `b567eb7` (md5 `276514ccdc3774b53b205919815ea053`), con 12.916 anuncios. `R/00-marco.R` lo depura y deja 11.988 en `datos/marco.csv`: 3.576 de Chanel (CH), 2.920 de Hermès (HE) y 5.492 de Louis Vuitton (LV).

Quedan fuera:

- 608 anuncios sin marca, que no se pueden asignar a un estrato;
- 318 duplicados;
- 2 anuncios en estado "Vintage".

Tampoco sabemos si el scraping recogió todos los anuncios del sitio. Si los que faltan o los que no tienen marca son de menor valor, el precio medio quedaría sobreestimado.

## 4. Unidad de muestreo y de observación

El anuncio es a la vez la unidad de muestreo y la de observación.

## 5. Diseño, y por qué ese

Estratificado por marca, con muestreo aleatorio simple sin reemplazo dentro de cada estrato y asignación de Neyman ($n_h \propto N_h S_h$). Margen de error esperado al 95 % para el precio medio, con $n = 150$ y las desviaciones del piloto:

| Diseño | Asignación CH / HE / LV | Margen esperado |
|---|---|---|
| Aleatorio simple | — | £580 |
| Estratificado proporcional | 45 / 36 / 69 | £279 |
| Estratificado de Neyman | 34 / 89 / 27 | £213 |

Con el mismo tamaño, el estratificado de Neyman da un margen casi tres veces menor que el aleatorio simple.

## 6. Probabilidades de inclusión

$\pi_k = n_h / N_h$ y el peso es $w_k = 1/\pi_k$:

- CH: $\pi_k$ = 34/3576 = 0,00951 y $w_k$ = 105,18
- HE: $\pi_k$ = 89/2920 = 0,03048 y $w_k$ = 32,81
- LV: $\pi_k$ = 27/5492 = 0,00492 y $w_k$ = 203,41

Los pesos suman 11.988.

## 7. Tamaño

El piloto (`R/piloto.R`, semilla 1105) toma 10 anuncios por estrato. Las desviaciones del precio que dio son 1.016 (CH), 3.298 (HE) y 526 (LV). Para un margen de £250 al 95 % harían falta 767 anuncios con aleatorio simple, 187 con asignación proporcional y 110 con la de Neyman.

Se redondea a 150, porque con 10 unidades por estrato la variabilidad se estima mal y los precios de Hermès tienen una cola muy larga. Los datos del piloto no entran en la estimación.

## 8. Selección y comprobación

- `R/seleccion.R` usa la semilla **20261113**, fijada por el equipo y publicada con este protocolo antes de seleccionar. Escribe `datos/muestra.csv` con $\pi_k$ y el peso de cada anuncio.
- `R/comprobacion.R` repite la selección 2.000 veces y compara, anuncio por anuncio, la frecuencia con que sale cada uno con su $\pi_k$.

## 9. Plan de estimación

El diseño se declara en `survey` con `svydesign(ids = ~1, strata = ~estrato, weights = ~peso, fpc = ~N_h)`.

- El precio medio y la proporción de agotados se estiman con `svymean`, y por marca con `svyby`, con errores estándar e intervalos al 95 %.
- La razón se estima con los anuncios que tienen el precio en tienda.
- Como el archivo completo se conoce, se comprueba si cada intervalo contiene el parámetro.

Lo que no esté en este plan se reporta aparte, como exploratorio.

## 10. No respuesta y ética

**No respuesta:** son los anuncios seleccionados sin precio en tienda (132 en el marco, 127 de ellos de LV). Siguen en la muestra y no se sustituyen. Para la razón, los pesos se ajustan por clases de respuesta iguales a los estratos. El ajuste supone que, dentro de cada marca, que falte el precio en tienda no depende de la razón.

**Ética:** el estudio no involucra personas ni datos personales. El repositorio original no declara licencia; los datos se usan con fines académicos y con cita de la fuente.
