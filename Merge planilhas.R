library("tidyverse")
library(readxl)
library(dplyr)
library(writexl)

df1 <- read_excel("OSs Bruno.xlsx", sheet = 'PosCalculo')
df1 <- select(df1,'OS','Previsto M.C. %','Previsto Lucro %...203','Previsto Impostos Qtd')
df1 <- rename(df1,`Previsto Lucro %` = `Previsto Lucro %...203`)

df2 <- read_excel("Promo Editorial.xlsm", sheet = 'BASE Geral')
df2 <- df2 %>% relocate(OS, .before = 1)

df_final <- left_join(df2, df1, by = "OS")
df_final <- df_final %>%
  relocate('Previsto M.C. %', 'Previsto Lucro %', 'Previsto Impostos Qtd', .after = OS) %>%
  mutate(`Previsto M.C. %` = `Previsto M.C. %` / 100,
         `Previsto Lucro %` = `Previsto Lucro %` / 100)

df_final <- df_final %>% mutate(`Previsto Impostos Qtd` = replace(`Previsto Impostos Qtd`,
                                                                   is.na(`Previsto Impostos Qtd`),0))

df_final <- df_final %>% mutate(`Rec Liq` = (`Valor` / (1 +`Previsto Impostos Qtd`))) %>% 
  mutate(`$L` = `Previsto Lucro %` * `Rec Liq`) %>% 
  mutate(`$MC` = `Previsto M.C. %` * `Rec Liq`)

df_final <- distinct(df_final, .keep_all = TRUE)


write_xlsx(df_final, "C:/Users/103901/Desktop/R/Data Wrangling Rzip Portugues/Data Wrangling R/promoeditorial.xlsx")



rm('df1')
rm('df2')
rm('df_final')







