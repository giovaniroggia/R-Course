# Olá!

# Bem-vindes à terceira unidade do curso de R.

# Hoje, nós vamos passar por alguns tópicos relacionados à manipulação e visualização de dados.
# Isso inclui modificação de variáveis e datasets, análise de dados e elaboração de gráficos.
# A aula está dividida em três partes::
# Parte I: modificação de variáveis e datasets; 
# Parte II: visualização de dados; 
# Parte III: testes estatísticos. (Estamos aqui)
# Mas, antes de comerçarmos, precisamos repetir alguns comandos que aprendemos na aula de ontem.


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




    ### Parte III da Unidade 3


    ### 4. Testes estatísticos


# Bem, como vocês já devem ter percebido, o R tem muitas funcionalidades e executa diferentes tarefas.
# Com testes estatísticos, não é diferente.
# Existem diferentes tipos de testes estatíticos também. Aqui vamos passar por alguns testes de forma bem básica.
# Assim como para a Parte II, sobre gráficos, recomendo que vocês procurem sobre esses testes em sites e fóruns.


# Antes de começarmos, vamos retomar alguns conceitos importantes:
# a) Variável dependente (VD): aquilo que queremos explicar, o Y;
# b) Variável independente (VI): aquilo que pode explicar a variação da VD, o X;
# c) Variáveis quantitativas: valores correspondem características numéricas. Tipos:
#   - discretas: expressa números inteiros, geralmente vindos de contagens. Ex.: número de filhos. 
#   - contínuas: expressa valores numa escala contínua, com infinitas possibilidades. Ex.: idade.
# d) Variáveis categóricas: valores correspondem a categorias que se distinguem por 
# características não numéricas. Tipos:
#   - nominal: expressa categorias que não tem ordem. Ex.: gênero.
#   - ordinal: expressa categorias que possuem ordem. Ex.: escolaridade.
# e) Testes paramétricos: assumem que as variáveis apresentam comportamento normal;
# f) Testes não-paramétricos: assumem que as variáveis não apresentam comportamento normal;
# g) Comportamento normal (normalidade na distribuição): observações uniformemente 
# distribuídas em torno da média;
# h) Significância estatística: é o que determina se um resultado aconteceu por acaso ou não.
# Se o resultado é significativo (pelo menos, p < 0.05), menores as chances de ser um acaso.

# Esses conceitos são importantes, porque a escolha do tipo de teste estatístico depende deles.
# Precisamos saber essas características sobre as nossas variáveis para poder escolher o teste certo.

# Vamos lá!




    ## 4.1 Normalidade da distribuição

# Para sabermos qual tipo de teste escolher (paramétrico ou não paramétrico), precisamos antes saber se a 
# distribuição de uma variável é normal.
# No geral, variáveis categóricas não apresentam normalidade na distribuição.
# Como a maioria das variáveis do WVS são categóricas, a maioria delas não irá apresentar distribuição normal.
# Mesmo assim, é interessante (e útil) aprendermos sobre normalidade de uma variável.


# Como vimos antes, histogramas e gráficos de densidade são úteis para observar a distribuição de uma variável.


# Vamos testar com confiança no governo:
WVS %>%
  ggplot(aes(x= Q71)) + geom_histogram() 
WVS %>%
  ggplot(aes(x= Q71)) + geom_density() 

# Embora a distribuição não é normal no histograma e na densidade, podemos também usar testes específicos para isso. 


# O QQplot é uma representação visual para normalidade de distribuição dos quartis de uma variável.
# Ele apresenta uma linha teórica esperada e a distribuição observada de uma variável.

# Vejamos o QQplot para confiança no governo:
qqnorm(WVS$Q71)
qqline(WVS$Q71)
# Observem como a linha as observações não estão seguindo a linha teórica. Isso nos diz que não é normal.

# Para complementar, podemos realizar o teste Shapiro-Wilk.
# Neste teste, se o resultado é estatisticamente significativo, a distribuição não é normal.
shapiro.test(WVS$Q71) # para confiança no governo
# Novamente, temos o resultado de que não é normal.


# EXERCÍCIO!
# Agora tente rodar um histograma, um qqplot com a qqline e um Shapiro-Wilk test para a variável de idade.






    ## 4.2 Correlações

# Utilizamos correlações para analisar a covariância de variáveis, ou seja, em que medida elas variam ou não conjuntamente.

# Correlações são interessantes para verificar a força e a direção dessa relação entre duas variáveis.

# O coeficiente de correlação (r) varia entre -1 (negativa) e 1 (positiva), e também depende da significância.

# Mas, lembre-se correlação não é causalidade.
# E, cuidado: podemos tentar correlacionar qualquer coisa e acabar tendo uma correlação espúria.
# No site https://www.tylervigen.com/spurious-correlations, vocês têm alguns exemplos como de correlações como:
# Número de afogamentos em piscinas e aparições do Nicolas Cage em filmes.


# Voltando ao que interessa. Temos dois tipos principais de correlações:
# Correlação de Pearson: teste de correlação paramétrico;
# Correlação de Spearman e de Kendall: teste de correlação não paramétrico.


