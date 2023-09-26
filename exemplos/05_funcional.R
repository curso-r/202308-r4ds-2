
print(3)
print(1:100)

list(3, 2, 1)
str(list(3, 2, 1))

list(um = 1, dois = 2, tres = 3)
list(1, dois = 2, 3)
str(list(um = 1, dois = 2, tres = 3))

str(list(TRUE, 123, "ABC"))

list(
  objeto = "abc",
  vetor = c(1, 2, 3),
  lista = list(TRUE, FALSE)
)
list(
  objeto = "abc",
  vetor = c(1, 2, 3),
  lista = list(v = TRUE, f = FALSE)
)
list(
  "abc",
  c(1, 2, 3),
  list(TRUE, FALSE)
)


vetor <- c(5, 4, 3, 2, 1)
vetor[4]

l <- list(
  objeto = "abc",
  vetor = c(1, 2, 3),
  lista = list(TRUE, FALSE)
)

l
str(l)

l[1] # list(objeto = "abc")
l["objeto"]

l[c(2, 3)]
l[2:3]
l[c("vetor", "lista")]
l[-1]

l[[1]]
l[["objeto"]]
l$objeto

i <- 1
l[[i]]
i <- "objeto"
l[[i]]
l$i # DÁ ERRADO

l[[2]]
l[["vetor"]]
l$vetor

l[[3]]
l[["lista"]]
l$lista

l[[3]][1]
l[["lista"]][1]
l$lista[1]

l[[3]][[1]]
l[["lista"]][[1]]
l$lista[[1]]

l <- list(
  objeto = "abc",
  vetor = c(1, 2, 3),
  lista = list(v = TRUE, f = FALSE)
)
l

l[[3]][[1]]
l[[3]][["v"]]
l[[3]]$v

l[["lista"]][[1]]
l[["lista"]][["v"]]
l[["lista"]]$v

l$lista[[1]]
l$lista[["v"]]
l$lista$v

# AUTO-COMPLETE (tab)
l$lista$v

str(list(
  col1 = c("a", "b"),
  col2 = c(1, 2),
  col3 = c(TRUE, FALSE),
  col4 = list(c(1, 3), 2) # list-column!
))

library(tidyverse)
df <- as_tibble(list(
  col1 = c("a", "b"),
  col2 = c(1, 2),
  col3 = c(TRUE, FALSE),
  col4 = list(c(1, 3), 2) # list-column!
))

df$col1
df[[1]]
df[["col1"]]

df$col4[[1]]
df[[4]][[1]]
df[["col4"]][[1]]

# Não funciona! Comprimentos diferentes
as_tibble(list(
  col1 = c("a", "b", "c"),
  col2 = c(1, 2),
  col3 = c(TRUE, FALSE),
  col4 = list(c(1, 3), 2) # list-column!
))

as_tibble(list(
  col1 = c("a", "b", "c"),
  col2 = c(1, 2, NA),
  col3 = c(TRUE, FALSE, NA),
  col4 = list(c(1, 3), 2, NA) # list-column!
))

# Direto, sem a lista intermediária
tibble(
  col1 = c("a", "b"),
  col2 = c(1, 2),
  col3 = c(TRUE, FALSE),
  col4 = list(c(1, 3), 2) # list-column!
)

l <- list(
  objeto = "abc",
  vetor = c(1, 2, 3),
  lista = list(TRUE, FALSE)
)

l |>
  pluck(3, 2) # l[[3]][[2]]

l |>
  pluck("lista", 2) # l[["lista"]][[2]]

l |>
  keep_at(3) # l[3]

l |>
  keep_at("lista") # l["lista"]

l |>
  keep_at(2:3) # l[2:3]

l |>
  keep_at(c("vetor", "lista")) # l[c("vetor", "lista")]

l |>
  discard_at(c("vetor", "lista")) # l[-c("vetor", "lista")]

seq_along(l)
seq_along(5:10)

comprimentos <- c()
for (i in seq_along(l)) {
  comprimentos[i] <- length(l[[i]])
}
comprimentos

l |>
  map(length)

l |>
  map_vec(length)

l |>
  map(length) |>
  list_c()

list_c(l) # Dá erro

"materiais/dados/imdb_2015.csv" |>
  read_csv()

"materiais/dados/imdb_2016.csv" |>
  read_csv()

arqs <- c(
  "materiais/dados/imdb_2015.csv",
  "materiais/dados/imdb_2016.csv"
)

arqs |>
  map(read_csv) |>
  list_rbind()

library(fs)

"materiais/dados/" |>
  dir_ls() |> # glob = "*.csv"
  map(read_csv) |>
  list_rbind()

longo <- function(elemento, limite = 1) {
  length(elemento) > limite
}
map(l, longo)
map2(l, c(1, 2, 3), longo)
map2(l, c(2, 2, 2), longo)

longo_lim2 <- function(x) {
  longo(x, limite = 2)
}
map(l, longo_lim2)

map(l, \(x) longo(x, limite = 2))

n <- list(
  c(1, 2, 3),
  c(3, 2, NA),
  c(2, 1, NA)
)
map(n, mean)

mean_narm <- function(x) {
  mean(x, na.rm = TRUE)
}
map(n, mean_narm)

n |>
  map(\(x) mean(x, na.rm = TRUE))

comprimento <- function(x, nome) {
  str_c(nome, " tem ", length(x), " elemento(s)")
}
map2(l, names(l), comprimento)

map2(l, names(l), \(x, nome) str_c(nome, " tem ", length(x), " elemento(s)"))

comprimento_2linhas <- function(x, nome) {
  len <- length(x)
  str_c(nome, " tem ", len, " elemento(s)")
}

hosp <- tibble(
  id = c(1, 2, 3),
  sintomas = c("dor/tosse/espirro", "dor", "dor/tosse")
)

hosp |>
  mutate(
    sintomas = map(sintomas, \(s) str_split_1(s, "/"))
  ) |>
  unnest(sintomas) |>
  count(sintomas)


hosp2 <- tibble(
  id = c(1, 2, 3),
  sintoma1 = c("dor", "dor", "dor"),
  sintoma2 = c("tosse", NA, "tosse"),
  sintoma3 = c("espirro", NA, NA)
)

hosp2 |>
  unite("sintomas", starts_with("sintoma"), sep = "/", na.rm = TRUE)


