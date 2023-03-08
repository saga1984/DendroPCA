# DendroPCA

DendroPCA, carga un archivo de excel (matriz binaria) y realiza lo siguiente:
Hace análisis por componentes principales y obtiene grafico de calidad de publicacion. 
- Hace dendrograma con soporte estadistico y obtiene grafico de calidad de publicacion. 
- Hace una matriz de correlación (Pearson) ordenada por agrupamiento jerarquico
- Hace a partir de todos (10) los metodos de ade4 para obtener matrices de distancia y a partir de todos (8) los metodos de agrupamiento jerarquico
obtiene todas las combinaciones (80) y obtiene sus indices cofeneticos (IC).
- A partir de las 4 mejores combinaciones, según el valor de IC, se contruye dendrogramas y obtiene graficos de calidad de publicacion.
- Genera archivos formato en CSV de valores de PIC (con interpretacion) y H, para evaluar la calidad de los marcadores moleculares usados.
- Genera un archivo formato CSV de valores cofenéticos para 80 combinaciones de matrices de distancia y

# metodos de agrupamiento usados

## Ejemplo de archivo de entrada