# Vamos primeiro testar a correlação entre ideologia e idade:
cor.test(WVS$Q240, WVS$idade, use = "complete.obs")

# Aqui, utilizamos a função "cor.test", seguida da indicação do dataset e variável X (no caso, WVS$Q240) e variável Y
# (no caso WVS$idade), depois colocamos a função "use = "complete.obs"", que indica ao R que queremos utilizar apenas 
# observações válidas, ou seja, sem missing values (os NAs). 

# Se não colocamos o "use = "complete.obs"", o R não irá retornar resultado algum. Podem testar.


# EXERCÍCIO!
# Agora é tua vez. Faça um teste de correlação entre ideologia (Q240) e apoio a um governo militar (Q237):






# A função "cor.test" roda, por padrão (default), a correlação de Pearson. 
# Porém, como vimos, Pearson é um teste paramétrico e nossas variáveis não são exatamente normais.
# Vamos checar:
qqnorm(WVS$Q240,main="normal QQ plot") #ideologia
qqline(WVS$Q240) #ideologia
shapiro.test(WVS$Q240) #ideologia
qqnorm(WVS$Q237,main="normal QQ plot") #governo militar
qqline(WVS$Q237) #governo militar
shapiro.test(WVS$Q237) #governo militar

# Ok. Variáveis não normais, devemos fazer então uma correlação adequada (Spearman ou Kendall).


# Para calcularmos a correlação de Spearman e não de Pearson, acrescentamos no código a função: "method = "spearman"".
# Vamos ver:
cor.test(WVS$Q240, WVS$Q237, use = "complete.obs", method = "spearman")
# Você pode indicar como método "pearson", "spearman" e "kendall"




    ## 4.3 Regressões

# Assim como as correlações, as regressões também buscam verificar a relação entre variáveis. 

# Mas, diferente da correlação, a regressão descreve essa relação, permitindo que identifiquemos de forma mais 
# adequada como uma variável independente (X) pode influenciar a variação observada na variável dependente (Y).

# Nesse sentido, elas não indicam somente a direção e força de uma relação entre variáveis, mas fornecem uma equação
# (coeficientes) que descreve o comportamento da variável Y em função do comportamento da variável X (o chamado efeito).

# Não é ainda exatamente causalidade, mas é mais próximo de identificar, de forma robusta, uma relação.


# Existem diferentes tipos de regressões (lineares, logísticas, ordinais, modelos generalizados, modelos estruturais etc.).
# Cada tipo de regressão possui pressupostos e estruturas próprias (eu recomendo que vocês pesquisem para aprender mais).
# Mas uma premissa básica que alguns tipos compartilham é de que a variável dependente Y deve ser numérica.

# As funções de regressão que aprenderemos hoje possuem esse pressuposto. São elas:
# a) A função "lm" para regressões lineares;
# b) A função "glm" para modelos lineares generalizados.


# Dito isso, podemos começar testando as correlações que fizemos anteriormente em regressões.



# 4.3.1 Regressões lineares simples e múltiplas

# Começando com a relação entre ideologia e idade: 
modelo_1 <- lm(Q240 ~ idade, data = WVS) 

# Primeiro, criamos um objeto para a regressão que estamos rodando chamado "modelo_1".
# O código que usamos para realizar uma regressão linear é: a função "lm" seguida da variável dependente (Y), do símbolo "~",
# da(s) variável(is) independente(s) (X) e da indicação do dataset utilizado, aqui "data = WVS".


# Observem que o resultado retornado apresenta apenas os coeficientes do intercept e da nossa VI (X).
# Para saber a significância dessa relação e acessar outros dados estatísticos do modelo, devemos usar a função "summary".
summary(modelo_1)

# Agora temos todos os dados importantes de uma regressão.



# EXERCÍCIO!
# Vamos tentar agora fazer a regressão entre ideologia e apoio a um governo militar.
# A variável de apoio a um governo militar tem valores invertidos (1 = Ótimo e 4 = Péssimo).
# Para facilitar a interpretação dos resultados, vamos corrigir os valores da variável de governo militar.
# Lembrem, a variável tem 4 pontos, então subtraímos a variável por 5 (4+1) para ter os valores certos.
WVS$Q237_2 <- 5 - WVS$Q237

# Feito isso, agora é com vocês.
# Rode o "modelo_2" com uma regressão em que a ideologia é a VD e apoio ao governo militar é IV.
# Não equeça de fazer o summary!

modelo_2 <- ...
summary(modelo_2)




# 4.3.2 Regressões lineares múltiplas

# Podemos também fazer regressões com múltiplas VI (X).

# Vamos rodar uma regressão para ideologia como VD e apoio a um governo militar, idade e gênero como VIs.
modelo_3 <- lm(Q240 ~ Q237_2 + Q260 + idade, data = WVS) 
summary(modelo_3)

