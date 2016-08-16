###############
# Descargar los niveles tróficos de las especies de peces de Isla San Pedro Martir
##############

library(rFishbase)
library(dplyr)
library(tidyr)

lista_sp <- read.csv("./Datos/ListadoPecesSinArreglar.csv", sep=";")

colnames(lista_sp)=c('Orden',
                     'Familia',
                     'Genero',
                     'Especie',
                     'sciname',
                     'NombreComun',
                     'Region',
                     'RecursoDeportivo',
                     'RecursoPesquero',
                     'RecursoOrnamental',
                     'NOM-059',
                     'PeligroCritico',
                     'EnPeligro',
                     'Vulnerable',
                     'CasiAmenazada',
                     'PreocupacionMenor',
                     'ListadaDatosDeficientes',
                     'NoEvaluada',
                     'CartaNacionalPesquera',
                     'Exoticos',
                     'Endemicos',
                     'Herbivoros',
                     'NivelTrofico',
                     'a',
                     'b')

lista_sp <- lista_sp %>%
  filter(!sciname=="Caranx bartholomaei")

#Verificar nombres de especies
# 
# lista <- as.data.frame(resolve(lista_sp$sciname)) %>%
#   filter (gnr.score < 0.98) %>%
#   filter (gnr.data_source_title == "EOL")
# 

#Completar nivel trófico

for (i in 193:length(lista_sp$sciname)) {
  sp = lista_sp$sciname[i]
  print(sp)
  ecology(sp)
}


niveles <- as.data.frame(ecology(lista_sp$sciname,
                                 fields=c("SpecCode", "FoodTroph", "FoodSeTroph", "DietTroph", "DietSeTroph"))) %>%
  select(sciname, DietTroph)

#Completar a y b

ab <- length_weight(lista_sp$sciname,
                    fields=c("a","b", "sciname")) %>%
  group_by(sciname) %>%
  summarize(aa=mean(a), bb=mean(b)) %>%
  select(sciname, a=aa, b=bb)

abnt <- full_join(ab, niveles, by = "sciname") %>%
  select (sciname, a, b, NT=DietTroph)

lista <- left_join(lista_sp, abnt, by = "sciname")

write.csv(lista, file = "./Datos/lista2.csv")

