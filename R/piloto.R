# Piloto: 10 anuncios por estrato, con su propia semilla, solo para calcular el tamaño.
# Sus datos no entran en la estimación; sus unidades siguen en el marco.

archivo <- read.csv("datos/archivo-limpio.csv", fileEncoding = "UTF-8")
set.seed(1105)                                    # semilla del piloto

piloto <- NULL
for (h in c("CH", "HE", "LV")) {
  d <- archivo[archivo$estrato == h, ]
  piloto <- rbind(piloto, d[order(runif(nrow(d)))[1:10], ])
}
write.csv(piloto, "datos/piloto.csv", row.names = FALSE)

N_h <- table(archivo$estrato)[c("CH", "HE", "LV")]
N   <- sum(N_h)
W_h <- N_h / N
S_h <- tapply(piloto$precio, piloto$estrato, sd)[c("CH", "HE", "LV")]
m_h <- tapply(piloto$precio, piloto$estrato, mean)[c("CH", "HE", "LV")]
round(cbind(N_h, m_h, S_h), 1)
# CH 3576  2654.4 1016.2 | HE 2920 8822.9 3298.1 | LV 5492 879.1 526.0

z <- 1.96
e <- 250                                          # margen de error buscado, en libras
S2_mas  <- sum(W_h * S_h^2) + sum(W_h * (m_h - sum(W_h * m_h))^2)
n_mas   <- (z^2 * S2_mas / e^2) / (1 + z^2 * S2_mas / e^2 / N)
n_prop  <- (z^2 * sum(W_h * S_h^2) / e^2) / (1 + z^2 * sum(W_h * S_h^2) / e^2 / N)
n_ney   <- (z^2 * sum(W_h * S_h)^2 / e^2) / (1 + z^2 * sum(W_h * S_h^2) / (N * e^2))
round(c(aleatorio_simple = n_mas, proporcional = n_prop, neyman = n_ney), 1)
# 766.5  186.6  109.9

# Tamaño elegido: 150 (Neyman redondeado hacia arriba) y su asignación
n <- 150
round(n * N_h * S_h / sum(N_h * S_h), 2)          # 33.75  89.44  26.83 -> 34, 89, 27
