# Estimación con el diseño: estratificado por marca, con corrección por población finita
library(survey)

muestra <- read.csv("datos/muestra.csv", fileEncoding = "UTF-8")
datos   <- read.csv("datos/datos.csv")
d <- merge(datos, muestra[, c("id", "N_h", "peso")], by = "id")

dis <- svydesign(ids = ~1, strata = ~estrato, weights = ~peso, fpc = ~N_h, data = d)

# 1. Precio medio de reventa y proporción de anuncios agotados (sin faltantes)
p <- svymean(~precio + agotado, dis); p; confint(p)
svyby(~precio + agotado, ~estrato, dis, svymean)

# 2. Razón reventa / tienda: solo respondientes, con ajuste de pesos por estrato
#    (supuesto: dentro de cada marca, faltar el precio de tienda no depende de la razón)
tasa_h <- tapply(d$respondio, d$estrato, mean)
d$peso_aj <- ifelse(d$respondio, d$peso / tasa_h[d$estrato], 0)
resp <- d[d$respondio, ]
dis_r <- svydesign(ids = ~1, strata = ~estrato, weights = ~peso_aj, fpc = ~N_h, data = resp)
r <- svymean(~conserva, dis_r); r; confint(r)

# 3. Como el archivo completo se conoce, se comprueba si el intervalo atrapa el parámetro
archivo <- read.csv("datos/archivo-limpio.csv", fileEncoding = "UTF-8")
c(precio = mean(archivo$precio), agotado = mean(archivo$agotado),
  conserva = mean(archivo$precio / archivo$precio_tienda, na.rm = TRUE))
