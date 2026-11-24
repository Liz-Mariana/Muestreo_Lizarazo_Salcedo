# Preregistro conjunto · Diseño de Experimentos + Muestreo Estadístico

**Integrantes:** Karol Ximena Salcedo Ponguta y Mariana Lizarazo Buitrago. Las dos cursan ambas materias.
**Forma:** B. Es un experimento computacional sobre el muestreo, más la selección y el análisis de una muestra concreta de una de las poblaciones.
**Escrito antes de correr el experimento.** La muestra concreta (parte de Muestreo) ya se había seleccionado el 14 de noviembre con el protocolo de `protocolo.md`.

## Parte de Muestreo: la muestra concreta

Los diez campos están en `protocolo.md`. En breve:

- **Parámetros:** precio medio de reventa, proporción de anuncios agotados y razón entre el precio de reventa y el precio en tienda.
- **Población:** los anuncios de Louis Vuitton, Chanel y Hermès en Vestiaire Collective (archivo de 2021).
- **Marco:** 11.988 anuncios; quedan fuera 608 sin marca, y si son más baratos el precio queda sobreestimado.
- **Unidad:** el anuncio.
- **Diseño:** estratificado por marca con asignación de Neyman (34/89/27), comparado con el aleatorio simple: margen esperado de £213 frente a £580.
- **Probabilidad de inclusión:** $\pi_k = n_h/N_h$, comprobada con `R/comprobacion.R`.
- **Tamaño:** n = 150, a partir de un piloto.
- **Estimación:** con `survey`.
- **No respuesta:** ajuste por estrato.
- **Ética:** sin datos de personas.

## Parte de Diseño: el experimento

**Pregunta.** Para estimar el precio medio de reventa dentro de una marca, ¿cuánto se gana al estratificar por estado de conservación en vez de usar un aleatorio simple, y cuánto al pasar de 30 a 90 anuncios? ¿Depende la ganancia del diseño del tamaño?

**Respuesta.** Error relativo absoluto de la estimación del precio medio: $100\,|\hat{\bar y} - \bar Y|/\bar Y$, en %. Es exacto porque la población completa se conoce.

**Unidad experimental y de observación.** La corrida: una muestra nueva, con su propia semilla, de la población de una marca. Se observa una estimación por corrida.

**Factores.**
- **Diseño muestral:** aleatorio simple sin reemplazo, o estratificado por estado de conservación en tres grupos (nuevo, muy bueno, bueno/regular), con asignación proporcional y aleatorio simple dentro de cada estrato. El estado está en el marco.
- **Tamaño de muestra:** 30 o 90 anuncios.

**Bloque.** La población de cada marca: Chanel (3.576), Hermès (2.920) y Louis Vuitton (5.492). Son tres poblaciones reales distintas. El error relativo puede ser mayor en una marca que en otra por razones ajenas a los factores, y el bloque saca eso del error.

**Por qué este diseño y no uno más simple.** Un experimento con un solo factor no diría si la ganancia de estratificar cambia con el tamaño. Sin bloques, la diferencia entre marcas inflaría el error residual.

**Réplicas.** Son 20 por celda y bloque, es decir, 240 corridas. Cada réplica es una muestra nueva, no una submuestra. En un piloto de simulación, la desviación del error relativo fue de unos 6 puntos porcentuales. Con 120 corridas por nivel, una diferencia de 3 puntos entre niveles de un factor se detecta con potencia mayor a 0,95. Esperamos que la ganancia de estratificar por estado sea pequeña (el piloto sugiere que reduce la varianza un 8–12 %): con esta réplica podría no detectarse, y eso sería un resultado válido.

**Aleatorización.** `R/tabla-corridas.R`, con semilla 20261123, sortea el orden de las 240 corridas y la semilla de cada una (`datos/tabla-corridas.csv`).

**Modelo.**

$$Y_{ijkr} = \mu + \beta_k + \alpha_i + \gamma_j + (\alpha\gamma)_{ij} + \varepsilon_{ijkr}$$

donde $\beta_k$ es el bloque, $\alpha_i$ el diseño y $\gamma_j$ el tamaño.

| Fuente | gl |
|---|---|
| Bloque (marca) | 2 |
| Diseño | 1 |
| Tamaño | 1 |
| Diseño × Tamaño | 1 |
| Error | 234 |
| Total | 239 |

**Comparaciones.** Primero se mira la interacción. Si no es importante, se leen los dos efectos principales, cada uno con su diferencia de medias y su intervalo de confianza.

**Supuestos.** Se revisan con los gráficos de residuos contra ajustados y el QQ normal. El error absoluto suele tener residuos asimétricos. Si es así, el remedio se elige con Box-Cox (`MASS::boxcox`) y la potencia se redondea a la más cercana de 0 (logaritmo), 1/3 (raíz cúbica), 1/2 (raíz cuadrada) o 1 (sin transformar). El piloto de simulación dio potencias entre 0,24 y 0,41. Los efectos se reportan en la escala original.

**Ética.** El experimento no involucra personas. Usa un archivo público, citado.
