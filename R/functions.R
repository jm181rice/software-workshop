
fahr_to_kelvin <- function(temp) {
  kelvin <- ((temp - 32) * (5/9)) + 273.5
  return(kelvin)
}

kelvin_to_celsius <- function(temp) {
  celsius <- temp - 273.5
  return(celsius)
}

fahr_to_celsius <- function(temp) {
  kelvin <- fahr_to_kelvin(temp)
  celsius <- kelvin_to_celsius(kelvin)
  return(celsius)
}
