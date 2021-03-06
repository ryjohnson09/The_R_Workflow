library(plumber)
library(pins)
library(tidymodels)

# Retrive pinned model
board <- board_rsconnect("envvar", server = "https://colorado.rstudio.com/rsc")
penguins_model <- pin_read(board, "ryan/Penguins_Model")

#* @apiTitle Male or Female Penguin?

#* @apiDescription Return the probability of male or female based on penguin body characteristics and species

#* @param species Species of penguin (Adelie, Gentoo, Chinstrap)
#* @param bill_length_mm:numeric Bill length in millimeters (eg. 38.6)
#* @param bill_depth_mm:numeric Bill depth in millimeters (eg. 17.4)
#* @param flipper_length_mm:numeric Flipper length in millimeters (eg. 180)
#* @param body_mass_g:numeric Body mass in grams (eg. 3400)
#* @get /pred

function(species, bill_length_mm, bill_depth_mm, flipper_length_mm, body_mass_g){
  
  # Create table for predictions
  pred_tibble <- data.frame(
    species = species,
    bill_length_mm = as.numeric(bill_length_mm),
    bill_depth_mm = as.numeric(bill_depth_mm),
    flipper_length_mm = as.numeric(flipper_length_mm),
    body_mass_g = as.numeric(body_mass_g)
  )
  
  # Predict if male or female penguin
  predict(penguins_model, pred_tibble, type = "prob")
}


