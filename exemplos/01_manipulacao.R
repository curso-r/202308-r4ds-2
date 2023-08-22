# Já carrega o tidyr e o dplyr
library(tidyverse)

# TIDYR -----------------------------------------------------------------------

# Tabelas que vamos usar
musicas <- select(billboard, track, wk1:wk6)
renda <- select(us_rent_income, NAME, variable, estimate)

musicas |>
  pivot_longer(
    cols = starts_with("wk"), # Colunas que começam com "wk"
    names_to = "semana",      # Nomes das colunas viram "semana"
    values_to = "posicao"     # Valores das colunas viram "posicao"
  )

musicas |>
  select(starts_with("wk"))

musicas |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = semana,        # Não funciona
    values_to = posicao.      # Não funciona
  )

# DPLYR -----------------------------------------------------------------------

alunos <- tibble::tribble(
  ~Aluno, ~Nota1, ~Nota2, ~Nota3, ~Nota4, ~Nota5, ~Nota6, ~Nota7, ~Nota8, ~Nota9,
  "Ana", "7.0", "1.6", "7.7", "3.9", "9.5", "10.0", "0.9", "7.9", "3.6",
  "Bruno", "9.2", "1.5", "1.3", "5.1", "5.8", "7.1", "5.5", "8.7", "3.7",
  "Caio", "5.7", "7.4", "1.9", "0.8", "2.3", "6.3", "3.3", "1.3", "1.5"
)

alunos

alunos |>
  select(Nota1:Nota9)

alunos |>
  select(starts_with("Nota"))

alunos |>
  select(-Aluno)

alunos |>
  select(2:10)

alunos |>
  select(Nota1, Nota2, Nota3, Nota4, Nota5, Nota6, Nota7, Nota8, Nota9)

alunos |>
  select(2, 3, 4, 5, 6, 7, 8, 9, 10)

alunos |>
  select(-1)

alunos |>
  mutate(across(c(Nota1, Nota2, Nota3), as.numeric))

alunos |>
  select(c(Nota1, Nota2, Nota3))

estrelas <- select(starwars, 1:6)
estrelas

estrelas |>
  select(where(is.character))

estrelas |>
  select(where(is.numeric))

estrelas |>
  select(-where(is.numeric))

is.character(estrelas$name)
is.numeric(estrelas$name)

estrelas |>
  select(2:6, -mass)

estrelas |>
  select(c(2:6, -mass))

mean(c(10, 10, NA))
mean(c(10, 10, NA), na.rm = TRUE)


mult_10 <- function(x) {
  x * 10
}

alunos |>
  mutate(
    across(Nota1:Nota9, as.numeric),
    across(Nota1:Nota9, mult_10)
  )

c(1, 2, 3)
list(1, 2, 3)
list("um" = 1, "dois" = 2, "três" = 3)
list("media" = mean, "mediana" = median)

estrelas |>
  unite("todas_as_cores", ends_with("color"), sep = "/")
