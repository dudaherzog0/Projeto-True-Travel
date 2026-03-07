# Projeto True Travel

## Objetivo
Este projeto tem como objetivo apresentar meus conhecimentos referentes à modelagem de dados, estruturação de banco de dados e geração de insights a partir dos dados da empresa fictícia True Travel.

---

## Metodologia

- Modelagem de dados utilizando o método **Snowflake**  
- Estruturação do banco de dados através da ferramenta **MySQL**  
- Construção de dashboards no **Power BI** utilizando a metodologia de **storytelling com dados**

---

## Cronologia do Projeto

1. Definir o modelo de negócios da empresa True Travel  
2. Determinar quais perguntas de negócio serão respondidas através dos dashboards  
3. Modelagem do banco de dados  
4. Estruturação e organização do banco de dados  
5. Estruturação de medidas, OKR’s e KPI’s  
6. Organização das visualizações  

---

# Modelo de Negócio

A **True Travel** é uma empresa do setor de turismo que atua exclusivamente de forma online desde 2020. Atualmente, a empresa conta com uma equipe de **4 colaboradores**, cada um com salário fixo de **R$ 1.600,00**.

A empresa estabelece uma **meta mensal de vendas de R$ 300.000,00**. Quando essa meta é atingida, cada colaborador recebe uma **bonificação de R$ 300,00**.

Além disso, existe também uma **meta individual de vendas de R$ 80.000,00 por colaborador**. Ao alcançá-la, o colaborador recebe uma **bonificação adicional de R$ 200,00**.

Em relação à receita:

- A **True Travel** obtém **10% sobre o valor total das vendas realizadas**
- Cada colaborador recebe **2% de comissão sobre as vendas efetuadas**

---

# Perguntas de Negócio

## Visão Geral da Empresa

- Qual é o total de vendas realizadas?
- Qual é o faturamento mensal da empresa?
- Qual é o lucro mensal obtido?
- Qual é a margem de lucro da empresa?
- Qual vendedor realizou o maior volume de vendas em cada mês?
- A empresa atingiu a meta mensal de **R$ 300.000,00** em vendas?

---

## Análise dos Colaboradores

- Os colaboradores atingiram suas metas individuais?
- Qual é o valor de comissionamento recebido por cada colaborador?
- Qual é o salário de cada colaborador?
- Qual é o total de despesas geradas por colaborador?
- Quais bonificações foram pagas (meta individual e meta da empresa)?
- Quanto de lucro cada colaborador gera para a empresa?

---

## Análise das Viagens

- Qual é a quantidade de viagens no mês de referência?
- Quais clientes têm viagens programadas para o mês atual?
- Qual é o ticket médio por cliente?
- Quais são os destinos mais procurados no mês?
- Quais clientes mais compram viagens com a agência?
- Qual é o total mensal de viagens realizadas?

---

## Modelagem de Dados
Para a estruturação do banco de dados foi adotado o **modelo Snowflake (Floco de Neve)**.

Diferentemente do modelo Star Schema, no qual todas as dimensões se conectam diretamente à tabela fato, o modelo Snowflake permite que algumas dimensões se relacionem entre si. Essa estrutura proporciona um maior nível de granularidade dos dados, favorecendo uma organização mais detalhada e estabelecendo relações mais estruturadas entre as tabelas dimensionais e a tabela fato.

<img width="632" height="422" alt="Modelagem" src="https://github.com/user-attachments/assets/72913308-f398-452e-a65d-e2552f5ee545" />

---

## Dashboard Interativo True Travel

Para possibilitar uma análise mais eficiente dos dados e dos insights gerados a partir das perguntas de negócio definidas, foi desenvolvido o dashboard a seguir utilizando o Power BI. Posteriormente, o dashboard foi publicado na web e disponibilizado no GitHub para acesso público.

Dashboard disponivel no link: https://dudaherzog0.github.io/Projeto-True-Travel/ 

Pre-view: 
