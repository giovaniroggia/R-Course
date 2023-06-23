# Olá!

# Bem-vindes à terceira unidade do curso de R.

# Hoje, nós vamos passar por alguns tópicos relacionados à manipulação e visualização de dados.
# Isso inclui modificação de variáveis e datasets, análise de dados e elaboração de gráficos.
# A aula está dividida em três partes::
# Parte I: modificação de variáveis e datasets; 
# Parte II: visualização de dados; (Estamos aqui)
# Parte III: testes estatísticos.
# Mas, antes de comerçarmos, precisamos repetir alguns comandos que aprendemos na aula de ontem.


# Começamos carregando as bibliotecas que vamos utilizar hoje (libraries)...
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




    ### Parte II da Unidade 3


    ### 3. Visualização de dados


## Antes de começarmos, algumas observações importantes!

# Eixo X corresponde à linha horizontal de um gráfico.
# Eixo Y corresponde à linha vertical de um gráfico.

# Quando criamos um gráfico, algumas visualizações fazem mais sentido em um eixo ou em outro.

# Porém, quando estamos fazendo um gráfico de interações entre variáveis, por exemplo correlações ou
# regressões lineares, devemos ter uma regra em mente:
# a) X é a variável dependente (a variável explicativa, a mais estável);
# b) Y é a variável independente (a variável a ser explicada, que vai variar com X).


# Sabendo disso, agora podemos partir para o restante da unidade 3.


# Nessa segunda parte da unidade 3, vamos aprender como visualizar dados no R.

# A visualização de dados (sobretudo, gráficos) é útil em dois momentos:
# a) antes da análise, visualizar dados pode ajudar a escolher os testes adequados;
# b) depois da análise, visualizar dados pode ajudar a comunicar resultados de pesquisa.

# Aqui, vamos passar por diferentes tipos de visualização de forma básica.

# Nosso foco será nas funções do pacote "ggplot".
# Mas as opções de gráficos, bem como as opções de costumização, são várias.

# Utilize tutoriais, fóruns e diretórios para aprender mais quando estiver trabalhando.



    ## 3.1 A codificação básica no pacote "ggplot":

# Antes de começarmos a codificar gráficos específicos, é importante nos familiarizarmos
# com a fórmula básica da codificação em "ggplot". 

# Vamos ver:
ggplot(dataset, aes(x = , y =)) + geom_...() # Não rode essa linha, é apenas um exemplo.

# Para utilizar o "ggplot", devemos colocar a função "ggplot", seguida do nome do 
# dataset, da função aes (dentro da qual você deverá indicar o eixo X e Y do gráfico) e
# por fim, indicar com"+ geom_..." qual tipo de gráfico você quer fazer. 


# Uma outra forma de utilizar a função "ggplot", é a seguinte:
dataset %>%
  ggplot(aes(x = , y =)) + geom_...()

# Nesse tipo de codificação indicamos o dataset antes, seguido de "%" e a função "ggplot";
# mas note que dentro da função "ggplot" já não precisamos indicar o nome do dataset, 
# porque essa indicação já foi feita anteriormente.



    ## 3.2 Histogramas tradicionais e gráficos de densidade

# Esses gráficos ilustram a distribuição de frequências em uma dada variável.

# Ou seja, quantas vezes cada resposta (valor) de uma variável é observada no dataset.

# Por exemplo, ao fazer um histograma ou gráfico de densidade para idade,
# temos uma representação do número de respostas dadas para cada valor da variável idade.


# Vamos ver como fica um histograma para idade:
WVS %>%
  ggplot(aes(x= idade)) + geom_histogram() 

# Vamos ver como fica um gráfico de densidade para idade:
WVS %>%
  ggplot(aes(x= idade)) + geom_density()
# Diferentemente do histograma, um gráfico de densidade apresenta as proporções dos valores.


# Histogramas e gráficos de densidade são muito úteis para verificar se uma variável
# possui uma distribuição normal ou não. A normalidade da distribuição de uma variável
# é importante para saber quais tipos de testes estatísticos são adequados ou não.

# Ex.: em comparação entre grupos, teste-t (distribuição normal) ou Wilcoxon (distribuição não-normal).



    ## 3.3 Boxplots

# Boxplots têm uma função parecida com histogramas e gráficos de densidade.

# O objetivo desse tipo de representação gráfica de dados é observar a distribuição de respostas com base nos 
# quartis, na localização e dispersão de dados.

# No boxplot, vemos: mínimo, 1o. quartil (Q1), mediana, 3o. quartil (Q3) e máximo.


# Vamos ver como fica um boxplot para ideologia:
WVS %>%
  ggplot(aes(y= Q240)) + geom_boxplot() 

# Aqui colocamos a variável que queremos gerar o boxplot no eixo Y para ficar visualmente
# mais intuitivo. Mas é possível colocá-la também no eixo X, o que inverte o gráfico.


