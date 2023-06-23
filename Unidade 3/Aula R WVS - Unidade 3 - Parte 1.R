# Olá!

# Bem-vindes à primeira unidade do curso de R.

# Hoje, nós vamos passar por alguns tópicos relacionados à manipulação e visualização de dados.
# Isso inclui modificação de variáveis e datasets, análise de dados e elaboração de gráficos.
# A aula está dividida em três partes::
# Parte I: modificação de variáveis e datasets; (Estamos aqui)
# Parte II: visualização de dados; 
# Parte III: testes estatísticos.
# Mas, antes de comerçarmos, precisamos repetir alguns comandos que aprendemos na aula de ontem.


# Começamos instalando os pacotes que vamos utilizar hoje e que ainda não temos...
install.packages("haven")
install.packages("codebook")
install.packages("dplyr")
install.packages("scales")
install.packages("ggplot2")
install.packages("tidyr")


# Vamos carregar os pacotes que vamos utilizar...
library(haven)
library(tidyverse)
library(codebook)
library(dplyr)
library(scales)
library(ggplot2)
library(tidyr)

# Agora, definimos o diretório...
setwd("/Users/deboradeoliveirasantos/WVSdata")

# E, então, carregamos o dataset.
WVS <- read_spss("WVS7_BRA_v2309.sav")

# Vamos ver como está o nosso dataset?
view(WVS) # o comando "view" vai abrir uma nova "aba" com o dataset.
head(WVS) # o comando "head" vai msotrar as primeiras variáveis e observações do dataset.

# Agora vamos abrir o nosso codebook para facilitar a visualização das variáveis e suas características.
label_browser_static(WVS)




    ### Vamos ao nosso primeiro tópico:

    ### 1. Modificação de variáveis

# Existem diversos motivos para modificar (ou precisar modificar) variáveis,
# seja devido aos nossos objetivos de pesquisa, convenção ou conveniência.

# Exemplos: 
# a) criar novas variáveis;
# b) criar variáveis dicotômicas (dummy-coded); 
# c) mudar variáveis com valores invertidos (reversed coded variables); 
# d) redimensionar valores (rescale).

# Vamos ver na prática.


    ## 1.1 Para criar uma variável para idade, podemos utilizar dois caminhos diferentes.

# 1.1.1 Primeiro caminho:
WVS$idade <- 2023 - WVS$Q261

# Nesse caminho, colocado o nome do dataset seguido de "$", o nome da variável e o símbolo "<-".
# Depois, inserimos a condição que queremos para a nova variável. 
# Aqui, essa condição é o ano corrente subtraindo os valores da variável Q261, de "Ano de nascimento".

# Vamos ver como fica:
WVS %>%
  count(idade)


# 1.1.2 Segundo caminho com a função "mutate":
WVS <- 
  WVS %>% 
  mutate(idade1 = 2023 - Q261)

# Nesse caminho, colocamos o nome do dataset seguido de "<-" e da fórmula do mutate que é:
# Nome do dataset seguido do símbolo "%>%", a função mutate, o nome da nova variável, "=" e a condição 
# para nova variável, que aqui é ano corrente subtraindo os valores da variável Q261, de "Ano de nascimento".

# Vamos ver como fica:
WVS %>%
  count(idade1)



    ## 1.2 Para criar uma variável que condicione uma idade a "Jovem" e as demais como "Não Jovem".

# 1.2.1 Primeiro caminho com a função "if_else":
WVS$faixa_etaria <- if_else(WVS$idade < 30, "Jovem", "Não Jovem")

# O "if_else" determina tanto a condição quanto o seu oposto. 
# Nesse caso, se (if_else) "idade" é menor que 30, então é "Jovem"; se maior que 30, é "Não Jovem".

# Aqui, a nova variável terá como valores aquilo que nós indicamos depois da condição, 
# ou seja, "Jovem" ou "Não Jovem".

# Isto significa que podemos colocar quaisquer valores que quisermos na modificação baseada na condição.

# Vamos ver como fica no dataset:
WVS %>%
  count(faixa_etaria)


