-- ============================================================
-- PROJETO: Análise de Internações Hospitalares do SUS
-- PERÍODO: Janeiro de 2026
-- ARQUIVO: 06_mortalidade.sql
-- OBJETIVO: Analisar óbitos absolutos e taxa de mortalidade por diagnóstico
-- ============================================================

USE projeto_sus;

-- 1. Top 10 por número absoluto de óbitos
SELECT
    d.DESCRICAO AS diagnostico,
    COUNT(*) AS total_internacoes,
    SUM(CASE WHEN i.MORTE = 1 THEN 1 ELSE 0 END) AS total_obitos
FROM internacoes_jan_2026 i
INNER JOIN dim_cid10 d ON i.DIAG_PRINC = d.CODIGO
GROUP BY d.DESCRICAO
ORDER BY total_obitos DESC
LIMIT 10;

-- 2. Top 10 por taxa de mortalidade (mínimo de 100 internações)
SELECT
    d.DESCRICAO AS diagnostico,
    COUNT(*) AS total_internacoes,
    SUM(CASE WHEN i.MORTE = 1 THEN 1 ELSE 0 END) AS total_obitos,
    ROUND(SUM(CASE WHEN i.MORTE = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_mortalidade
FROM internacoes_jan_2026 i
INNER JOIN dim_cid10 d ON i.DIAG_PRINC = d.CODIGO
GROUP BY d.DESCRICAO
HAVING COUNT(*) >= 100
ORDER BY taxa_mortalidade DESC
LIMIT 10;
