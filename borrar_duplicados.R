## Borrar registros duplicados
#####################

SpObj <- read.csv("Datos/limpios/peces_objetivo2002-2015.csv", sep = ";")

duplicados <- duplicated(SpObj)

duplicados2 <- SpObj[duplicados, ]

no_duplicados <-SpObj[!duplicados, ]

write.csv(no_duplicados, file = "peces_objetivo.csv", row.names = F)

peces_objetivo <- no_duplicados

save(peces_objetivo, file ="peces_objetivo.RData")