# 1.2.2 Segundo caminho com a função "mutate" e "if_else":
WVS <- 
  WVS %>% 
  mutate(faixa_etaria1 = if_else(idade < 30, "Jovem", "Não Jovem"))

# Assim como no exemplo anterior, colocamos o nome do dataset seguindo de "<-" e da fórmula
# do mutate com a condição que queremos recodificar.

# A diferença é que aqui a nossa condição é baseada pelo "if_else".

# Vamos ver como fica no dataset:
WVS %>%
  count(faixa_etaria1)



    ## 1.3 E se quisermos fazer uma nova variável para gerações?

# Nesse caso, a função "case_when" permite que criemos mais de uma condição na modificação de variáveis.

# 1.3.1 Primeiro caminho com a função "case_when":
WVS$geracoes <- case_when(
  WVS$Q261 <= 1960 ~ "Baby Boomers",
  WVS$Q261 <= 1980 ~ "Gen X",
  WVS$Q261 <= 1995 ~ "Gen Y",
  WVS$Q261 <= 2010 ~ "Gen Z")

# Note que aqui temos quatro condições, uma para cada geração.

# Essas condições são determinadas pela variável, seguida da operação matemática (menor ou igual),
# seguido do símbolo "~" e o novos valores para a variável gerações (Baby boomers, Gen X...).

# Vamos ver como fica a nova variável para gerações:
WVS %>%
  count(geracoes)


# 1.3.2 Segundo caminho com a função "mutate" e "case_when":
WVS <- 
  WVS %>%
  mutate(geracoes1 = case_when(
    Q261 <= 1960 ~ "Baby Boomers",
    Q261 <= 1980 ~ "Gen X",
    Q261 <= 1995 ~ "Gen Y",
    Q261 <= 2010 ~ "Gen Z"))

# Vamos ver como fica a nova variável para gerações:
WVS %>%
  count(geracoes1)



    ## 1.4 Variáveis dummy-coded.

# Esse tipo de variável é caracterizado por 1 (TRUE) e 0 (FALSE).

# Também é chamada de variável dicotômica.

# Podemos usar as mesmas funções aprendidas anteriormente para criá-las.
# Mas não se esqueça de condicioná-las como numéricas.


# Vamos criar uma variável dummy para jovens.

# 1.4.1 Primeiro caminho:
WVS$Jovem <- WVS$idade < 30

# Vamos ver como ficou:
WVS %>%
  count(Jovem) 


# 1.4.2 Segundo caminho com a função "mutate":
WVS <- 
  WVS %>% 
  mutate(Jovem1 = idade < 30)

# Vamos ver como ficou:
WVS %>%
  count(Jovem1) 


# 1.4.3 Observe: as variáveis retornaram apenas TRUE e FALSE.

# Para consertar isso e modificá-la como binária (0 e 1), use a função "as.numeric":
WVS$Jovem <- as.numeric(WVS$idade < 30)
WVS %>%
  count(Jovem) 

# Agora temos uma variável dummy.



    ## 1.5 Variáveis com valores invertidos (reversed coded).

# Essas variáveis são muito comuns.

# Por exemplo, as variáveis sobre sistema político no WVS são entre 1 (muito bom) a 4 (muito ruim).

# Vejamos na variável sobre um governo de técnicos:
WVS %>%
  count(Q236)


# Para reverter os valores, usamos os mesmos caminhos que já conhecemos.
# Mas devemos subtrair a variável pelo seu número de valores + 1.
# Como a variável do governos de técnicos é de 1 a 4, subtraímos ela por 5 (4 + 1). Ou seja:
# 5 - 4 = 1
# 5 - 3 = 2
# 5 - 2 = 3
# 5 - 1 = 4


# 1.5.1 Primeiro caminho:
WVS$Tecnocracia <- 5 - WVS$Q236

# Vamos ver como ficou:
WVS %>%
  count(Tecnocracia)


# 1.5.2 Segundo caminho com a função "mutate"
WVS <- 
  WVS %>% 
  mutate(Tecnocracia1 = 5 - Q236)

# Vamos ver como ficou:
WVS %>%
  count(Tecnocracia1)



    ## 1.6 Mudar a escala de uma variável.

