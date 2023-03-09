# DendroPCA

DendroPCA, carga un archivo de excel (matriz binaria) y realiza lo siguiente:
Hace análisis por componentes principales y obtiene grafico de calidad de publicacion. 
- Hace dendrograma con soporte estadistico y obtiene grafico de calidad de publicacion. 
- Hace una matriz de correlación (Pearson) ordenada por agrupamiento jerarquico
- Hace a partir de todos (10) los metodos de ade4 para obtener matrices de distancia y a partir de todos (8) los metodos de agrupamiento jerarquico
obtiene todas las combinaciones (80) y obtiene sus indices cofeneticos (IC).
- A partir de las 4 mejores combinaciones, según el valor de IC, se contruye dendrogramas y obtiene graficos de calidad de publicacion.
- Genera archivos formato en CSV de valores de PIC (con interpretacion) y H, para evaluar la calidad de los marcadores moleculares usados.
- Genera un archivo formato CSV de valores cofenéticos para 80 combinaciones de matrices de distancia y metodos de agrupamiento

NOTA: Las gráficas se generan por defecto en formato jpeg pero se puede elegir entre tiff, bmp, png y jpeg

## metodos de agrupamiento usados
- "ward.D",
- "ward.D2",
- "single",
- "complete",
- "average",
- "mcquitty",
- "median",
- "centroid"

## metodos de obtencion de matriz de distancia
- "JACCARD S3"
- "SOKAL & MICHENER S4"
- "SOKAL & SNEATH S5"
- "ROGERS & TANIMOTO S6"
- "CZEKANOWSKI S7"
- "GOWER & LEGENDRE S9"
- "OCHIAI S12"
- "SOKAL & SNEATH S13"
- "Phi of PEARSON S14"
- "GOWER & LEGENDRE S2"

## Ejemplo de archivo de entrada
### Matriz binaria (de presencia ausencia de bandas de PCR)
LOC	| IND1	 |IND2	| IND3 | IND4 |
----|--------|------|------|------|
LOC1_140	| 1	| 1	| 1	| 1 |
LOC1_190	| 0 | 0 | 0 | 0 |
LOC1_250	|	0 |	1 | 0 | 0 |
LOC1_300	| 0 | 0 | 0 | 0 |
LOC1_400	| 0 | 0 | 0 | 0 |
LOC1_450	| 1 |	1	| 1 | 0 |
LOC1_550	| 1 |	1 |	1 | 0 |
LOC1_750	| 1 |	1 |	1 |	1 |
LOC1_950	| 1	|	1 |	0 | 0 |
LOC1_1500	| 0 | 0 | 0 | 0 |
LOC1_2000	|	0 |	1 | 0 | 0 |
LOC2_360	| 1	| 0 |	1 | 0 |
LOC2_400	|	0 | 0 | 0 | 0 |
LOC2_440	|	0 |	1 | 0 | 0 |
LOC2_800	| 1	|	1 |	0 | 0 |
LOC3_225	| 1	| 1 |	1 |	0 |
LOC3_250	| 1 |	1 |	1 |	0 |
LOC3_275	| 1	| 1 |	1 |	0 |
LOC3_300	| 1	| 1	| 1	| 1 |
LOC3_500	| 0 | 0 | 0 | 0 |
LOC4_150	| 1 | 1	| 1 |	1 |
LOC4_225	| 0 |	1 | 0 | 0 |
LOC4_350	| 1 | 1	| 1 | 0 |

## Archivos de salida
### Heterogenicidad
Marcador |	Heterogenicidad |
---------|------------------|
LOC1	| 0.85 |
LOC2	| 0.625 | 
LOC3	| 0.722 |
LOC4	| 0.763 |
LOC5	| 0.681 |
LOC6	| 0.777 |
LOC7	| 0.789 |
LOC8	| 0.868 |
LOC9	| 0.18 |
LOC10	| 0.498 |
LOC11	| 0.852 |
LOC12	| 0.749 |
LOC13	| 0.685 |
LOC14	| 0.786 |

