library(tidyverse)

# fatores -> ordenado
mes_fev <- month("2001-02-03", label = TRUE, locale = "pt_BR")

as.numeric(mes_fev)

levels(mes_fev)

mes_fev < "Abr"


# criar um factor


fct(c("União estável", "Solteiro", "Casado", "Viúvo",
      "Divorciado", "Outro", "Casado", "Casado"))


fct(c("União estável", "Solteiro", "Casado", "Viúvo",
      "Divorciado", "Outro", "Casado", "Casado"),

    levels = c("Solteiro", "União estável", "Casado",
               "Divorciado", "Viúvo", "Outro"))


# install.packages("dados")
library(dados)

casas <- dados::casas |>
  rename(q = geral_qualidade, v = vizinhanca) |>
  filter(!q %in% c(
    "muito ruim", "Muito excelente", "regular", "muito boa"
  ))

meu_plot <- function(dados, var) {
  dados |>
    ggplot(aes(n, {{var}}, fill = {{var}})) +
    geom_col(show.legend = FALSE) +
    theme_minimal() +
    theme(text = element_text(size = 16))
}


casas |>
  count(q) |> # dplyr
  meu_plot(q)


casas |>
  select(qualidade_texto = q) |>
  mutate(qualidade_fator = fct(
    qualidade_texto,
    levels = c(
      "ruim",
      "abaixo da média",
      "média",
      "acima da média",
      "boa",
      "excelente"
    )
  )) |>
#  arrange(qualidade_fator)
  count(qualidade_fator) |>
  meu_plot(var = qualidade_fator)



casas |>
  select(qualidade_texto = q) |>
  mutate(qualidade_fator = fct(
    qualidade_texto,
    levels = c(
      "ruim",
      "abaixo da média",
      "média",
      "acima da média",
      "boa",
      "excelente"
    )
  ),
  qualidade_fator_rev = fct_rev(qualidade_fator)
  ) |>
  #arrange(qualidade_fator_rev) |>
  count(qualidade_fator_rev) |>
  meu_plot(var = qualidade_fator_rev)

# ----------------------------------

casas |>
  select(vizinhanca = v) |>
  count(vizinhanca, sort = TRUE) |>
  meu_plot(vizinhanca)


casas |>
  select(vizinhanca = v) |>
  mutate(vizinhanca_com_outros = fct_lump(vizinhanca,
                                          n = 15,
                                          other_level = "Outros")) |>
  count(vizinhanca_com_outros, sort = TRUE) |>
  mutate(vizinhanca_fct = fct_reorder(vizinhanca_com_outros, n),
         vizinhanca_fct = fct_relevel(vizinhanca_fct, "Outros"),
         vizinhanca_fct = fct_recode(vizinhanca_fct, "Bairro da Universidade" =  "South & West of Iowa State University")) |>
  meu_plot(vizinhanca_fct)

# PRATICA

url <- "https://github.com/curso-r/livro-material/raw/master/assets/data/imdb.rds"

imdb <- read_rds(url)

# dúvida thiago
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


# duvida Luiz

df <- tibble(partido = c("a", "a",
                         "b", "b",
                         "c", "c"),
             genero = c("m", "h",
                        "m", "h",
                        "m", "h"),
             total = c(20, 10,
                       3, 5,
                       10, 10))

# Fazendo o gráfico:


cat_ordem <- df |>
  pivot_wider(names_from = genero, values_from = total) |>
  mutate(prop = m/h) |>
  arrange(prop) |>
  pull(partido)

df |>
  mutate(partido = fct(partido, levels = cat_ordem)) |>
  ggplot() +
  aes(
    x = partido,
    fill = genero,
    weight = total
  ) +
  geom_bar(position = "fill")


