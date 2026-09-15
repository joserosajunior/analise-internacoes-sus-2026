-- ============================================================
-- PROJETO: Análise de Internações Hospitalares do SUS
-- PERÍODO: Janeiro de 2026
-- ARQUIVO: 04_custos.sql
-- OBJETIVO: Analisar os valores registrados por diagnóstico
-- ============================================================

USE projeto_sus;

-- VAL_TOT é tratado como valor registrado na base, não como custo real completo.

-- 1. Top 10 por valor total registrado
SELECT
    d.DESCRICAO AS diagnostico,
    COUNT(*) AS total_internacoes,
    ROUND(SUM(i.VAL_TOT), 2) AS valor_total_registrado
FROM internacoes_jan_2026 i
INNER JOIN dim_cid10 d ON i.DIAG_PRINC = d.CODIGO
GROUP BY d.DESCRICAO
ORDER BY valor_total_registrado DESC
LIMIT 10;

-- 2. Top 10 por valor médio (mínimo de 100 internações)
SELECT
    d.DESCRICAO AS diagnostico,
    COUNT(*) AS total_internacoes,
    ROUND(AVG(i.VAL_TOT), 2) AS valor_medio
FROM internacoes_jan_2026 i
INNER JOIN dim_cid10 d ON i.DIAG_PRINC = d.CODIGO
GROUP BY d.DESCRICAO
HAVING COUNT(*) >= 100
ORDER BY valor_medio DESC
LIMIT 10;

-- 3. Participação percentual no valor total registrado
WITH valor_por_diagnostico AS (
    SELECT
        d.DESCRICAO AS diagnostico,
        COUNT(*) AS total_internacoes,
        SUM(i.VAL_TOT) AS valor_total
    FROM internacoes_jan_2026 i
    INNER JOIN dim_cid10 d ON i.DIAG_PRINC = d.CODIGO
    GROUP BY d.DESCRICAO
)
SELECT
    diagnostico,
    total_internacoes,
    ROUND(valor_total, 2) AS valor_total_registrado,
    ROUND(valor_total / (SELECT SUM(VAL_TOT) FROM internacoes_jan_2026) * 100, 2) AS percentual_do_valor_total
FROM valor_por_diagnostico
ORDER BY valor_total DESC
LIMIT 10;
