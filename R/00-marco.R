# Construcción del marco a partir del archivo público de anuncios (Vestiaire Collective)
# Fuente: https://github.com/Ketevana/Data-Science-Capstone-Project (Part_2/preview.csv,
# versión b567eb7). El archivo original se guarda sin tocar en datos/fuente/.

url <- paste0("https://raw.githubusercontent.com/Ketevana/Data-Science-Capstone-Project/",
              "b567eb7854084772b51556ba867052c850e37f65/Part_2%20/preview.csv")
destino <- "datos/fuente/vestiaire_bolsos_crudo.csv"
dir.create("datos/fuente", recursive = TRUE, showWarnings = FALSE)
if (!file.exists(destino)) download.file(url, destino, mode = "wb")
tools::md5sum(destino)   # 276514ccdc3774b53b205919815ea053

crudo <- read.csv(destino, fileEncoding = "UTF-8", stringsAsFactors = FALSE,
                  na.strings = c("NA", ""))

# Depuración (cada paso con su conteo)
b <- crudo[!is.na(crudo$brand), ]                                   # 12916 -> 12308
partes <- strsplit(trimws(b$price_range), "\\s+")
b$precio   <- as.numeric(gsub("[^0-9.]", "", sapply(partes, function(v) v[length(v)])))
b$modelo   <- sub("^Model: ", "", b$m_model)
b$modelo[is.na(b$modelo)] <- "Desconocido"
b$material <- sub("^Material: ", "", b$m_material)
b$color    <- sub("^Color: ", "", b$color)
claves <- c("brand", "title", "price_range", "n_likes", "modelo", "color",
            "condition", "material", "description")
b <- b[!duplicated(b[, claves]), ]                                  # -> 11990
b <- b[b$condition != "Vintage", ]                                  # -> 11988

b$id <- sprintf("A%05d", seq_len(nrow(b)))
b$estrato <- ifelse(b$brand == "Chanel", "CH",
             ifelse(b$brand == "Louis Vuitton", "LV", "HE"))

# Marco: identificador y estrato
marco <- data.frame(id = b$id, estrato = b$estrato, marca = b$brand)
write.csv(marco, "datos/marco.csv", row.names = FALSE, fileEncoding = "UTF-8")
table(marco$estrato)        # CH 3576, HE 2920, LV 5492

# Variables de estudio de cada unidad del archivo (de aquí se "levanta" el dato)
archivo <- data.frame(id = b$id, estrato = b$estrato, precio = b$precio,
                      precio_tienda = b$mean_retail_price, agotado = as.integer(b$sold_out),
                      modelo = b$modelo, estado = b$condition)
write.csv(archivo, "datos/archivo-limpio.csv", row.names = FALSE, fileEncoding = "UTF-8")
