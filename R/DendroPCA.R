#'@title usa una matriz binaria de individuos en columnas y marcadores en filas y
#' hace agrupamiento jerarquico y analisis de componentes principales
#'
#'@description carga el archivo de excel (matriz binaria) y realiza lo siguiente
#'hace analisis por componentes principales y obtiene grafico de calidad de publicacion.
#'
#'hace dendrograma con soporte estadistico y obtiene grafico de calidad de publicacion.
#'
#'hace matriz de correlación (Pearson) ordenada por agrupamiento jerarquico
#'
#'a partir de todos (10) los metodos de ade4 para obtener matrices de distancia
#'y a partir de todos (8) los metodos de agrupamiento jerarquico
#'obtiene todas las combinaciones y obtiene sus indices cofeneticos
#'para evaluar los mejores.
#'
#'contruye dendrogramas para las 4 mejores combinaciones y obtiene grafico de calidad de publicacion.
#'
#'archivos formato CSV de valores de PIC (con interpretacion) y H
#'
#'archivo formato CSV de valores cofeneticos para 80 combinaciones de matrices de distancia y
#'metodos de agrupaiento
#'
#'@param ruta es la ruta del archivo de entrada (matriz binaria)
#'@param archivo archivo de entrada (matriz binaria)
#'@param nombres_ind vector de nombres de individuos (igual al numero de columnas de matriz binaria) 
#'@param especie especie de interes de donde vienen los datos
#'
#'@return imagenes de calidad de publicacion de PCA y dendrogramas
#'calculos de PIC y H y lista de indices cofeneticos
#'@export

