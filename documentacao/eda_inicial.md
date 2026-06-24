# EDA Inicial - Janeiro de 2026

## Objetivo

Compreender a estrutura dos dados antes da importação para o banco de dados.

## Dataset

* Fonte: DATASUS
* Período: Janeiro de 2026
* Registros: 236.541

## Variáveis categóricas analisadas

| Coluna   | Valores encontrados      |
| -------- | ------------------------ |
| SEXO     | 1, 3, vazio              |
| MORTE    | 0, 1, vazio              |
| RACA_COR | 1, 2, 3, 4, 5, 99, vazio |

## Variáveis numéricas analisadas

| Coluna    | Intervalo encontrado |
| --------- | -------------------- |
| IDADE     | 0 a 99               |
| DIAS_PERM | 0 a 308              |
| VAL_TOT   | 0,00 a 23.221,43     |

## Campos com valores ausentes identificados

* SEXO
* MORTE
* RACA_COR
* IDADE
* DIAG_PRINC
* MUNIC_RES
* DT_INTER
* DT_SAIDA

## Problemas encontrados

* Valores ausentes em colunas importantes.
* Identificadores convertidos para notação científica pelo Excel.
* Necessidade de construir um dicionário de dados para interpretação dos códigos.

