# R Course
 Repositório utilizado para estruturação do curso e desenvolvimento do respectivo material.

## Introdução

 Este arquivo (README.md) pode ser utilizado para discutir ideias gerais sobre o projeto, como formato, objetivos, etc.  
 Sintam-se livres para fazer modificações, sejam elas pontuais ou estruturais.
 
Atenção: para aqueles pouco ou nada familiares com colaborações no github, não esqueça de:
+ **clonar** o repositório. Ao clonar o repositório, ele vai ficar armazenado na sua máquina local, o que evita alguns possíveis problemas relacionados a mudanças nos documentos. Adicionalmente, ao finalizar mudanças neste ou qualquer outro documento,
+ clicar em **commit changes** para lançar as mudanças no repositório online. 
 
Caso tenham mais dicas sobre o uso do GitHub, podemos criar uma seção neste arquivo ou um novo arquivo para este fim. 
 
 ## Objetivos
 
 Conforme discutido na nossa reunião inaugural (16/05/23), a intenção é criar dois cursos separados:
 1. Um curso amplo para a formação de futuros tutores (produto intermediário).
 + Público alvo: alunos da linha  de pesquisa de cultura política
 + Sessões: duas sessões - tardes de sexta e sábado.
 2. Um curso mais restrito para análise de dados (produto final).
 + Público alvo: alunos da graduação ou pós-graduação da UFRGS
 + Sessões: duas ou três sessões de duas ou três horas (4h a 9h de curso)

## Estrutura

### Unidade 1 - Introdução ao R e IDE (RStudio)

- O que é o curso?  
- Conhecendo os instrutores e participantes    
- Instalando R e RStudio  
- Instalando pacotes  
- Gerando um relatório de análise de dados  

### Unidade 2 - Importar e analisar dados 

- Lógica de programação  
- Importando bases de dados (`read.csv`, `haven::read_sav`, `xlsx`)  
- Visualizando a base de dados e metadados (`view`, `head`, `names`, `attributes`)  
- Estatística descritiva (`sum`, `count`, `mean`, `summarise`)   
- Ponderação em surveys (`weighted.mean`)  

### Unidade 3 - Manipular e visualizar dados

- Modificando variàveis (`mutate`, `ifelse`, `case_when`)
- Criação de subsets (excluir colunas, excluir observacoes, reshape (wide & long)) 
- Gráficos (`plot`, `ggplot`)
- Correlação e testes (`cor`, `lm`, `glm`)

### Unidade 4 - Extras 

- Criando funçoes 
- Acesso a APIs e webscrapping 
- Anàlise de dados textuais  
- Criando relatórios com RMarkdown e Quarto

## Links úteis

1. GitHub e RMardown
+ RMarkdown Cheat Sheet: https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf

2. Desenvolvimento do curso
+ Análise de dados do WVS com o R do Tiago Vier: https://tiagovier.github.io/tutorial_wvsR/
