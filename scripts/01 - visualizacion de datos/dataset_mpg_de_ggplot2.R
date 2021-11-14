#Visualizacion de informacion - 11 de Noviembre de 2021
install.packages('tyidiverser', 'gapminder', 'nycflights13', 'Lahman')
library(tyidiverser, gapminder, nycflights13, Lahman)

# ---- tidyverse 1.3.1 ----
# v ggplot2 3.3.5     v purrr   0.3.4
# v tibble  3.1.4     v dplyr   1.0.7
# v tidyr   1.1.3     v stringr 1.4.0
# v readr   2.0.1     v forcats 0.5.1

# 1 - ¿Los coches con motor mas grande consumen mas combustible que los coches con motor mas pequeño? 
# 2 - ¿La relacion consumo/tamaño es lineal? es no lineal? es exponencial? es positiva?

View(mpg)
help(mpg)
help(ggplot2)
# displ: tamaño del motor del coche en litros
# hwy: número de millas recorridas en autopista por galón de combustible

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy))

# Platilla para hacer una representacion grafica con ggplot
# ggplot(data = <DATA_SET>) +
#   <GEOM_FUNCION>(mapping = aes(<MAPPINGS>))


# Color de los puntos
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy, color=class))

# Tamaño de los puntos (conviene que sea numérico)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy, size=class))

# Transparencia de los puntos
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy, alpha=class))

# Forma de los puntos (solo permite 6 formas a la vez)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy, shape=class))

# Condiciones
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy, color=displ < 4))

# Eleccion manual de esteticas
# Color = nombre color en string
# size = tamaño del punto en mm
# shape = forma del punto con numeros del 0 al 25

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy), color='red')

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy),
            shape=23, size=5,  color='red', fill='yellow')

# CREAR AGRUPACIONES
# FACETS
# facet_wrap(~<FORMULA_VARIABLE>): La variable debe ser discreta o cualitativa

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy)) +
  facet_wrap(~class, nrow=2)

# AGRUPAR DOS VARIABLES
# facet_grid(<FORMULA_VARIABLE_1>~<FORMULA_VARIABLE_2>):

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y= hwy)) +
  facet_grid(drv~cyl)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~class, nrow = 3)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv~.)

# Diferentes geometrias

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
  
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group= drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype= drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype= drv, color=drv))

# Combinar geometrias

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color=drv)) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv, color=drv))

# Evitar duplicidad en multiples graficas

ggplot(data = mpg, mapping = aes(x = displ, y = hwy, color=drv)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(mapping = aes(color = drv))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == 'suv'))

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(data = filter(mpg, class == 'suv'), se = F)


ggplot(data = mpg, mapping = aes(x=displ, y = hwy,color = drv)) + 
  geom_point() + 
  geom_smooth( se = F)

ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(shape = drv, color=drv)) + 
  geom_smooth(se=F)

ggplot(data = mpg, mapping = aes(x=displ, y = hwy)) + 
  geom_point(mapping = aes(shape = drv, color=drv)) + 
  geom_smooth(mapping = aes(linetype = drv), se=F)

# Transformaciones estadisticas básicas

## Ejemplo de dataset de diamantes
View(diamonds)

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))

#creando un subconjutno para realzar el ejemplo
demo_diamons = tribble(
  ~cut,        ~freqs,
  "Fair",        1610,
  "Good",        4906,
  "Very Good",  12082,
  "Premium",    13791,
  "Ideal",      21551
)


ggplot(data = demo_diamons) + 
  geom_bar(mapping = aes(x = cut, y = freqs), stat = 'identity')

# Proporcion, el group=1 es para indicar que sume las filas (elementos del eje x)
ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, y = ..prop.., group=1))

ggplot(data = diamonds) + 
  stat_summary(mapping = aes(x = cut, y = depth),
               fun.min = min,
               fun.max = max,
               fun = median
               )

# Colores y formas de los graficos

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, colour = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = cut))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = clarity))

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color))

## Position = "identity" --> Todas la barras empiezan en 0, loq ue hace que algunas barras queden ocultas

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(alpha = 0.2, position = "identity")

ggplot(data = diamonds, mapping = aes(x = cut, colour = clarity)) + 
  geom_bar(fill = NA, position = "identity")

## Position = "fill" --> se utiliza para los porcentajes

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(position = "fill")


## Position = "dodge" --> Coloca objetos que tengan overlaping(identity) uno al lado del otro

ggplot(data = diamonds, mapping = aes(x = cut, fill = clarity)) + 
  geom_bar(position = "dodge")

## Volvemos al scatterplot
## position = "jitter" --> quita los puntos superpuestos y muetra todo los puntos de la grafica
ggplot(data = mpg, mapping = aes(x = displ, y= hwy)) +
  geom_point(position = "jitter")

ggplot(data = mpg, mapping = aes(x = displ, y= hwy)) +
  geom_jitter()


?position_stack
?position_fill
?position_identity
?position_dodge
?position_jitter

# Sistemas de coordenadas

#coord_flip() -> Invierte de X e Y

ggplot(data = mpg, mapping = aes(x = class, y= hwy)) +
  geom_boxplot()

ggplot(data = mpg, mapping = aes(x = class, y= hwy)) +
  geom_boxplot() +
  coord_flip()

# coord_quickmap() -> configura el aspect ratio para mapas

usa = map_data("usa")
ggplot(data = usa, mapping = aes(long, lat, group = group)) +
  geom_polygon(fill = "blue", color = "white") + 
  coord_quickmap()

italy = map_data("italy")
ggplot(data = italy, mapping = aes(long, lat, group = group)) +
  geom_polygon(fill = "blue", color = "white") + 
  coord_quickmap()


# coord_polar()

ggplot(data = diamonds, mapping = aes(x = cut, fill= cut)) +
  geom_bar(show.legend = F, width = 1) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL) +
  coord_polar()

# Gramatica por capas de ggplot2

# Platilla para hacer una representacion grafica con ggplot
# ggplot(data = <DATA_SET>) +
#   <GEOM_FUNCION>(
#               mapping = aes(<MAPPINGS>),
#               stat = <STAT>,
#               position = <POSITION>
#               ) +
# <COORD_FUNCTION>() +
# <FACET_FUNCTION>()

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = clarity, fill = clarity, y = ..count..)) +
  coord_polar() +
  facet_wrap(~cut)+
  labs(x = NULL, y = NULL, title="Ejemplo final",
       caption="Dos variabes cruzadas de diamaons",
       subtitle = "subtitulo")

ggplot(data = diamonds) + 
  geom_bar(mapping = aes(x = cut, fill = color))+ 
  theme(aspect.ratio = 1) + 
  labs(x = NULL, y = NULL) + 
  coord_polar()

ggplot(data = mpg, mapping = aes(x = cty, y = hwy )) + 
  geom_point() + 
  geom_abline() + 
  coord_fixed()

