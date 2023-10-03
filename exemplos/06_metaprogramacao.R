
dplyr
tidyverse
n
x

minha_library <- function(pacote) {
  pacote
}

minha_library(tidyverse)

library(tidyverse)

mtcars$mpg

media <- function(tabela, col) {
  mean(tabela$col, na.rm = TRUE)
}

mtcars |>
  mutate(mpg = mpg * 2) |>
  filter(mpg < 30) |>
  media(mpg)

summarise_mean <- function(df, col) {
  summarise(df, media = mean({{ col }}))
}

mtcars |>
  summarise_mean(cyl)

summarise_mean <- function(df, col) {
  summarise(df, {{ col }} := mean({{ col }}))
}

mtcars |>
  summarise_mean(cyl)

mtcars[["cyl"]]

mutate(
  cyl = cyl * 2,
  mpg = mpg * 2,
  ...
)

# -----

mtcars |>
  group_by(gear) |>
  summarise(
    cyl = mean(cyl),
    mpg = median(mpg),
    carb = sd(carb)
  )


group_summarise <- function(df, col, ...) {
  df |>
    group_by({{ col }}) |>
    summarise(...)
}

mtcars |>
  group_summarise(
    gear,
    cyl = mean(cyl),
    mpg = median(mpg),
    carb = sd(carb)
  )

rotulo <- function(df, ...) {
  df |>
    summarise(
      colA = "A",
      colB = 1,
      ...,
      colC = TRUE
    )
}

mtcars |>
  group_by(gear) |>
  rotulo(
    cyl = mean(cyl),
    mpg = median(mpg),
    carb = sd(carb)
  )


