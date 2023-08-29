meu_texto = "Uma string"



"Uma string com "aspas"." # erro!
texto2 = 'Uma string com "aspas".'
texto3 = "Uma string com \"aspas\"."

# \ é top
cat("texto com 'aspas simples'")
cat('texto com "aspas duplas"')
cat("texto com 'aspas simples' e \"aspas duplas\"")

# raw strings

texto_literal = r"{aspas \"}"
cat(texto_literal)

"Cachorro:\n\t- Dexter"
cat("Cachorro:\n\t- Dexter\n\t- Zip")

cat("Temperatura: 10\u00ba C")
# vantagem das strings 'normais' do R!

r"{aspas 10\u00ba"}"
# desvantagem do raw string

library(tidyverse)

cachorros <- tibble(cachorro = c("Bacon", "Dexter", "Zip"))
cachorros

str_sub("Dexter", 1, 3)

str_sub("Dexter", -3, -1)

str_c("04", "/", "2020")
# paste0("04", "/", "2020")
# faz alusão ao comportamento do c, embora seja
# um pouco diferente

ns <- c(1, 5, 10, 100, 500)
strings <- str_c("arquivo_", ns)

cachorros |>
  mutate(
    mensagem = str_c("Oi, ", cachorro, "!")
  )

data_quebradas <- tibble(
  dia = c(23, 24, 11),
  mes = c(10, 12, 11),
  ano = c(2022, 2020, 2019)
)

data_quebradas |>
  mutate(
    data_completa = str_c(dia, mes, ano, sep = "/")
  )

dados <- tibble(
  id_compra = c(1, 1, 2),
  produtos = c("Alvejante", "Pano", "Pão")
)

dados |>
  group_by(id_compra) |>
  summarise(
    produtos = str_c(
      "Produto(s) comprado(s): ",
      str_flatten(produtos, collapse = ", "))
  )

data_completa <- data_quebradas |>
  mutate(
    data_completa = str_c(dia, mes, ano, sep = "/")
  ) |>
  select(-ano)

data_completa |>
  mutate(
    ano = str_sub(data_completa, -4, -1)
  )

cachorros |>
  mutate(
    tamanho_texto = str_length(cachorro)
  )

textos_disformatados <- tibble(
  nome = c("         Fernando   Corrêa", "   ABC", "    AS     ")
) |>
  mutate(
    nome_arrumado = str_squish(nome)
  )

data_quebradas <- tibble(
  dia = c(23, 24, 11),
  mes = c(06, 09, 01),
  ano = c(2022, 2020, 2019)
)

data_quebradas |>
  mutate(
    data_completa = str_c(dia, str_pad(mes, 2, pad = "0"), ano, sep = "/")
  )

str_pad(6, width = 5, pad = "0", side = "left")

scales::percent(c(.12213, .10123, .01, .02), decimal.mark = ",") |>
  str_pad(width = 5, pad = "0") |>
  str_sort()

str_sort(strings)

ns2 <- str_pad(ns, 3, "left", "0")
strings2 <- str_c("arquivo_", ns2)

str_sort(strings2)

names(mtcars) <- str_to_upper(names(mtcars))
mtcars

mtcars <- mtcars |>
  rename_with(str_to_lower)

mtcars <- mtcars |>
  rename_with(str_to_title)

tabela_noticias <- tibble(
  url = c("folha.com.br/noticia1", "estadao.com.br/noticia2", "whiplash.com.br/noticia3",
          "estadao.com.br/noticia3", "estadao.com.br/noticia4"),
  conteudo = c("hoje a inflação subiu 10%", "hoje apreenderam 10kg de maconha do tráfico",
               "show do queens of the stone age foi cancelado",
               "Tráfico de drogas diminui 50% depois do começo da gestão XXX",
               "Nova bolha .com está prestes a estourar de novo")
)

## Ver a aula!
# \" ---> "
# \t ---> tab
# \n ---> nova linha
# \\ ---> \

## Ver a aula!
# regex: .  (coringa)
# regex: \. (literal ponto-final)
# r    : \. (HÃ????)
# r    : \\. ---> \. (regex entende)

cat("\.") # erro!
cat("\\.")

tabela_noticias |>
  mutate(
    #palavra_chave_traf = str_extract(conteudo, ".r.fico"),
    #palavra_chave = str_extract(conteudo |> str_to_lower(), "tráfico"),
    #palavra_chave_internet = str_extract(conteudo, "\\.com"),
    #ultimo_caracter = str_extract(conteudo, ".$"),
    #primeiro_caracter = str_extract(conteudo, "^."),
    palavra_chave_traf_melhor = str_extract(conteudo, "[Tt]r[áa]fico"),
    #conjunto que vc constroi, os caracters interpretados como "OU"
    #[Tt] quer dizer "T" ou "t"
    palavra_chave_traf_melhor = str_extract(conteudo, "[a-zA-Z]r[áa]fico"),
    #alguns padrões especiais fogem à regra:
    #a-z dentro [], é a mesma que coisa que [abcdefghijklmnopqrstuvxwyz],
    # pras maiusculas é a mesma coisa, [A-Z] é qualquer letra maiúscula.
    # não tem acentos nesses dois padrões
    #palavra_chave_internet = str_extract(conteudo, r"{\.com}")
    palavra_chave_traf_melhor = str_extract(conteudo, "[^ ]com"),
    # não precisa escapar o pontinho no conjunto!
  )