### PIC (Contenido de Informacion Polimorfica)
Marcador	| PIC |	Interpretacion |
----------|-----|----------------|
LOC1	| 0.833	| Muy Informativo |
LOC2	| 0.551	| Moderadamente Informativo |
LOC3	| 0.679	| Muy Informativo |
LOC4	| 0.729	| Muy Informativo |
LOC5	| 0.638	| Muy Informativo |
LOC6	| 0.741	| Muy Informativo |
LOC7	| 0.767	| Muy Informativo |
LOC8	| 0.854	| Muy Informativo |
LOC9	| 0.164	| No Informativo |
LOC10	| 0.374	| Moderadamente Informativo |
LOC11	| 0.836	| Muy Informativo |
LOC12	| 0.705	| Muy Informativo |
LOC13	| 0.64	| Muy Informativo |
LOC14	| 0.752	| Muy Informativo |

### Valores cofenéticos (80 combinaciones)
Combinacion_distancia_agrupamiento	| Valor_IndiceCofenetico |
------------------------------------|------------------------|
SOKAL_&_SNEATH_S5_average	| 0.97506046 |
SOKAL_&_SNEATH_S5_mcquitty | 0.97256937 |
JACCARD_S3_average | 0.97249395 |
JACCARD_S3_mcquitty	| 0.96979511 |
OCHIAI_S12_average | 0.96667575 |
CZEKANOWSKI_S7_average | 0.96660277 |
SOKAL_&_SNEATH_S13_average | 0.96585971 |
OCHIAI_S12_mcquitty |	0.96383021 |
CZEKANOWSKI_S7_mcquitty |	0.96379487 |
SOKAL_&_SNEATH_S13_mcquitty |	0.96239853 |
SOKAL_&_SNEATH_S5_complete | 0.96218411 |
SOKAL_&_SNEATH_S5_single | 0.95968778 |
JACCARD_S3_complete	| 0.95925127 |
ROGERS_&_TANIMOTO_S6_average | 0.95811248 |
SOKAL_&_SNEATH_S13_complete	| 0.95793838 |
Phi_of_PEARSON_S14_average | 0.95752927 |
JACCARD_S3_single |	0.95422703 |
ROGERS_&_TANIMOTO_S6_mcquitty |	0.95398313 |
Phi_of_PEARSON_S14_mcquitty |	0.95365089 |
OCHIAI_S12_complete |	0.95154922 |
CZEKANOWSKI_S7_complete |	0.95136198 |
Phi_of_PEARSON_S14_complete |	0.94963859 |
GOWER_&_LEGENDRE_S9_average |	0.94949019 |
SOKAL_&_MICHENER_S4_average |	0.94949019 |
GOWER_&_LEGENDRE_S2_average |	0.94654587 |
GOWER_&_LEGENDRE_S9_mcquitty | 0.94499696 |
SOKAL_&_MICHENER_S4_mcquitty | 0.94499696 |
CZEKANOWSKI_S7_single	| 0.94347506 |
GOWER_&_LEGENDRE_S2_mcquitty | 0.94164209 |
OCHIAI_S12_single	| 0.94088355 |
SOKAL_&_SNEATH_S13_single	| 0.93844002 |
ROGERS_&_TANIMOTO_S6_single	| 0.93425771 |
GOWER_&_LEGENDRE_S2_complete |	0.93283138 |
ROGERS_&_TANIMOTO_S6_complete |	0.92558376 |
Phi_of_PEARSON_S14_single |	0.92199232 |
GOWER_&_LEGENDRE_S9_single | 0.92062597 |
SOKAL_&_MICHENER_S4_single | 0.92062597 |
GOWER_&_LEGENDRE_S9_complete	| 0.91467212 |
SOKAL_&_MICHENER_S4_complete	| 0.91467212 |
SOKAL_&_SNEATH_S13_centroid	| 0.9068372 |
CZEKANOWSKI_S7_centroid	| 0.9067725 |
OCHIAI_S12_centroid	| 0.90535203 |
JACCARD_S3_centroid	| 0.90466649 |
GOWER_&_LEGENDRE_S2_single	| 0.90402015 |
ROGERS_&_TANIMOTO_S6_centroid	| 0.90364496 |
GOWER_&_LEGENDRE_S9_centroid |	0.90359864 |
SOKAL_&_MICHENER_S4_centroid |	0.90359864 |
Phi_of_PEARSON_S14_centroid	| 0.90349181 |
SOKAL_&_SNEATH_S5_centroid	| 0.87441902 |
OCHIAI_S12_ward.D2 | 0.83809796 |
CZEKANOWSKI_S7_ward.D2 | 0.83675402 |
Phi_of_PEARSON_S14_ward.D2 | 0.83047374 |
SOKAL_&_SNEATH_S13_ward.D2 | 0.82433284 |
GOWER_&_LEGENDRE_S9_ward.D2	| 0.82132567 |
SOKAL_&_MICHENER_S4_ward.D2 |	0.82132567 |
JACCARD_S3_ward.D2 | 0.82045529 |
ROGERS_&_TANIMOTO_S6_ward.D2 | 0.81509076 |
SOKAL_&_SNEATH_S5_median | 0.80961117 |
JACCARD_S3_median	| 0.79015931 |
GOWER_&_LEGENDRE_S2_ward.D2	| 0.78887508 |
OCHIAI_S12_ward.D	| 0.78575091 |
CZEKANOWSKI_S7_ward.D	| 0.78420383 |
GOWER_&_LEGENDRE_S2_ward.D | 0.77233158 |
SOKAL_&_SNEATH_S13_median	| 0.76562954 |
GOWER_&_LEGENDRE_S9_median	| 0.76155217 |
SOKAL_&_MICHENER_S4_median	| 0.76155217 |
ROGERS_&_TANIMOTO_S6_median	| 0.76148283 |
CZEKANOWSKI_S7_median	| 0.7610332 |
OCHIAI_S12_median	| 0.75043193 |
Phi_of_PEARSON_S14_median	| 0.72748004 |
SOKAL_&_SNEATH_S5_ward.D2	| 0.64781187 |
Phi_of_PEARSON_S14_ward.D	| 0.60398667 |
SOKAL_&_SNEATH_S13_ward.D	| 0.5976535 |
GOWER_&_LEGENDRE_S9_ward.D | 0.59475067 |
SOKAL_&_MICHENER_S4_ward.D | 0.59475067 |
ROGERS_&_TANIMOTO_S6_ward.D |	0.59146807 |
JACCARD_S3_ward.D |	0.58739266 |
SOKAL_&_SNEATH_S5_ward.D | 0.5739001 |
GOWER_&_LEGENDRE_S2_median | 0.47413837 |
GOWER_&_LEGENDRE_S2_centroid | -0.06443341 |





### Grafica Dendrograma con dos valores de p-value
![Dendrograma](https://github.com/saga1984/DendroPCA/blob/main/Dendrograma.jpeg)

### Analisis por Componentes Principales
![PCA](https://github.com/saga1984/DendroPCA/blob/main/PCA.jpeg)

Ademas se crean imagenes de apoyo al analisis de PCA como: PCA aportaciones, contibuciones totales de var e ind cos2 de var e ind

### Mejor dendrograma con validacion de clusters (numero optimo de clusters y valor mas alto de indice cofenetico)
#### Vertical
![Best_Dendro](https://github.com/saga1984/DendroPCA/blob/main/Vainilla%20_%20SOKAL_%26_SNEATH_S5_average.jpeg)

#### Horizontal
![Best_Dendro](https://github.com/saga1984/DendroPCA/blob/main/Vainilla%20_%20SOKAL_%26_SNEATH_S5_average_horizontal.jpeg)
