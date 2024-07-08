
library(ckanr)
library(httr)
library(urltools)
library(dplyr)
library(tidyr)

ckanr_setup(url = "https://datos.ciudaddemendoza.gob.ar", key = "")

ping() # T = corriendo


## Loop through each package to get resource details
rm(package_info, resources_df, resources_data, resource_n)

# Function to retrieve all packages with pagination
get_all_packages <- function() {
  all_packages <- list()
  limit <- 100
  offset <- 0
  
  repeat {
    packages <- package_list(as = "table", limit = limit, offset = offset)
    if (length(packages) == 0) break
    all_packages <- c(all_packages, packages)
    offset <- offset + limit
  }
  
  return(all_packages)
}

packages <- get_all_packages()

resources_data <- data.frame() # Initialize a list to store the data

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
      
      resource_id = package_info$resource$id[resource_n],
      resource_name = package_info$resource$name[resource_n],
      resource_url = package_info$resource$url[resource_n],
      resource_format = package_info$resource$format[resource_n],
      stringsAsFactors = FALSE
    ))
  }
}



