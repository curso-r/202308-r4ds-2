#  Estou com dúvida ao rodar o script abaixo.
# Eu tentei reproduzir o código adaptado ao meu caso utilizando
# a função fct_infreq(),
# fct_lump() e slice_head().
# Mas não estou conseguindo ter sucesso.

library(tidyverse)

url <- "https://github.com/curso-r/livro-material/raw/master/assets/data/imdb.rds"

imdb <- read_rds(url)


imdb |>
  select(titulo, generos) |>
  tibble::rowid_to_column() |>
  separate_longer_delim(generos, delim = ", ") |>
  mutate(generos = fct_lump(generos, n = 10)) |>
  group_by(generos) |>
  summarise(rowid_distintos = n_distinct(rowid)) |>
  mutate(generos = generos |>
           fct_reorder(rowid_distintos) |>
           fct_relevel("Other")) |>
  ggplot() +
  aes(y = generos, x = rowid_distintos) +
  geom_col()

# base reprodutível:

# Vou colocar um df reprodutível abaixo.
# Meu objetivo é plotar um gráfico de barras com as 3 famílias
# com maior número de integrantes, ordenando as barras de forma decrescente.
# Suspeito que é simples a resolução, porém não estou conseguindo entender
# aonde está o erro.


df <- tibble(familia = c("almeida","almeida", "barros", "barros", "barros", "barros", "costa", "silva", "rosa", "rosa", "rosa", "rosa"),
               integrantes = c("bruno", "bernardo", "joão", "hanna", "julia", "bianca", "ricardo", "luiz", "natalia", "dilma", "luiz", "marina"))

# gráfico base
df |>
  # quantas linhas temos por família?
  count(familia, sort = TRUE, name = "quantidade_de_integrantes") |>
  # buscando as 3 famílias com mais integrantes
  slice_max(order_by = quantidade_de_integrantes, n = 3) |>
  ggplot() +
  aes(y = familia, x = quantidade_de_integrantes) |>
  geom_col()


# gráfico base
df |>
  # quantas linhas temos por família?
  count(familia, sort = TRUE, name = "quantidade_de_integrantes") |>
  # buscando as 3 famílias com mais integrante
  slice_max(order_by = quantidade_de_integrantes, n = 3) |>
  # o menos é para ser decrescente
  mutate(familia = fct_reorder(familia, -quantidade_de_integrantes)) |>
  ggplot() +
  aes(y = familia, x = quantidade_de_integrantes) |>
  geom_col()
