# calculo del spi para varias estaciones en un mismo archivo
# Darwin Rosero Vaca
# darwin11rv@gmail.com

#Importar libreria SPEI

library("SPEI")
library(readr)

#Importar DATASET
#Puede hacer clic derecho en su archivo > Propiedades y copiar y pegar la ubicación
#improtar el dataset con read_limint para asegurarse de qeu se creara un dataframe y no un list
#ruta del archivo de datos
#############################
#    Seccion a modificar    #
#############################
ardat<-"/cloud/project/"

#nombre del archivo de datos
nomDatos <- "Dat_guate.csv"
###

DATOS <- read_delim(paste(ardat,nomDatos,sep=""), delim=";",col_types = cols())
#### es importante que las columnas tengan el mismo nombre que el archivo de prueba
print(names(DATOS))
#Crear la lista de estaciones en el archivo de entrada
Estaciones <- c("SANTIAGO","VALPARAISO")
#Determinar la escala de spi SPI
a <- 12 
#Calcula el SPI y crea una variable llamada SPI_"NOMBRE.ESTACIÓN"_a, donde a=Escala de SPI
for (i in Estaciones) {
  print(i %in% DATOS$NAME)
  if(i %in% DATOS$NAME){
    ## se filtra el dataframe para que solo devuelva los datso de esa estacion
    est <- DATOS[ which(DATOS$NAME==i ),]
    write.table(spi(est$PRCP,a)$fitted,file=paste(ardat,paste("SPI",i,a,sep = "_"),sep = "/"))
  }
}