# Boxplots podem ser úteis para analisar diferenças na dispersão de respostas entre grupos.

# Vamos ver como ficaria um boxplot para ideologia entre diferentes gerações:
WVS %>%
  ggplot(aes(x = geracoes, y= Q240)) + geom_boxplot() 

# Note que a nossa variável de gerações possui missing values (NAs).

# Para remover, acrescente uma linha no código com "drop_na()" e a variável que deseja remover NAs.
# Assim: 
WVS %>%
  drop_na(geracoes) %>%
  ggplot(aes(x = geracoes, y= Q240)) + geom_boxplot() 

# Pronto, temos um gráfico sem missing values.



    ## 3.4 Gráficos de barras

# Já conhecemos bem gráficos de barras.

# Eles podem ter diferentes tipos de informações, como contagem (frequência) ou média. 

# E eles podem ilustrar informações de uma ou mais variáveis.


# Vamos ver como fica um gráfico de barras para a contagem em confiança no governo:
WVS %>%
  ggplot(aes(x= Q71)) + geom_bar()


# E se quisermos fazer um gráfico de barras com as diferenças de respostas por gênero?
# Vamos lá:
WVS %>%
  ggplot(aes(x = Q71, fill = Q260)) + geom_bar()

# Nesse caso, colocamos a função "fill =" para indicar a variável desejamos que as barras sejam preenchidas.
# Note também que as barras estão empilhadas. Podemos alterar isso acrescentando a função "position = ".
# Vejamos:
WVS %>%
  ggplot(aes(x = Q71, fill = Q260)) + geom_bar(position="dodge")


# E se quisermos fazer gráficos de barras com a média das respostas?

# Vamos testar com a variável de ideologia. Para isso, precisamos primeiro criar o dado das médias 
# com o auxílio da função "summarise".
WVS %>%
  drop_na(Q240) %>% #removemos os NAs
  group_by(Q260) %>% #agrupamos por gênero
  summarise(mean=mean(Q240)) %>% #criamos a variável de média de ideologia
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_bar(stat="identity") # codificamos o gráfico

# Note que também acrescentamos dentro da função "geom_bar" o seguinte comando "stat="identity"".
# Esse comando é necessário porque o "geom_bar" não espera um valor para Y. 
# Colocando "stat="identity"", o "geom_bar" entende que você está fornecendo um valor para Y.


# Uma outra opção para gráficos de barra é o "geom_col". 
# Nele, a função compreende (e requer) a presença de Y.
# Testando os exemplos anteriores:
WVS %>%
  drop_na(Q71) %>%
  ggplot(aes(x = Q260, y = Q71, fill = Q71)) + geom_col()

WVS %>%
  drop_na(Q240) %>% 
  group_by(Q260) %>%
  summarise(mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col()


# Por fim, podemos também incluir outras informações, como SD's, SE's e Wilcoxon.
WVS %>%
  drop_na(Q240) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240), # Aqui acrescentamos "n=n()"
  sd=sd(Q240)) %>% # Aqui acrescentamos o cálculo para o SD (desvio padrão)
  mutate(se=sd/sqrt(n)) %>% # Aqui acrescentamos o cálculo para o SE (erro padrão)
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col() +
  geom_errorbar(aes(x=Q260, ymin=mean-se, ymax=mean+se), width=0.4) +
  stat_compare_means()



    ## 3.5 Gráficos de pontos, dispersão e linhas de regressão:

# Esses tipos de gráficos são interessantes para observar tendências de correlação entre variáveis.


# Comecemos com os gráficos de pontos e de dispersão.

# Como a maioria das variáveis do WVS são nominais ou ordinais, esses gráficos não ficam muito bons.

# Vejamos um gráfico de pontos/dispersão com as variáveis de idade e ideologia:
WVS %>%
ggplot(aes(x= idade, y = Q240)) + geom_point()

# Como a variável de ideologia tem apenas 10 pontos, a visualização da dispersão não fica muito boa.
# Esse tipo de gráfico é particularmente interessante quando temos variáveis numéricas (contínuas ou discretas).


# Vejamos um outro exemplo com idade e quantidade de pessoas morando na residência do respondente.
# (Idade: variável contínua; Pessoas na casa: variável discreta).
WVS %>%
  ggplot(aes(x= idade, y = Q270)) + geom_point() 

# Nesse gráfico temos uma dispersão mais bem representada pelos pontos.


# Agora voltemos à análise entre idade e ideologia. 
# Vamos tentar criar um gráfico com base nas médias de ideologia por idade.
# Assim, condicionamos a variável de ideologia a ter um comportamento mais numérico e menos categórico.
# Vejamos:
WVS %>%
  drop_na(Q240) %>%
  group_by(idade) %>%
  summarise(mean=mean(Q240)) %>%
  ggplot(aes(x = idade, y = mean)) + geom_point()

