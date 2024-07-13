
library(ckanr)
library(httr)
library(urltools)
library(dplyr)
library(tidyr)
library(lubridate)

ckanr_setup(url = "https://datos.ciudaddemendoza.gob.ar", key = "")

ping() # T = corriendo

# Get the list of packages
packages <- package_list(as = "table")

# Loop through each package to get resource details

rm(package_info, resources_df, resources_data, resource_n)

# Initialize a list to store the data
resources_data <- data.frame()

# Loop through each package to get resource details
for (package_id in packages) {
  package_info <- package_show(id = package_id, as = "table")

  for (resource_n in 1:length(package_info$resources$id)) {
    
    resources_data <- rbind(resources_data, data.frame(
      package_name = package_info$title,
      package_description = package_info$notes,
      package_id = package_info$id,
      organization = ifelse(is.null(package_info$organization), NA, package_info$organization$title),
      package_url = package_info$url,
      package_responsible = package_info$author,
      package_mantainer = package_info$maintainer,
      package_mantainer_mail = package_info$maintainer_email,
      last_updated = package_info$metadata_modified,
      act_periodicity = package_info$extras[which(package_info$extras$key == "accrualPeriodicity"), "value"],
      timediff_acualizacion = as.numeric(difftime(today(), as.Date(as.POSIXct(package_info$metadata_modified), format = "%d-%m-%Y"))),
      
      resource_id = package_info$resource$id[resource_n],
      resource_name = package_info$resource$name[resource_n],
      resource_url = package_info$resource$url[resource_n],
      resource_format = package_info$resource$format[resource_n],
      stringsAsFactors = FALSE
    ))
  }
}

length(unique(resources_data$package_id))
table(resources_data$act_periodicity)



         