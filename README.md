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

### Grafica Dendrograma con dos valores de p-value
![Dendrograma](https://github.com/saga1984/DendroPCA/blob/main/Dendrograma.jpeg)

