# Ejecución de las 240 corridas del experimento computacional.
# En cada corrida se toma UNA muestra nueva de la población de la marca (bloque), con el
# diseño y el tamaño de la corrida, se estima el precio medio y se compara con el valor real.
# Respuesta: error relativo absoluto = 100 * |estimación - media real| / media real (en %).

if (file.exists("datos/experimento.csv")) stop("datos/experimento.csv ya existe, no se sobrescribe")

archivo <- read.csv("datos/archivo-limpio.csv", fileEncoding = "UTF-8")

# Estratos del diseño estratificado: estado de conservación en tres grupos (está en el marco)
archivo$estado3 <- ifelse(archivo$estado %in% c("Never worn", "Never worn, with tag"), "nuevo",
                   ifelse(archivo$estado == "Very good condition", "muy_bueno", "bueno_regular"))
niveles_estado <- c("nuevo", "muy_bueno", "bueno_regular")

# Asignación proporcional con redondeo por restos mayores (suma exactamente n)
asignar <- function(N_h, n) {
  q <- n * N_h / sum(N_h)
  b <- floor(q)
  faltan <- n - sum(b)
  if (faltan > 0) {
    o <- order(-(q - b))[1:faltan]
    b[o] <- b[o] + 1
  }
  b
}

tabla <- read.csv("datos/tabla-corridas.csv", stringsAsFactors = FALSE)
tabla <- tabla[order(tabla$orden_planeado), ]

res <- vector("list", nrow(tabla))
for (i in seq_len(nrow(tabla))) {
  f   <- tabla[i, ]
  pob <- archivo[archivo$estrato == f$bloque, ]
  Y   <- mean(pob$precio)

  set.seed(f$semilla_corrida)
  if (f$diseno == "mas") {
    est <- mean(pob$precio[order(runif(nrow(pob)))[1:f$tamano]])
  } else {
    N_h <- as.numeric(table(factor(pob$estado3, levels = niveles_estado)))
    n_h <- asignar(N_h, f$tamano)
    medias <- sapply(seq_along(niveles_estado), function(j) {
      p <- pob$precio[pob$estado3 == niveles_estado[j]]
      mean(p[order(runif(length(p)))[1:n_h[j]]])
    })
    est <- sum(N_h * medias) / sum(N_h)
  }

  res[[i]] <- data.frame(
    corrida = f$corrida, orden_planeado = f$orden_planeado, orden_real = i,
    bloque = f$bloque, diseno = f$diseno, tamano = f$tamano, replica = f$replica,
    semilla_corrida = f$semilla_corrida,
    media_poblacion = round(Y, 4), estimacion = round(est, 4),
    error_firmado   = round(100 * (est - Y) / Y, 6),
    error_relativo  = round(100 * abs(est - Y) / Y, 6),
    fecha_hora = format(Sys.time(), "%Y-%m-%d %H:%M:%S"), observaciones = "")
}

experimento <- do.call(rbind, res)
write.csv(experimento, "datos/experimento.csv", row.names = FALSE)
aggregate(error_relativo ~ diseno + tamano, data = experimento, FUN = mean)
