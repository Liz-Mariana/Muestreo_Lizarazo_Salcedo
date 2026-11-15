# Levantamiento de los datos de cada unidad seleccionada desde el archivo.
# respondio = TRUE si la unidad tiene las tres variables de estudio.
# precio y agotado no tienen faltantes; precio_tienda falta en 132 anuncios del archivo.

muestra <- read.csv("datos/muestra.csv", fileEncoding = "UTF-8")
archivo <- read.csv("datos/archivo-limpio.csv", fileEncoding = "UTF-8")

datos <- merge(muestra[, c("id", "estrato")],
               archivo[, c("id", "precio", "precio_tienda", "agotado")], by = "id",
               all.x = TRUE)
datos$conserva  <- datos$precio / datos$precio_tienda
datos$respondio <- !is.na(datos$precio) & !is.na(datos$precio_tienda) & !is.na(datos$agotado)

write.csv(datos, "datos/datos.csv", row.names = FALSE)

# Tasa de respuesta, total y por estrato
round(mean(datos$respondio) * 100, 1)
round(tapply(datos$respondio, datos$estrato, mean) * 100, 1)
datos$id[!datos$respondio]           # para la bitácora