# Como podemos ver, agora as tendências da relação entre ideologia e idade estão mais claras.
# Observamos nesse gráfico que há uma tendência em direção à direita associada ao aumento da idade.
# Mas há alguns outliers entre os mais velhos à esquerda (old comrades?).


# Outra opção para visualizar pontos e dispersão é usar o "geom_jitter" ao invés de "geom_point".

# Jitter é particularmente interessante para visualizar a dispersão em variáveis categóricas.

# O jitter adiciona aleatoriedade baseado no espaçamento da distribuição dos pontos.
# Embora a aleatoriedade (até aonde eu sei) não consiga ser controlada (o que não é muito bom),
# ela permite uma melhor visualização da dispersão no caso de variáveis categóricas.

# Vejamos com o nosso exemplo de idade e ideologia:
WVS %>%
  ggplot(aes(x= idade, y = Q240)) + geom_jitter()

# Podemos observar que agora a representação da dispersão de ideologia por idade é mais clara.


# Agora vamos testar um passo a mais.

# Como dito anteriormente, esses gráficos são úteis para visualizar potenciais relações entre variáveis.

# Vimos no gráfico das médias de ideologia por idade que aparentemente há uma tendência positiva entre elas.

# Para conseguir visualizar se, de fato, há uma correlação entre as variáveis em um gráfico de pontos
# é adicionar a ele uma linha de regressão com a função "geom_smooth".
# Vamos testar:
WVS %>%
  drop_na(Q240) %>%
  group_by(idade) %>%
  summarise(mean=mean(Q240)) %>%
  ggplot(aes(x = idade, y = mean)) + geom_point() + geom_smooth()

# Observamos que a linha de regressão parece ascendente, sinalizando uma relação positiva entre variáveis.
# Observamos também que há uma sombra cinza acompanhando a linha de regressão; ela indica o SE (erro padrão).
# Observamos também que a linha não está reta. Isso acontece porque o método que foi utilizado é "loess".
# O método "loess" (aplicado aqui por padrão [default]) é utilizado quando a relação entre as variáveis não é linear.

# Mas podemos também tentar utilizar o método "lm" (de regressão linear [linear model]).
# Vejamos:
WVS %>%
  drop_na(Q240) %>%
  group_by(idade) %>%
  summarise(mean=mean(Q240)) %>%
  ggplot(aes(x = idade, y = mean)) + geom_point() + geom_smooth(method = "lm")

# Aqui a relação positiva fica um pouco mais clara.

# Agora com o gráfico de idade e quantidade de pessoas morando na residência do respondente.
WVS %>%
  ggplot(aes(x= idade, y = Q270)) + geom_point() + geom_smooth()

# Aqui a relação é negativa, com o número de residentes na casa do respondente reduzindo com o aumento da idade.

# Diferentemente do gráfico anterior, o método aplicado automaticamente aqui (by default) foi o "lm".
# Por isso, indique o método ao rodar a função "geom_smooth".



    ## 3.6 Customização de gráficos

# Como observamos nos gráficos anteriores, o R gera gráficos com dados textuais brutos.

# Vamos rodar novamente o gráfico de médias em ideologia por gênero e ver:
WVS %>%
  drop_na(Q240) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col()

# Observe que gênero aparece como Q260, que a média aparece apenas como mean, que as 
# legendas para "homem" e "mulher", que a escala do gráfico tem apenas 4 pontos, que
# não temos um título para o gráfico e que as cores foram pré-definidas pelo ggplot.


# Todos esses elementos podem ser custumizados.
# Vamos alterá-los e aprender um pouco sobre customização.


# 3.6.1 Alterando os labels dos eixos X e Y:
# Para isso, colocamos "+ labs(x = "Nome que desejamos", y = "Nome que desejamos")".
WVS %>%
  drop_na(Q240) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col() +
  labs(x = "Gênero",
     y = "Ideologia média")


# 3.6.2 Alterando o label do título do gráfico:
# Para isso, colocamos no "+ labs(x = ..., y = ..., title = "Nome que desejamos")".
WVS %>%
  drop_na(Q240) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col() +
  labs(x = "Gênero",
       y = "Ideologia média",
       title = "Diferenças em ideologia por gênero",
       caption = "Data source: ToothGrowth")


# 3.6.3 Inserindo uma fonte no gráfico:
# Para isso, colocamos no "+ labs(x = ..., y = ..., title = ..., caption = "o que desejamos")".
WVS %>%
  drop_na(Q240) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col() +
  labs(x = "Gênero",
       y = "Ideologia média",
       title = "Diferenças em ideologia por gênero",
       caption = "Fonte: World Values Survey, Sétima Onda, Brasil")