# Às vezes, por convenção ou conveniência, precisamos mudar os valores de uma variável.
# Por exemplo, transformar uma variável de 0 a 10 em uma variável de 0 a 1.
# Para isso, o pacote "scales" é muito útil.

# Vamos ver como fazer isso com uma variável de valores democráticos (de 0 a 10).
WVS %>%
  count(Q241)


# 1.6.1 Primeiro caminho usando a função "rescale" para mudar a escala de 0 a 10 para 0 a 1.
WVS$Q241 <- as.numeric(WVS$Q241) # diga ao R que é uma variável numérica
WVS$Q241_0a1 <- rescale(WVS$Q241) # mande o R mudar a escala

# Vamos ver como ficou:
WVS %>%
  count(WVS$Q241_0a1)


# A função "rescale" tem, como padrão (default), mudar para 0 a 1.

# Mas podemos mudar esses valores, por exemplo de uma escala de 0 a 10 para 0 a 5.
WVS$Q241_0a5 <- rescale(WVS$Q241, to = c(0, 5))

# Aqui temos que acrescentar "to =", seguido do conjunto de valores mínimo e máximo desejados (range).

# Vamos ver como ficou:
WVS %>%
  count(WVS$Q241_0a5)


# 1.6.2 Segundo caminho usando a função "mutate" e "rescale" para mudar a escala de 0 a 10 para 0 a 1.
WVS <- 
  WVS %>% 
  mutate(Q241_0a1_1 = rescale(Q241))

# Vamos ver como fica:
WVS %>%
  count(WVS$Q241_0a1_1)

# Agora usando a função "mutate" e "rescale" para mudar a escala de 0 a 10 para 0 a 5.
WVS <- 
  WVS %>% 
  mutate(Q241_0a5_1 = rescale(Q241, to = c(0,5)))

# Vamos ver como fica:
WVS %>%
count(WVS$Q241_0a5_1)


# Lembre-se: podemos utilizar qualquer tipo de operação matemática no R. 
# O mesmo é válido para modificações de variáveis.
# Podemos construir novas variáveis com somas, subtrações, médias etc.






    ### Vamos para o nosso próximo tópico: 

    ### 2. Modificação de datasets


# Assim como na modificação de variáveis, modificar datasets pode ser útil para análise de dados.
# Isso inclui selecionar/remover colunas, selecionar/remover observações ou mudar o formato (long ou wide).



    ## 2.1 Criando um dataset baseado em observações/casos (no SPSS, seria select cases).

# Suponhamos que nosso objetivo de pesquisa é analisar apenas a cultura política de jovens.

# Pode ser conveniente, então, criar um dataset apenas com as observações para jovens.

# Para isso, podemos usar diferentes caminhos.


# 2.1.1 Primeiro caminho usando a função "filter":
WVS_Jovens <- 
  WVS %>% 
  filter(faixa_etaria == Jovem)

# Aqui, a função "filter" filtra uma dada variável com base no valor que determinamos.

# No caso, aqui determinamos que o filtro deve ser os valores "Jovem" na variável "faixa_etaria".

# Lembre-se que, quando queremos usar o sinal matemático de igual, devemos usar "==".

# Vamos ver como ficou:
view(WVS_Jovens)


# 2.1.2 Segundo caminho usando a função "subset":
WVS_Jovens1 <- subset(WVS, faixa_etaria1 == "Jovem")

# Aqui, usamos a função "subset" da mesma forma que na função "filter". 

# A diferença é a codificação da fórmula que é: função "subset", seguida do nome do dataset original,
# da variável a partir da qual queremos filtar, de "==" e do valor que queremos filtrar.

# Vamos ver como ficou:
view(WVS_Jovens1)


# 2.1.3 Terceiro caminho com a notação dataset[]:
WVS_Jovens3 <- WVS[WVS$faixa_etaria == "Jovem" , ]

# Nesse tipo de codificação, temos um padrão que é:
# "nome do dataset [ linhas do dataset , colunas do dataset]".

# Como aqui queremos selecionar observações (linhas) de uma variável (coluna), 
# codificamos a condição que queremos antes da vírgula (parte correspondente a linhas) entre
# os colchetes e deixamos a parte referente às colunas (após a vírgula) em branco.



    ## 2.2 Criando um dataset com base em colunas (variáveis).

