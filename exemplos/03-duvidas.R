# https://github.com/curso-r/202308-r4ds-2/releases
# Como disponibilizar um arquivo grande no GitHub?
# Criar a release
piggyback::pb_release_create(
  repo = "curso-r/202308-r4ds-2",
  tag = "0.0.1",
  name = "exemplos")

# Subir o arquivo
piggyback::pb_upload(
  file = "~/Downloads/202308-r4ds-2-main.zip",
  repo = "curso-r/202308-r4ds-2",
  tag = "0.0.1",
  show_progress = TRUE
)

# Como fazer download depois?
piggyback::pb_download(
  "202308-r4ds-2-main.zip",
  dest = "dados/" ,
  repo = "curso-r/202308-r4ds-2",
  tag = "0.0.1",
  show_progress = TRUE
)