Dendro_y_PCA <- function(ruta, archivo, nombres_ind, especie){

  # importar hoja de excel
  matriz <- read_xlsx(
    path = paste(ruta, archivo, sep = ""),
    trim_ws = TRUE
  )

  # volver data frame
  matriz <- as.data.frame(matriz)

  # Asignar nombre de filas
  row.names(matriz) <- matriz[,"LOC"]

  # coercionar a data frame
  matriz[, "LOC"] <- NULL

  # convertir NAs en 0
  matriz[is.na(matriz)] <- 0

  # asignar nombres de filas y columnas
  colnames(matriz) <- nombres_ind

  # transponer (columnas a filas y filas a columnas)
  Matriz <- as.data.frame(t(matriz))

  # volver global
  Matriz <<- Matriz
  matriz <<- matriz

  # hacer analisis de componentes principales (PCA)
  res.pca <- PCA(Matriz,  graph = FALSE)

  # obtener eigen valores
  get_eig(res.pca)

  # cos2 total de variables en Dim.1 and Dim.2
  tiff(paste(ruta,"Total_cos2_var.tiff", sep = ""),
       res = 350,
       width = 3000,
       height = 2500)

  print(fviz_cos2(res.pca, choice = "var", axes = 1:2, xtickslab.rt = 90))
  dev.off()

  # cos2 total de individuos en Dim.1 and Dim.2
  tiff(paste(ruta,"Total_cos2_ind.tiff", sep = ""),
       res = 300,
       width = 2000,
       height = 2000)

  print(fviz_cos2(res.pca, choice = "ind", axes = 1:2, xtickslab.rt = 90))
  dev.off()

  # contribuciones total de variables en Dim.1 and Dim.2
  tiff(paste(ruta,"Total_contrib_var.tiff", sep = ""),
       res = 350,
       width = 3000,
       height = 2500)

  print(fviz_contrib(res.pca, choice = "var", axes = 1:2, xtickslab.rt = 90))
  dev.off()

  # cos2 total de individuos en Dim.1 and Dim.2
  tiff(paste(ruta,"Total_contrib_ind.tiff", sep = ""),
       res = 300,
       width = 2000,
       height = 2000)

  print(fviz_contrib(res.pca, choice = "ind", axes = 1:2, xtickslab.rt = 90))
  dev.off()

  # cos2 de individuos en todas las dimensiones
  tiff(paste(ruta,"Cos2_ind.tiff", sep = ""),
       res = 300,
       width = 2000,
       height = 2000)

  corrplot(res.pca$ind$cos2, is.corr = FALSE)
  dev.off()

  # contribuciones de individuos en todas las dimensiones
  tiff(paste(ruta,"Contrib_ind.tiff", sep = ""),
       res = 300,
       width = 2000,
       height = 2000)

  corrplot(res.pca$ind$contrib, is.corr = FALSE)
  dev.off()

  # graficar aportaciones de los de los componentes principales
  tiff(paste(ruta,"PCA_aportaciones.tiff", sep = ""),
       res = 300,
       width = 2000,
       height = 2000)

  print(fviz_screeplot(res.pca,
                       addlabels = TRUE,
                       ylim = c(0, 50))
  )
  dev.off()

  # visualizar los compomentes principales individuales
  # cos2 = the quality of the individuals on the factor map

  tiff(paste(ruta,"PCA.tiff", sep = ""),
       res = 300,
       width = 2000,
       height = 2000)

  print(fviz_pca_ind(res.pca,
                     col.ind = "cos2",
                     gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
                     repel = TRUE,
                     title = paste("PCA individuales /", especie))
  )
  dev.off()

  # marcar grupos con P mayor a 0.95
  pvrect(dendro, alpha = 0.95)
  dev.off()

  #######  indices de distancia para datos binarios paquete: adegenet #######

  ##### Coeficientes de similitud (matrices de distancia) ####

  # Crear vector de metodos disponibles para obtener distancias
  metodos2 <- ""

  # mostrar distancias disponibles
  cat("\nSe evaluaran las siguientes metodos para obtener matrices de distancia\n")
  for (i in 1:10) {
    df <- dist.binary(Matriz, method = i)
    metodos2[i] <- print((attr(df, "method")))
  }

  # reemplazar espacio (" ") con guion bajo ("_")
  metodos <- str_replace_all(metodos2," ", "_")

  # volver global
  metodos <<- metodos

  # crear lista vacia para guardar matrices de distancia
  distancias <- vector(mode = "list",
                       length = length(metodos))

  cat("\n")
  for (i in 1:length(metodos)) {
    # poblar lista con matrices de distancia
    distancias[[i]] <- dist.binary(Matriz, method = i)
    # imprimir nombre del metodo y si es euclideano
    cat("El metodo: ", attr(distancias[[i]], "method"),"\t",
        "\t\t¿Es euclidiano? = ", is.euclid(distancias[[i]]), "\n")
  }

  # nombrar elementos de lista de matrices de distancia
  names(distancias) <- metodos

  # volver global
  distancias <<- distancias

  # REFERENCIA: Gower, J.C. and Legendre, P. (1986)
  # Metric and Euclidean properties of dissimilarity coefficients.
  # Journal of Classification, 3, 5-48.

  ##### agrupamiento jerarquico, paquete: stats version 4.0.1 #######

  # crear vector de metodos de agrupamiento disponibles
  grupos <- c("ward.D",
              "ward.D2",
              "single",
              "complete",
              "average",
              "mcquitty",
              "median",
              "centroid")

  # volver global
  grupos <<- grupos

  for (i in 1:length(metodos)) {
    for(j in 1:length(grupos)){
      # crear listas de todas las combinaciones posibles y nombrarlas con palabra clave
      assign(
        paste("Lista", names(distancias[i]), grupos[j], sep = "_"),
        hclust(d = distancias[[i]], method = grupos[j])
      )
    }
  }

  # poblar la lista con listas correspondientes a todas las combinaciones
  agrupamientos <- lapply(ls(pattern='Lista'), get, envir = sys.parent(0))

  # nombrar todos los elementos a partir de sus propiedades
  for(i in 1:length(agrupamientos)){
    names(agrupamientos)[i] <- paste(str_replace_all(agrupamientos[[i]]$dist.method, " ", "_"),
                                     agrupamientos[[i]]$method, sep = "_")
  }

  ###### validacion de resulados, valores cofeneticos, paquete: stats ###########

  # entre mas cercano el valor a 1, mejor correlacion.
  # el indice cofenetico, IC, mide el grado de correlacion entre
  # distancias y agrupamiento jerarquico distancia real vs distancia agrupamiento

  ############### cophenetic index. paquete stats, version 4.0.1 ################
  ################## coefficients vs average (UPGMA) #######################

  # separar agrupamientos por metodo de distancia usado
  niveles <- ""
  for(i in 1:length(agrupamientos)){
    niveles[i] <- agrupamientos[[i]]$dist.method
  }

  # separar por agrupamientos por metodos de distancias
  for(i in 1:length(metodos)){
    assign(
      paste("agrupamientos_cofeneticos", metodos[i], sep = "_"),
      agrupamientos[niveles %in% metodos2[i]]
    )
  }

  # poblar una lista de listas con listas correspondientes a cada metodos de distancia con agrupaciones
  Agrupamientos_cofeneticos <- lapply(ls(pattern='agrupamientos_cofeneticos'), get, envir = sys.parent(0))

  # nombrar todos los elementos de la lista de listas agrupadas, a partir de sus propiedades
  for(i in 1:length(Agrupamientos_cofeneticos)){
    names(Agrupamientos_cofeneticos)[i] <- paste(
      str_replace_all(Agrupamientos_cofeneticos[[i]][[1]]$dist.method, " ", "_"),
      sep = "_")
  }

  # ordenar el vector de metodos
  metodos <- sort(metodos)

  # volver global
  Agrupamientos_cofeneticos <<- Agrupamientos_cofeneticos

  # ordenar lista de distancias
  Distancias <- distancias[sort(names(distancias))]

  # crear vector vacio para guardar valores de indices cofeneticos
  indices_cofeneticos <- character()

  # Simple Matching coefficient
  for(i in 1:length(metodos)){
    for(j in 1:length(grupos)){
      CI <- cophenetic(Agrupamientos_cofeneticos[[i]][[j]])
      CI_final <- cor(Distancias[[i]], CI)
      indices_cofeneticos <- c(indices_cofeneticos,
                               capture.output(cat((paste(Agrupamientos_cofeneticos[[i]][[j]]$dist.method,
                                                         Agrupamientos_cofeneticos[[i]][[j]]$method,
                                                         " = ", round(CI_final, 8))), " "))
      )
    }
  }

  # separar numeros de caracteres
  indices_cofeneticos <- str_split_fixed(indices_cofeneticos, " = ", 2)

  # convertir control en data frame
  indices_cofeneticos <- as.data.frame(indices_cofeneticos)

  # coercionar segunda columna de character a double
  indices_cofeneticos[, 2] <- as.double(indices_cofeneticos[, 2])

  # ordenar por valor de indice cofenetico
  indices_cofeneticos <- indices_cofeneticos[order(indices_cofeneticos[, 2], decreasing = T),]

  # remover espacios en blanco
  indices_cofeneticos <- as.data.frame(lapply(indices_cofeneticos, trimws))

  # cambiar espacios " " por guion bajo "_"
  indices_cofeneticos$V1 <- str_replace_all(indices_cofeneticos$V1, " ", "_")

  # asignar nombres de columnas
  colnames(indices_cofeneticos) <- c("Combinacion_distancia_agrupamiento", "Valor_IndiceCofenetico")

  # volver global
  indices_cofeneticos <<- indices_cofeneticos

  # guardar archivo
  write_csv(indices_cofeneticos,
            paste(ruta,"indices_cofeneticos.csv", sep = "")
  )


  # obtener en vector la mejor combinacion segun ind cofenetico
  metodo_hclust <- unlist(str_split(
    string = indices_cofeneticos[1,1],
    pattern = "_"))

  # obtener el mejor metodo de aglomeracion
  metodo_hclust <- metodo_hclust[length(metodo_hclust)]

  # graficar y guardar correlacion
  tiff(paste(ruta, "Correlacion.tiff", sep = ""),
       res = 300,
       width = 2000,
       height = 2000)

  corrplot(cor(matriz),
           type = "upper",
           method = "ellipse",
           order = "hclust",
           hclust.method = metodo_hclust,
           tl.cex = 0.9)
  dev.off()

  ####### dendograma con bootstrap, 1000, paquete pvclust, version 2.2-0 ########
  dendro <- pvclust(matriz,
                    method.hclust = metodo_hclust,
                    method.dist = "binary",
                    nboot = 1000,
                    iseed = TRUE)

  # visualizar el dendograma con titulo, entre otras
  tiff(paste(ruta, "Dendrograma.tiff", sep = ""), res = 300,
       width = 2000,
       height = 2000)

  plot(dendro,
       hang = -2,
       cex = 0.8,
       main = paste(especie, "binary / UPGMA"))
  
  # vector con los nombres de las mejores combinaciones dist-clust
  mejores <- indices_cofeneticos[1:4, 1]

  # subset con los mejores combinaciones dist-clust
  mejores_agrupamientos <- agrupamientos[mejores]

  ################ Conclusiones Indices Cofeneticos ################

  # arrojar a consola el la mejor
  for(i in 1:4){
    cat("\nLos mejores agrupamientos son:\t",i, "\t",
        indices_cofeneticos[i, 1], "\t=\t",
        indices_cofeneticos[i, 2])
  }
  cat("\n")
  ######### Creación dendogramas. paquete: stats, version 4.0.1 #################

  # crear dendrogramas solo de los mejores 4 combinacion de matrices de distancia y metodos de agrupamiento
  for(i in 1:4){
    assign(
      paste("best", names(mejores_agrupamientos)[i], sep = "_"),
      as.dendrogram(mejores_agrupamientos[[i]])
    )
  }

  # crear y poblar una lista de listas con listas correspondientes a cada metodos de distancia con agrupaciones
  Best_dendros <<- lapply(ls(pattern="best_"), get, envir = sys.parent(0))

  ################ regla de la mayoria ###############

  # realizar prueba de la mayoria
  mayoria <- capture.output(
    NbClust(matriz,
            diss = NULL,
            distance = "binary",
            min.nc=2,
            max.nc=17,
            method = metodo_hclust,
            index = "all")
  )

  # obtener conclusion solamente
  proporciones <- sort(mayoria[grepl("proposed", mayoria)], decreasing = T)
  conclusion <- mayoria[grepl("According to the majority rule, the best number of clusters is", mayoria)]

  # imprimir conclusiones de todos los metodos

  # imprimir el numero optimo de clusters segun ña regla de la mayoria,
  # asi como las conclusiones
  cat("\n", conclusion, "\n\n")

  for(i in proporciones){
    print(i)
  }

  # obtener el numero optimo de clusters
  nc_optimo <- as.integer(gsub("\\D", "", conclusion))

  ###### visualizacion de dendogramas. paquete: factoextra, version 1.0.7 #######

  for(i in 1:length(Best_dendros)){

    # visualizacion  mas común en rectangulos
    tiff(paste(ruta, paste(especie, "_", names(mejores_agrupamientos)[i]), ".tiff", sep = ""),
         res = 350,
         width = 2500,
         height = 2500)

    print(fviz_dend(
      Best_dendros[[i]],
      cex = 0.9,
      k = nc_optimo,
      color_labels_by_k = FALSE,
      type = "rectangle",
      main = paste(especie,"/",
                   str_replace_all(names(mejores_agrupamientos)[i], "_", " ")
      )
    )
    )
    dev.off()

    # visualizacion  mas común en rectangulos, horizontales
    tiff(paste(ruta, paste(especie, "_",names(mejores_agrupamientos)[i]), "_horizontal.tiff", sep = ""),
         res = 350,
         width = 2500,
         height = 2500)

    print(fviz_dend(
      Best_dendros[[i]],
      cex = 0.9,
      k = nc_optimo,
      rect = TRUE,
      horiz = TRUE,
      color_labels_by_k = FALSE,
      type = "rectangle",
      main = paste(especie, "/",
                   str_replace_all(names(mejores_agrupamientos)[i], "_", " ")
      )
    )
    )
    dev.off()

  }

  ######## calculo de Heterocigocidad de forma manual y del PIC usando polysat ########

  # contar numero de individuos con cada marcador
  matriz$Conteo <- rowSums(matriz)

  # obtener lista de locus
  locs <- character()
  for(i in 2:nrow(matriz)){
    locs <- c(locs,
              capture.output(cat(
                (str_split(row.names(matriz), "_")[[i]][1])
              ))
    )
  }

  # valoes uincos de locus
  locs_unicos <- unique(locs)

  # crear y poblar una lista de dataframes correspondientes a los diferentes locus encontrados en la matriz
  locs_lista <- list()
  for(i in 1:length(locs_unicos)){
    locs_lista[[i]] <- matriz[grepl(paste(locs_unicos[i], "_", sep = ""), row.names(matriz)),]
  }

  # asignar nombres a lista de locs (dataframes separados por locus)
  for(i in 1:length(locs_unicos)){
    names(locs_lista)[i] <- locs_unicos[i]
  }

  # crear columnas necesarias para calculos
  for(i in 1:length(locs_unicos)){
    locs_lista[[i]]$Frecuencia <- locs_lista[[i]]$Conteo / ncol(matriz[grepl("IND",colnames(matriz))])
    locs_lista[[i]]$Corregida <- locs_lista[[i]]$Frecuencia/sum(locs_lista[[i]]$Frecuencia)
    locs_lista[[i]]$Cuadrada <-  locs_lista[[i]]$Corregida^2
  }

  # crear vector vacio para guardar valores de heterocigocidad
  H_calc <- character()
  # sumar columna de frecuencias al cuadrado
  for(i in 1:length(locs_unicos)){
    H_calc  <- c(H_calc,
                 capture.output(
                   cat(
                     paste(locs_unicos[i],
                           1 - sum(locs_lista[[i]]$Cuadrada),
                           sep = " = "))
                 )
    )
  }

  # volver global
  locs_lista <<- locs_lista

  # separar en dos columnas
  H_calc <- str_split_fixed(H_calc, " = ", 2)

  # convertir control en data frame
  H_calc <- as.data.frame(H_calc)

  # coercionar segunda columna de character a double
  H_calc[, 2] <- as.double(H_calc[, 2])

  # remover espacios en blanco
  H_calc <- as.data.frame(lapply(H_calc, trimws))

  # asignar nombres de columnas
  colnames(H_calc) <- c("Marcador", "Heterocigocidad")

  H_calc$Heterocigocidad <- round(as.double(H_calc$Heterocigocidad), 3)

  # volver global
  Heterocigocidad <<- H_calc

  # guardar archivo de valores de PIC final
  write_csv(Heterocigocidad,
            paste(ruta, "Heterocigocidad.csv", sep = "")
  )

  ######## obtener vector de columna de fracciones corregidas ##########

  # crear vector de valores corregidos para todos los locus
  locs_df <- do.call("rbind", locs_lista)

  # modificar nombres de filas
  rownames(locs_df) <- row.names(matriz)

  # obtener vector de datos de frecuencias corregidas
  locs_vec <- locs_df$Corregida

  # asignar nombres a locs_vec
  names(locs_vec) <- row.names(locs_df)

  ####### crear componentes de matriz de frecuencias para calculo de pic ########
  # numero de genomas y especie
  myfreq_1 <- data.frame(row.names = especie,
                         Genomes = ncol(matriz) - 1)

  # datos de frecuencia corregida para todos los locus
  myfreq_2 <- as.data.frame(locs_vec)
  myfreq_2 <- as.data.frame(t(myfreq_2))

  # cambiar nomres de columnas _ por .
  nombres <- str_replace_all(names(myfreq_2), "_", ".")
  colnames(myfreq_2) <- nombres

  # crear data frame de frecuencias
  myfreq <<- cbind(myfreq_1, myfreq_2)

  # calcular el PIC
  PolyInfCont <- as.data.frame(
    round(
      PIC(myfreq, bypop = TRUE, overall = FALSE),
      3)
  )

  # transponer
  PolyInfCont <- as.data.frame(t(PolyInfCont))

  # agregar interpretacion
  PolyInfCont$Interpretacion <- case_when(
    PolyInfCont[, 1] < 0.3 ~ "No Informativo",
    PolyInfCont[, 1] > 0.3 & PolyInfCont[, 1] < 0.59 ~ "Moderadamente Informativo",
    PolyInfCont[, 1] > 0.60 ~ "Muy Informativo"
  )

  # agregar nombres de columnas
  colnames(PolyInfCont) <- c("PIC", "Interpretacion")

  # volver nombres de filas en una columna
  PolyInfCont$Marcador <- row.names(PolyInfCont)

  # reordenar columnas
  PolyInfCont <- PolyInfCont[,c("Marcador", "PIC", "Interpretacion")]

  # volver global
  PolyInfCont <<- PolyInfCont

  # guardar archivo de valores de PIC final
  write_csv(PolyInfCont,
            paste(ruta, "PIC.csv", sep = "")
  )

}
