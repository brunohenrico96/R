# Carregar o pacote dplyr
install.packages("readxl")
library(readxl)
library(writexl)
library(dplyr)

# Carregar o dataframe (substitua "seu_dataframe.csv" pelo nome do arquivo do seu dataframe)
df <- read_xlsx("planilha.xlsx")

# Função para remover as palavras indesejadas dos nomes dos clientes
remove_palavras_indesejadas <- function(nome) {
  palavras_indesejadas <- c("EDITORA", "LTDA", "GRUPO", "LOJAS", "SUPERMERCADOS", "SUPERMERCADO",
                            "SUPER", "EDITORIAL")
  for (palavra in palavras_indesejadas) {
    nome <- gsub(palavra, "", nome, ignore.case = TRUE)
  }
  nome <- trimws(nome)  # Remover espaços extras no início e no fim do nome
  return(nome)
}

# Criar a coluna "C" no dataframe com os nomes dos clientes após a remoção das palavras indesejadas
df <- df %>%
  mutate(C = sapply(Ajustar, remove_palavras_indesejadas))

# Visualizar o resultado
print(df)
write_xlsx(df, "C:\\Users\\103901\\Desktop\\R\\RASCUNHOS\\arquivo.xlsx")

