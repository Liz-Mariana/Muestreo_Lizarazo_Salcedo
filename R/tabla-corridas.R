# Tabla de corridas del experimento computacional (Forma B de la modalidad conjunta)
# Factorial 2 x 2 en bloques: diseño muestral (aleatorio simple / estratificado por estado)
# x tamaño de muestra (30 / 90), con cada población de marca como bloque (CH, HE, LV).
# 20 réplicas por celda y bloque: 2 x 2 x 3 x 20 = 240 corridas.

semilla <- 20261123   # semilla del preregistro
set.seed(semilla)

d <- expand.grid(replica = 1:20, tamano = c(30, 90), diseno = c("mas", "estratificado"),
                 bloque = c("CH", "HE", "LV"), stringsAsFactors = FALSE)
d$orden_planeado  <- sample(nrow(d))
d <- d[order(d$orden_planeado), ]
d$semilla_corrida <- sample.int(1e6, nrow(d))       # cada corrida, una muestra nueva
d$corrida <- sprintf("C%03d", seq_len(nrow(d)))
d <- d[, c("corrida", "orden_planeado", "bloque", "diseno", "tamano", "replica", "semilla_corrida")]

write.csv(d, "datos/tabla-corridas.csv", row.names = FALSE)
table(d$bloque, paste(d$diseno, d$tamano))           # 20 en cada celda
