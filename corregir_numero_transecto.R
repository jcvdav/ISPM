########
# Corregir número de transecto
########

library(dplyr)
library(tidyr)

### Para invertebrados

# Cargamos la lista de códigos y transectos
transectos <- read.csv("./Datos/completar_transectos_invertebrados.csv", sep=";") %>%
  select(codigo, transecto)

# cargams la lista de especies
lista_sp <- read.csv("./Datos/lista_inv.csv", sep=";")

# cargamos la base de invertebrados
invertebrados <- read.csv("./Datos/invertebrados_a_completar.csv", sep=";") %>%
  select(-transecto) %>%
  left_join(transectos, by = "codigo") %>% #este left_join agrega los números de transectos
  left_join(lista_sp, by ="GeneroEspecie") %>% #y aquí agregamos las columnas de Genero y Especie
  #En estas siguientes líneas generamos todas las columnas necesarias
  mutate(Dia = dia,
         Mes = mes,
         Ano = año,
         Estado = "Sonora",
         Comunidad = "Bahia de Kino",
         Sitio = sitio,
         Latitud = latitud..N.,
         Longitud = longitud..W.,
         Habitat = "Arrecife Rocoso",
         Zonificacion = Zonificación,
         TipoProteccion = NA,
         ANP = "Reserva de la Biosfera Isla San Pedro Mártir",
         BuzoMonitor = observador,
         HoraInicial = NA,
         HoraFinal = NA,
         ProfundidadInicial = profundidad.real..M.,
         ProfundidadFinal = profundidad.real..M.,
         Temperatura = NA,
         Transecto = transecto,
         Abundancia = cuenta,
         Visibilidad = NA,
         Corriente = NA) %>%
  #Ordenamos las columnas
  select(Dia, Mes, Ano, Estado, Comunidad, Sitio, Latitud, Longitud, Habitat, Zonificacion, TipoProteccion, ANP, BuzoMonitor, HoraInicial, HoraFinal, ProfundidadInicial, ProfundidadFinal, Temperatura, Visibilidad, Corriente, Transecto, Genero, Especie, GeneroEspecie, Abundancia)

write.csv(invertebrados, file = "Datos/invertebrados_completado.csv", row.names = F) #Exportamos los datos como csv

### Para peces

#Cargamos la lista de códigos y transectos
transectos <- read.csv("./Datos/completar_transectos_peces.csv", sep=";") %>%
  select(codigo, transecto)

#Cargamos la lista de especies
lista_sp <- read.csv("./Datos/lista2.csv") %>%
  select(Genero, Especie, GeneroEspecie = sciname)

#cargamos la base de peces
peces <- read.csv("./Datos/peces_a_completar.csv", sep=";") %>%
  select(-transecto) %>%
  left_join(transectos, by = "codigo") %>% #agregamos los números de transecto
  left_join(lista_sp, by ="GeneroEspecie") %>% # y una columna de Genero y una de Especie
  #Agregamos las columnas necesarias
  mutate(Dia = dia,
         Mes = mes,
         Ano = año,
         Estado = "Sonora",
         Comunidad = "Bahia de Kino",
         Sitio = sitio,
         Latitud = latitud..N.,
         Longitud = longitud..W.,
         Habitat = "Arrecife Rocoso",
         Zonificacion = Zonificación,
         TipoProteccion = NA,
         ANP = "Reserva de la Biosfera Isla San Pedro Mártir",
         BuzoMonitor = observador,
         HoraInicial = tiempo.inicio,
         HoraFinal = tiempo.final,
         ProfundidadInicial = profunidad.inicial,
         ProfundidadFinal = profunidad..final,
         Temperatura = temperatura,
         Transecto = transecto,
         Sexo = NA,
         Talla = talla,
         PromedioTalla = NA,
         Abundancia = abundancia) %>%
  #Ordenamos las columnas
  select(Dia, Mes, Ano, Estado, Comunidad, Sitio, Latitud, Longitud, Habitat, Zonificacion, TipoProteccion, ANP, BuzoMonitor, HoraInicial, HoraFinal, ProfundidadInicial, ProfundidadFinal, Temperatura, Visibilidad, Corriente, Transecto, Genero, Especie, GeneroEspecie, Sexo, Talla, PromedioTalla, Abundancia)
  
write.csv(peces, file = "Datos/peces_completado.csv", row.names = F) #Exportamos los datos como csv
