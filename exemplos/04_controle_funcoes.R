eh_par <- function(val) {
  val %% 2 == 0
}

# E lógico

x <- 10
x > 5 & eh_par(x) # 2 lados são TRUE!
x < 5 & eh_par(x)

x <- 9
x > 5 & eh_par(x)

x <- 3
x > 5 & eh_par(x)

x <- 10
!(x > 5) # x <= 5

# Você gosta de R OU Python?
#   - Poderíamos falar "gostar disso, daquilo OU dos dois"
#   - OU Inclusivo: as alternativas NÃO são mutualmente exclusivas

x <- -2
x < 0 | eh_par(x)

x <- 2
x < 0 | eh_par(x)

x <- -3
x < 0 | eh_par(x)

# Uma pessoa pode ser Brasileira OU estrangeira
#   - No geral, falamos "ser OU isso, OU aquilo"
#   - OU Exclusivo: as alternativas são mutualmente exclusivas

x <- -2
xor(x < 0, eh_par(x))

x <- 2
xor(x < 0, eh_par(x))

x <- -3
xor(x < 0, eh_par(x))

# Vetores

x <- c(1, 5, 10, 15)
x > 7
c(1>7, 5>7, 10>7, 15>7)

# While

x <- -10
while (x < 50) {
  x <- x * 2
}
x

x <- 10
while (x < 50) {
  x * 2
}
x

# For

i <- 1
while (i < 4) {
  print(i)
  i <- i + 1
}

for (i in 1:3) {
  print(i)
}
i

valores <- c(1, 5, 10, 15)
for (valor in valores) {
  print(valor * 2)
}

notas <- c(1, 4, 6)
status <- c()
for (nota in notas) {
  if (nota < 5) {
    status <- c(status, "recuperar")
  } else {
    status <- c(status, "aprovar")
  }
}
status

# Alternativa: if_else() ou case_when() dentro do mutate()
status = if_else(notas < 5, "recuperar", "aprovar")
status

notas <- c(1, 3, 4, 5, 8, 10)
status = case_when(
  notas < 3 ~ "reprovar",
  notas < 5 ~ "recuperar",
  TRUE      ~ "aprovar"
)
status

# Funções

f <- function(x, y) {
  x * y
}
f(2, 3)
f(3, 4)
f(4, 5)

f2 <- function(x, y) {
  produto <- x * y
  produto
}
f2(2, 3)
produto # Não existe!

f3 <- function(x, y) {
  produto <- x * y
  return(produto)
}
f3(2, 3)


quadrado_estranho <- function(x) {
  return("Erro")
  x ^ 2
}
quadrado_estranho(2)
quadrado_estranho("dois")
quadrado_estranho(1 + 1 == 2)

quadrado_estranho2 <- function(x) { # Equivale a quadrado_estranho()
  "Erro"
}

quadrado <- function(x) {
  if (!is.numeric(x)) {
    return("Erro")
  }
  x ^ 2
}

# Argumentos

mean(c(1, 2, 3, 4, NA), na.rm = FALSE) # Esse é o valor padrão
mean(c(1, 2, 3, 4, NA), na.rm = TRUE)

# C----------R
# tail(cobra, 4) -> ---R
# head(cobra, 4) -> C---
# tail(cobra, -4) -> C-------
# head(cobra, -4) -> -------R

media_cortada <- function(vetor, n_ini = 1, n_fim = 1) {
  vetor <- sort(vetor)
  vetor <- tail(vetor, -n_ini)
  vetor <- head(vetor, -n_fim)
  mean(vetor)
}

meu_vetor <- c(1, 4, 3, 2, 5, 6, 8, 7, 9, 10)
media_cortada(meu_vetor) # mean(2:9)
media_cortada(meu_vetor, 2, 2) # mean(3:8)
media_cortada(meu_vetor, 4) # mean(5:9)
media_cortada(meu_vetor, n_fim = 4) # mean(2:6)

sum(1, 2, 3)
sum(1, 2, 3, c(10, 3, 5))
sum(c(-1, -2), 1, 2, 3, c(10, 3, 5), NA, c(1, 2), na.rm = TRUE)

somaN <- function(arg1, ..., arg3) {
  sum(arg1, arg3, ...)
}
sum(c(-1, -2), 1, 2, 3, c(10, 3, 5), c(1, 2), arg3 = 200)