# Suponhamos que nosso objetivo é analisar confiança institucional e valores democráticos.

# Pode ser conveniente, então, criar um dataset apenas com essas colunas (variáveis).

# 2.2.1 Primeiro caminho usando a função "select":
WVS_Confiança_Valores <- 
  WVS %>% 
  select(Q71, Q72, Q243, Q245, Q246, Q249)

# Aqui, a função "select" seleciona as variáveis que indicamos.

# Vamos ver como ficou:
view(WVS_Confiança_Valores)


# 2.2.2 Segundo caminho usando a função "subset" e "select":
WVS_Confiança_Valores1 <- subset(WVS, select = c(Q71, Q72, Q243, Q245, Q246, Q249)) 

# Aqui usamos a mesma codificação que a anterior para a função "subset", incluindo, após 
# o nome do dataset, a função select seguida de "= c()", indicando dentro do conjunto "c()""
# quais as variáveis que queremos selecionar.

# Vamos ver como ficou:
view(WVS_Confiança_Valores1)


# 2.2.3 Terceiro caminho com a notação dataset[]:
WVS_Confiança_Valores2 <- WVS[ , c("Q71", "Q72", "Q243", "Q245", "Q246", "Q249")]

# Nesse tipo de codificação, temos um padrão que é:
# "nome do dataset [ linhas do dataset , colunas do dataset]".

# Como aqui queremos selecionar apenas variáveis (colunas) e não observações (linhas),
# codificamos a condição que queremos depois da vírgula (parte correspondente a colunas) entre
# os colchetes e deixamos a parte referente às linhas (antes da vírgula) em branco.



    ## 2.3 Mudando o formato dos datasets (wide & long).

# Um último aspecto interessante na manipulação de bases de dados é a modificação do formato das bases.

# Existem dois tipos de formatos: o wide e o long.
# No formato wide, as observações não se repetem nas linhas (ex. o caso "A" terá apenas uma linha).
# Já no formato long, as observações se repetem e as colunas são condensadas.


# Por que usar o wide? Esse é o formato geralmente mais utilizado.
# Ele é mais inteligível e simples. Ex.: base do WVS.


# Por que usar o long? Às vezes, no processamento e análise de dados, o formato long é
# mais fácil de ser compreendido pelo software. Ex.: testes between e within subjects.
# Ex.2: analisando várias ondas do WVS.



# 2.3.1 Mudando de wide para long:

# Vamos primeiro fazer um subset para ficar mais fácil de trabalhar.

# Vamos usar variáveis de valores que usamos anteriormente, mas precisamos acrescentar 
# a variável com a identificação de cada respondente. Isso é muito importante! 
# Não é possível modificar o dataset sem a identificação da observação.


# Criando o novo dataset com a identificação:
WVS_Valores_ID <- WVS[ , c("IDQUEST", "Q243", "Q245", "Q246", "Q249")]


# Convertendo o dataset de wide para long:
WVS_Valores_ID_Long <- WVS_Valores_ID %>% 
  pivot_longer(cols = `Q243`:`Q249`, 
    names_to = "Valores Democráticos",
    values_to = "Respostas")

# Aqui, na função "pivot_longer", temos que determinar quais colunas serão condensadas
# em uma só coluna com o função "cols = `nome da primeira coluna` : `nome da última coluna`;

# Depois devemos indicar o nome da nova coluna com o função "names_to = " e também
# o nome da coluna dos valores no função "values_to = ". 

# Vamos ver como ficou:
view(WVS_Valores_ID_Long)



# 2.3.2 Mudando de long para wide:
WVS_Valores_ID_Wide <- WVS_Valores_ID_Long %>% 
  pivot_wider( names_from = "Valores Democráticos",
               values_from = "Respostas")

# Aqui, na função "pivot_wider", temos apenas que indicar de quais colunas virão
# os nomes (com o função "names_fom = ") e os valores (com o função "values_from = ").

# Vamos ver como ficou:
view(WVS_Valores_ID_Wide)



    ### Terminamos nossos dois primeiros tópicos da Unidade 3.


