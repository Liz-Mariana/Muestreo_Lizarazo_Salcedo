# Comprobación del guion: se repite la selección 2000 veces y se cuenta cuántas veces sale
# CADA anuncio. Su frecuencia debe rondar su pi_k = n_h / N_h.

marco <- read.csv("datos/marco.csv", fileEncoding = "UTF-8")
n_h <- c(CH = 34, HE = 89, LV = 27)
N_h <- table(marco$estrato)[names(n_h)]
pi_k <- as.numeric(n_h[marco$estrato] / N_h[marco$estrato])

seleccionar <- function(marco) {
  m <- NULL
  for (h in names(n_h)) {
    d <- marco[marco$estrato == h, ]
    m <- rbind(m, d[order(runif(nrow(d)))[1:n_h[h]], ])
  }
  m
}

set.seed(31)
R <- 2000
veces <- integer(nrow(marco)); names(veces) <- marco$id
for (r in seq_len(R)) {
  s <- seleccionar(marco)$id
  veces[s] <- veces[s] + 1
}
frec <- veces / R
ee   <- sqrt(pi_k * (1 - pi_k) / R)
fuera <- abs(frec - pi_k) > 3 * ee

tapply(frec, marco$estrato, mean)       # cerca de 34/3576, 89/2920, 27/5492
sum(fuera)                              # unas 3 de cada 1000 por azar
sum(veces == 0); sum(veces == R)        # ninguna debe salir siempre

plot(pi_k, frec, pch = 16, cex = 0.4, col = ifelse(fuera, "red", "grey40"),
     xlab = "pi_k del protocolo", ylab = "Frecuencia en 2000 selecciones")
abline(0, 1)
