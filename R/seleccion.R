# R/seleccion.R: selección de la muestra en un R recién abierto (Session -> Restart R),
# con la semilla fijada en el protocolo antes de seleccionar. Muestreo estratificado por marca, aleatorio simple
# sin reemplazo dentro de cada estrato, asignación de Neyman.

semilla <- 20261113   # fijada por el equipo y publicada en la release "protocolo" antes de correr

marco <- read.csv("datos/marco.csv", fileEncoding = "UTF-8")
n_h <- c(CH = 34, HE = 89, LV = 27)     # asignación del protocolo
N_h <- table(marco$estrato)[names(n_h)]

seleccionar <- function(marco) {
  m <- NULL
  for (h in names(n_h)) {
    d <- marco[marco$estrato == h, ]
    m <- rbind(m, d[order(runif(nrow(d)))[1:n_h[h]], ])
  }
  m
}

set.seed(semilla)
muestra <- seleccionar(marco)
muestra$N_h  <- as.numeric(N_h[muestra$estrato])
muestra$n_h  <- as.numeric(n_h[muestra$estrato])
muestra$pi_k <- muestra$n_h / muestra$N_h
muestra$peso <- 1 / muestra$pi_k

write.csv(muestra, "datos/muestra.csv", row.names = FALSE, fileEncoding = "UTF-8")
table(muestra$estrato)
sum(muestra$peso)      # = 11988
