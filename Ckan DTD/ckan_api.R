
install.packages("ckanr")

library(ckanr)
library(httr)
library(urltools)


ckanr_setup(url = "https://datos.ciudaddemendoza.gob.ar", key = "")

tag_list(
  query = NULL,
  vocabulary_id = NULL,
  all_fields = FALSE,
  url = get_default_url(),
  key = get_default_key(),
  as = "list")

# check si el server está caído o corriendo
ping() # T = corriendo

# Información de la instancia
ckan_info()

servers()

# listas de elementos
package_list()
organization_list()
group_list()


# Buscar algún recurso de un paquete al que tengamos acceso como DTD a partir de las organizaciones

organization_show(id = "transformacion_digital", include_datasets = TRUE, as = "list")$packages

organization_show(id = "transformacion_digital", include_datasets = TRUE, as = "list")$packages[[2]]

package_show(id = "12150e43-6c48-49b4-a29e-47a2518b45bc", include_datasets = TRUE, as = "list")

package_show(id = "12150e43-6c48-49b4-a29e-47a2518b45bc", include_datasets = TRUE, as = "list")$resources


# Intento de crear un recurso con POST ------------------------------------



# id = "12150e43-6c48-49b4-a29e-47a2518b45bc"
# title = "Resultados electorales PASO Mendoza 2023"
# name = "resultados-electorales-paso-mendoza-2023"
# url = "https://datos.ciudaddemendoza.gob.ar/dataset/resultados-electorales-paso-mendoza-2023"


example_df <- data.frame(
  ID = 1:5,
  Name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  Age = c(24, 30, 22, 35, 28),
  City = c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix")
)

write.csv(example_df, file = paste0(getwd(), "/example_df.csv"), row.names = FALSE)


resource_create(
  package_id = "12150e43-6c48-49b4-a29e-47a2518b45bc",
  rcurl = "https://datos.ciudaddemendoza.gob.ar/dataset/resultados-electorales-paso-mendoza-2023",
  revision_id = NULL,
  description = "df_prueba",
  format = NULL,
  hash = NULL,
  name = "prueba_POST",
  resource_type = NULL,
  mimetype = NULL,
  mimetype_inner = NULL,
  webstore_url = NULL,
  cache_url = NULL,
  size = NULL,
  created = NULL,
  last_modified = NULL,
  cache_last_updated = NULL,
  webstore_last_updated = NULL,
  upload = paste0(getwd(), "/example_df.csv"),
  extras = NULL,
  http_method = "POST",
  url = get_default_url(),
  key = get_default_key(),
  as = "list"
)





