# funções do R base
Sys.Date() # date
Sys.time() # date/time

as.Date("2023-09-04") |> class()

library(tidyverse)

# equivalencias com lubridate:
today() # date
now() # date/time


"2023-09-05" |> class()

as_date("2023-09-05") |> class()

as_date("2023-09-05") |> as.numeric() # dias desde 01/01/1970

now() |> as.numeric() # segundos desde 01/01/1970 no ano novo londrino

# y = representa ano
# lubridate::dmy_hms()

"04/09/2023" |> class()

"04/09/2023" |> dmy() |> class()

# converter!
# identificar na coluna o padrão usado


parse_date("04/09/2023", format = "%d/%m/%Y") |> class()

# quais códigos usar para representar os elementos da
# data/hora? é possível ver na documentação

?parse_date


"4 de setembro de 2023" |>
  dmy(locale = "pt_BR") |>
  class()

"4 de setembro de 2023" |>
  parse_date(
    format = "%d de %B de %Y",
    locale = locale(date_names = "pt")
  )


library(janitor)
?excel_numeric_to_date()

# dá errado!!!
as_date(40000)

# funciona!
excel_numeric_to_date(40000)

# exemplo com uma base!
# Link onde a base está disponível
url_mananciais <- "https://github.com/beatrizmilz/mananciais/raw/master/inst/extdata/mananciais.csv"

# Lendo o arquivo csv (separado por ponto e vírgula)
mananciais <- read_csv2(url_mananciais)

glimpse(mananciais)

mananciais |>
  mutate(
    # funcoes pra extrair elementos das datas
    # em singular
    dia = day(data),
    mes = month(data),
    mes_extenso = month(data, label = TRUE, abbr = FALSE, locale = "pt_BR"),
    ano = year(data),
    semana = week(data),
    dia_da_semana = wday(data),
    dia_da_semana_extenso = wday(data,
                                 # Nome do dia
                                 label = TRUE,
                                 # abreviar
                                 abbr = FALSE,
                                 # em qual idioma?
                                 locale = "pt_BR"),
    # fazer contas com as datas
    # no plural
    daqui_30_dias = data + days(30),
    daqui_3_meses = data + months(3),
    daqui_4_anos = data + years(4),
    .after = data
  ) |> View()


mananciais |>
  mutate(
    ano = year(data),
    mes = month(data)
  ) |>
  group_by(sistema, ano, mes) |>
  summarise(media_volume_porcentagem = mean(volume_porcentagem)) |>
  mutate(mes_ano = paste0(mes, "/", ano)) |>
  ggplot() +
  aes(y = media_volume_porcentagem, x = mes_ano) |>
  geom_line()


round(0.9999)

floor(0.9)

floor(0.9999)

ceiling(0.1)

# força o locale em portugues nessa sessão
Sys.setlocale(locale = "pt_BR")

mananciais |>
  mutate(
    # arredondamento das datas
   mes_ano = floor_date(data, "month"),
   .after = data
  ) |>
  group_by(sistema, mes_ano) |>
  summarise(media_volume_porcentagem = mean(volume_porcentagem)) |>
  ggplot() +
  aes(y = media_volume_porcentagem, x = mes_ano) +
  geom_line(aes(color = sistema)) +
  scale_x_date(date_labels = "%B/%y",
               date_breaks = "5 years")


mananciais |>
  mutate(dia_hoje = Sys.Date(),
         subtracao = dia_hoje - data,
         subtracao_minutos = as.period(subtracao) / minutes(1),
         subtracao_meses = as.period(subtracao)/months(1),
         .after = data)

# Nomes dos fusos

OlsonNames()


mananciais |>
  mutate(data_amigavel = strftime(data, format = "%d/%m/%Y")) |>
  View()


as_date("2023-01-31") + months(1)


add_with_rollback(as_date("2023-01-31"),  months(1))


add_with_rollback(as_date("2023-01-31"),  months(1), roll_to_first = TRUE)
