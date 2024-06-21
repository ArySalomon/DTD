
install.packages("ckanr")

library(ckanr)
library(httr)

ckanr_setup(url = "https://datos.ciudaddemendoza.gob.ar", key = "")

package_list()
organization_list()
group_list()

# Buscar algún recurso de un paquete al que tengamos acceso como DTD a partir de las organizaciones
organization_show(id = "transformacion_digital", include_datasets = TRUE, as = "list")$packages[[6]]

# id = "c5d4c418-fc1b-4cad-b66d-acae566d5c6a"
# title = "Bancos"
# name = "bancos-ciudad"
# url = "http://datos.ciudaddemendoza.gob.ar/dataset/bancos-ciudad"


example_df <- data.frame(
  ID = 1:5,
  Name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  Age = c(24, 30, 22, 35, 28),
  City = c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix")
)

write.csv(example_df, file = paste0(getwd(), "/example_df.csv"), row.names = FALSE)


resource <- resource_create(
  package_id = "bancos-ciudad",
  name = "Example Data Resource",
  description = "exampledf description",
  format = "CSV",
  mimetype = "text/csv",
  upload = paste0(getwd(), "/example_df.csv")
)



