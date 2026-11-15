# Ficha del tema

**Integrantes:** Karol Ximena Salcedo Ponguta y Mariana Lizarazo Buitrago.

**Qué estimamos:** el precio medio de reventa de los bolsos de lujo, la proporción de anuncios agotados y la razón media entre el precio de reventa y el precio en tienda, en total y por marca.

**Población:** los anuncios de bolsos de segunda mano de Louis Vuitton, Chanel y Hermès publicados en Vestiaire Collective, según el archivo público de anuncios de mayo de 2021.

**Marco:** el archivo público de 12.916 anuncios del repositorio Ketevana/Data-Science-Capstone-Project (`Part_2/preview.csv`). Después de la depuración quedan 11.988. Quedan fuera los 608 anuncios sin marca y los que el scraping no recogió. Si son de menor valor, sobreestimaríamos el precio medio.

**Unidad:** el anuncio.

**Diseño:** estratificado por marca, porque la marca separa mucho el precio. En el protocolo lo comparamos con un aleatorio simple.

**Tamaño y campo:** unos 150 anuncios. El número exacto sale de un piloto. El dato de cada anuncio seleccionado se toma del archivo; la no respuesta son los anuncios sin precio en tienda.
