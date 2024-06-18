install.packages("ckanr")


library(ckanr)
library(httr)



package_list()
organization_list()
group_list()

example_df <- data.frame(
  ID = 1:5,
  Name = c("Alice", "Bob", "Charlie", "David", "Eve"),
  Age = c(24, 30, 22, 35, 28),
  City = c("New York", "Los Angeles", "Chicago", "Houston", "Phoenix")
)



# package_create(
#   name = "my-new-dataset",
#   title = "My New Dataset",
#   private = F,
#   author = "Dirección de Transformación Digital, Smart Cities y Gobierno Abierto",
#   author_email = NULL,
#   maintainer = NULL,
#   maintainer_email = NULL,
#   license_id = NULL,
#   notes = NULL,
#   package_url = NULL,
#   version = NULL,
#   state = "active",
#   type = NULL,
#   resources = NULL,
#   tags = NULL,
#   extras = NULL,
#   relationships_as_object = NULL,
#   relationships_as_subject = NULL,
#   groups = list("Salud"),
#   owner_org = "transformacion_digital",
#   url = get_default_url(),
#   key = get_default_key(),
#   as = "list")



write.csv(example_df, file = paste0(getwd(), "/example_df.csv"), row.names = FALSE)


resource_create(
  package_id = "acequias",
  http_method = "POST",
  rcurl = paste0(get_default_url(), "/dataset/", "acequias"),
  url = get_default_url(),
  key = get_default_key(),
  name = "Example Data Resource",
  description = "exampledf",
  format = "CSV",
  upload = paste0(getwd(), "/example_df.csv"),
  as = "list"
)











