#Visualizacion de informacion - 16 de Noviembre de 2021
pacman::p_load(tyidiverser, nycflights13)

# ---- tidyverse 1.3.1 ----
# v ggplot2 3.3.5     v purrr   0.3.4
# v tibble  3.1.4     v dplyr   1.0.7
# v tidyr   1.1.3     v stringr 1.4.0
# v readr   2.0.1     v forcats 0.5.1

?nycflights13::flights # Es un tibble -> un dataframe especializado para ser usado con tidyverse

# tribble
## * int -> números enteros
## * dbl -> números reales (double)
## * chr -> vector de caracteres o strings
## * dttm -> date + time
## * lgl -> logical, variables categóricas
## * date -> fecha (dia, mes, año)

# funciones dplyr (verbos)
## * filter() -> filtrar observaciones (registros/filas) a partir de valores concretos
## * arrange() -> reordenar las filas
## * select() -> seleccionar variables (columnas) por sus nombres
## * mutate() -> crea nuevas varibles (columnas) con funciones a partir de las existencias
## * summarise() -> colapsar varios valores para dar un resumen de los mismos (media , mediana , máximo, etc)

## * groub_by() -> opera la funcion (las descritas previamente) a la que acompaña


# estructura
## 1 - data frame
## 2 - operaciones que queremos hacer a las variables del dataframe
## 3 - resultado en un nuevo data frame, no modifica ni destruye el orginal

### FILTER
  
  jan1 <- filter(flights, month == 1, day == 1)
  nov23 <- filter(flights, month == 11, day == 23)
  
  eneabri <- filter(flights, month >= 1, month <=4 , day >= 10, day <= 15)
  
  filter(flights, month == 5 | month == 6)
  
  may_june <- filter(flights, month %in% c(5,6))
  
  #!(x&y) == (!x) | (!y)
  #!(x|y) == (!x) & (!y)
  
  #los que no se han retrasado mas de una hora:
  filter(flights, !(arr_delay > 60 | dep_delay > 60))
  filter(flights, arr_delay <= 60 & dep_delay <= 60)

  # NA
  
  NA > 0
  10 == NA
  NA + 5
  NA * 5
  NA == NA

  is.na(NA)
  
  df <- tibble(x = c(1,2,NA,3,4,5))
  filter(df, x > 2)
  filter(df, is.na(x) | x > 2)

  ?between()
  
  filter(flights, between(hour, 0, 6))
  
### ARRANGE
  head(flights)
  tail(flights)
  
  ordenados_mes <- arrange(flights, month)
  tail(ordenados_anio)
  
  ordenados_mes_dia <- arrange(flights, month, day)
  tail(ordenados_mes_dia)
  
  ordenados_mes_desc <- arrange(flights, desc(month))
  tail(ordenados_mes_desc)
  
  ordenados_mes_dia_desc <- arrange(flights, month, desc(day))
  tail(ordenados_mes_dia_desc)
  
  # NA
  arrange(df, x)
  arrange(df, desc(x))
  
  