formulario = tibble(
  review = c("paguei 250.00 reais nessa blusa e veio furada. absurdo ")
)

formulario |>
  mutate(
    numero = str_extract(review, "[0-9][0-9][0-9][^ ][0-9][0-9]")
  )


# outro jeito (melhor) de produzir as classificações das noticias ---------

lista_de_regex <- c(
  categoria_musica = "[sS]how",
  crime = "[Tt]r[áa]fico",
  economia = "[Ii]nfla[çc][ãa]o"
)

regex_final <- str_c(
  "(", str_flatten(lista_de_regex, collapse = "|"), ")")

tabela_noticias |>
  mutate(
    palavra_chave = str_extract(conteudo, "([sS]how|[Tt]r[áa]fico|[Ii]nfla[çc][ãa]o)"),
    #palavra_chave = str_extract(conteudo, regex_final)
  )

tabela_noticias |>
  mutate(
    numeros = conteudo |> str_extract("[0-9][0-9](%|kg|º)"),
    contexto = conteudo |> str_extract("([^ ]+ |^)[0-9][0-9](%|kg|º)( [^ ]+|$)")
  ) |> View()

"16.517.740-8"

str_extract("meu RG é 16.517.740-8 asdasdasd", "[0-9]{2}\\.[0-9]{3}\\.[0-9]{3}-[0-9]")

regex_email <- "[a-zA-Z_.0-9]+@[a-zA-Z0-9]+\\.[a-z]+(\\.[a-z])?"

tabela_noticias |>
  filter(
    !str_detect(conteudo, "[Tt]r[áa]fico")
  )

tabela_noticias |>
  mutate(
    categoria_noticia = case_when(
      str_detect(conteudo, "[Tt]r[áa]fico|assassinato|roubo|sequestro") ~ "crime",
      str_detect(conteudo, "[Ii]nfla[çc][ãa]o|juros|empréstimo|inadimplência|fazenda|economia") ~ "economia",
      TRUE ~ "outros"
    )
  )

str_extract_all("letras e números 0123123 asd", "([:alpha:]| )+")

str_split("letras e números 0123123 asd\tasdasdasd\nasdaasdas. asdasda", "([:space:]|\\.)")

stringi::stri_trans_general("Váríös àçêntõs", "Latin-ASCII")


tabela_noticias |>
  mutate(
    palavra_chave = str_remove_all(conteudo, "o"),
    #palavra_chave = str_extract(conteudo, regex_final)
  )
# alternativa ao extract

str_detect(tabela_noticias$conteudo, "[Tt]r[áa]fico")

arquivos <- tibble(nome = list.files())

arquivos |>
  mutate(
    html =  str_extract(nome, "\\.html$"),
    Rmd =  str_extract(nome, "\\.Rmd$")
  )

# Não precisa re-escapar o \n e o \t
str_extract(
  "Cachorros:\n\t- Dexter\n\t- Zip",
  pattern = ":\n\t."
) |> cat()

# \n e \t são 1 caractere só
str_length("1\n3")

r"(Usando "aspas duplas".)"
r"{Usando "(aspas em parênteses)"}"

str_extract("strings.", "s\\.")
str_extract("strings.", r"{s\.}")

# NO R
" -> abre strings
n -> caractere n
t -> caractere t
\ -> escape

\" -> caractere "
\n -> nova linha
\t -> tab
\\ -> caractere \

# NO REGEX
b -> caractere b
. -> coringa

\b -> fronteira
\. -> caractere .

# NO R
\. -> não é nada!
  \b -> não é nada!

  # NO R          NO REGEX
  \\.  -> \. -> caractere .
.    -> .  -> coringa

# CONCLUSÃO: Escapar meta-caracteres
# no regex dentro do R precisa de \\

[a-z]
[A-Z]
[A-Za-z]
[A-Za-z0-9]
[aeiou]

str_replace(
  string = "9123405678",
  pattern = "0",
  replacement = "-"
)

str_replace(
  string = "9012304567",
  pattern = "0",
  replacement = "-"
)

str_replace(
  string = "9012304567",
  pattern = "([0-9]{5})0([0-9]{4})",
  replacement = "\\1-\\2"
)

str_extract(c("a", "ab", "abb"), "ab")
str_extract(c("a", "ab", "abb", "ac", "acc"), "ab?")
str_extract(c("a", "ab", "abb", "ac", "acc"), "a.")
str_extract(c("a", "ab", "abb", "ac", "acc"), "a.?")