# 3.6.4 Customizando os labels da legenda dos grupos:

# Aqui, estamos visualizando a diferença entre dois grupos (homens e mulheres).
# Embora tenhamos alterado a legenda do eixo X para mostrar que nele está a variável de gênero,
# a legenda lateral onde há a diferença de cores entre grupos não foi alterada (segue Q260).

# Tampouco estamos informando nesse gráfico a qual gênero corresponde o número 1 e 2.

# Podemos customizar esses labels e as cores, usamos a função "scale_fill_manual".
# Nela, devemos inserir o conjunto de labels que queremos, as cores que queremos e o nome da legenda.
# Vamos ver como fazer:
WVS %>%
  drop_na(Q240) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col() +
  labs(x = "Gênero",
       y = "Ideologia média",
       title = "Diferenças em ideologia por gênero") +
  scale_fill_manual(labels=c('Homens', 'Mulheres'), values = c("green","orange"), name="Gênero")


# Agora mudando as cores...
WVS %>%
  drop_na(Q240) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col() +
  labs(x = "Gênero",
       y = "Ideologia média",
       title = "Diferenças em ideologia por gênero") +
  scale_fill_manual(labels=c('Homens', 'Mulheres'), values = c("lightgrey","darkgrey"), name="Gênero")

    ## Ps.: Existe uma outra situação para esse tipo de alteração. 
    ## Podemos indicar o preenchimento com um dado em um ggplot com "color" ao invés de "fill" também.
    ## Nesse caso, o "scale_fill_manual" não pode ser usado. Precisamos usar "scale_color_manual".


# Agora mudando a posição da legenda...

WVS %>%
  drop_na(Q240) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col() +
  labs(x = "Gênero",
       y = "Ideologia média",
       title = "Diferenças em ideologia por gênero") +
  scale_fill_manual(labels=c('Homens', 'Mulheres'), values = c("lightgrey","darkgrey"), name="Gênero") +
  theme(legend.position = "top")
# Você pode alterar a posição de qualquer elemento textual no gráfico.


# 3.6.5 Alterando os valores dos labels dos grupos:
# Nesse caso, queremos alterar os valores "1" e "2" para "homem" e "mulher".

# Para tanto, precisamos utilizar a função "mutate" e alterar os valores da variável de gênero.
# Vamos lá:
WVS %>%
  drop_na(Q240) %>%
  mutate(Q260 = if_else(Q260 ==1, "Homens", "Mulheres")) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col() +
  labs(x = "Gênero",
       y = "Ideologia média",
       title = "Diferenças em ideologia por gênero") +
  scale_fill_manual(labels=c('Homens', 'Mulheres'), values = c("green","orange"), name="Gênero")


# 3.6.6 Alterando as escalas dos eixos X e Y.
# Notemos que o nosso gráfico vai até 6 pontos. Porém, a variável de ideologia tem 10 pontos.

# Podemos alterar a escala desse gráfico para melhor representar a variável original.

# Usamos a função "ylim" para isso.
# Vamos ver: 
WVS %>%
  drop_na(Q240) %>%
  mutate(Q260 = if_else(Q260 ==1, "Homens", "Mulheres")) %>%
  group_by(Q260) %>%
  summarise(n=n(),mean=mean(Q240)) %>% 
  ggplot(aes(x = Q260, y = mean, fill = Q260)) + geom_col() +
  labs(x = "Gênero",
       y = "Ideologia média",
       title = "Diferenças em ideologia por gênero") +
  scale_fill_manual(labels=c('Homens', 'Mulheres'), values = c("green","orange"), name="Gênero") +
  ylim (0, 10) 

# Note que colocamos dois números dentro da função "ylim". 
# O primeiro número corresponde ao mínimo do eixo Y e o segundo ao máximo do eixo Y.
# Aqui, o mínimo é 0, porque não temos valores negativos, e o máximo é 10, da variável original.
# O mesmo pode ser feito com o eixo X, com a função "xlim()"



    ## 3.7 Observações finais!

# Nesse tópico, aprendemos sobre visualização de dados em R. 

# Para tanto, utilizamos o ggplot. 

# Assim como (quase tudo no R), existem outros pacotes que podem ser utilizados.
# O "plot()" é um deles.
# Por exemplo:
plot(WVS$Q240 ~ WVS$Q260) 
# ou
hist(WVS$Q240)

# O ggplot, além de consolidado, é bastante customizável e oferece muitas opções ao usuário.

# Aqui, passamos pelas funcionalidades mais típicas do ggplot (em tipos de gráficos e customização).

# Porém, existem muitas outras possibilidades dentro desse pacote.

# Recomendo, fortemente, que vocês pesquisem e façam muito uso de fóruns, sites e documentações.






    ### Terminamos a Parte II da Unidade 3.