# Note: a fórmula é a mesma, basta acrescentar as demais IVs após a primeira com o sinal de "+".
# Observem que o coeficiente para governo militar continua alto mesmo depois de controlarmos para variáveis de idade e gênero.


      ## Ps.: a variável de ideologia, embora seja uma escala de 10 pontos, não é necessariamente numérica contínua.
      ## Usamos aqui mais para demonstrar como fazer regressões no R.



# 4.3.3 Modelos lineares generalizados

# Modelos lineares generalizados são uma ampliação das regressões lineares que vimos anteriormente. 

# Eles possuem pressupostos mais flexíveis e admitem aplicações em variáveis dependentes que possuem distribuições não-normais.

# Aqui, nós vamos focar em um tipo específico: a regressão logística.

# Regressões logísticas admitem que usemos variáveis dummy (0 e 1) como variável dependente (Y).


# Vamos testar uma regressão logística com os respondentes que apoiam um governo militar.
# Primeiro, precisamos preparar a variável, tornando-a dummy.
WVS$governomilitar <- as.numeric(WVS$Q237_2 > 2)
WVS %>% count(governomilitar)


# Agora podemos rodar o modelo de regressão logística simples para o apoio ao governo militar e ideologia.
modelo_4 <- glm(governomilitar ~ Q240, data = WVS, family = "binomial")
summary(modelo_4)

# Na função "glm", temos uma codificação muito similar àquela da função "lm". A diferença é que aqui precisamos indicar o tipo
# de modelo linear generalizado que queremos utilizar por meio da função "family = ...". 
# Para a regressão logística, utilizamos "family = "binomial"".


# Agora vamos rodar uma regressão logística múltipla, controlando para idade e gênero.
modelo_5 <- glm(governomilitar ~ Q240 + Q260 + idade, data = WVS, family = "binomial")
summary(modelo_5)



# Regressões logísticas não retornam um Rˆ2 da mesma forma que regressões lineares fazem. 

# O Rˆ2 é uma medida que nos ajuda a compreender a capacidade explicativa da variância em um modelo. Quanto maior, melhor o ajuste.

# Para produzir uma medida "aproximada" nas regressões logísticas (Pseudo Rˆ2), instale a biblioteca "DescTools".
install.packages("DescTools")
library(DescTools)
PseudoR2(modelo_4, "McFadden")

# Coloque a função "PseudoR2, indique o objeto do modelo e o método de Pseudo Rˆ2 que você escolher. 

# O McFadden é apenas um dos métodos para essa medida, existem outros.
# Mas note que o Pseudo Rˆ2 serve para vermos apenas o ajuste do modelo e não sua capacidade explicativa.




    ## 4.4 Comparando grupos

# Testes de comparação de grupos são interessantes para verificar se esses grupos diferem significativamente.

# Existem diferentes tipos de testes estatísticos para comparar grupos (student t-test, wilcoxon, mann-whitney, anova...).

# Esses testes são utilizados, sobretudo, em pesquisas experimentais ou quasi-experimentais, em que o objetivo
# é verificar se uma intervenção resultou ou não em variação na variável dependente. Nesses casos, os grupos são:
# grupo-controle (não exposto à intervenção) e grupo-tratamento (exposto à intervenção). Variações são possíveis.

# Quando não estamos fazendo um estudo experimental, testes comparam grupos ainda podem ser interessantes.

# Eles podem nos ajudar a verificar se a diferença observada entre um grupo A e um grupo B é significante ou não.

# Em outras palavras, se essa diferença é atributo do acaso ou não.


# Existem testes de comparação de grupos paramétricos e não-paramétricos.
# Os não-paramétricos mais utilizados são os testes Wilcoxon-Mann-Whitney (para 2 grupos) e Kruskal-Wallis (mais de 2 grupos).
# Vamos focar nesses.


# Vamos supor que queremos saber se a diferença na média de ideologia por gênero é significativa.
# Para isso, podemos usar o teste Wilcoxon-Mann-Whitney (duas amostras independentes: homens e mulheres).
# Vamos testar:
wilcox.test(WVS$Q240 ~ WVS$Q260, paired=F)

# Aqui, colocamos a função "wilcox.test" seguida da variável dependente (ideologia), da variável dos grupos (gênero),
# e, por fim, da função "paired = F" para indicar que as amostras são independentes.
# Como podemos ver, as diferenças nas médias de ideologia por gênero não é estatisticamente significativa.


# Vamos testar agora com a variável que criamos para apoio ao governo militar.
wilcox.test(WVS$Q240 ~ WVS$governomilitar, paired=F)
# Agora sim, temos diferenças estatisticamente significativas.


# Agora vamos testar comparações de médias com mais de 2 grupos.

# Para isso, e considerando que nossas variáveis não têm distribuição normal, devemos fazer o teste Kruskal-Wallis.
# Vamos testar as diferenças de ideologia entre gerações:
kruskal.test(Q240 ~ geracoes, data = WVS)

# A função do Kruskal-Wallis é similar às demais que estamos utilizando. Mas note que, na variável de gerações, temos 4 grupos.
# Os resultados gerados não são estatisticamente significantes, logo diferentes grupos geracionais não diferem em ideologia.





    ### Terminamos a Unidade 3!







