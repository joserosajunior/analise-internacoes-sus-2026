-- ============================================================
-- PROJETO: Análise de Internações Hospitalares do SUS
-- PERÍODO: Janeiro de 2026
-- ARQUIVO: 03_diagnosticos.sql
-- OBJETIVO: Analisar os diagnósticos com maior volume de internações
-- ============================================================

USE projeto_sus;

SELECT
    d.CODIGO AS codigo_cid10,
    d.DESCRICAO AS diagnostico,
    COUNT(*) AS total_internacoes
FROM internacoes_jan_2026 i
INNER JOIN dim_cid10 d ON i.DIAG_PRINC = d.CODIGO
GROUP BY d.CODIGO, d.DESCRICAO
ORDER BY total_internacoes DESC
LIMIT 10;
