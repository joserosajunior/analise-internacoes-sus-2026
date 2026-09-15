-- ============================================================
-- PROJETO: Análise de Internações Hospitalares do SUS
-- PERÍODO: Janeiro de 2026
-- ARQUIVO: 05_permanencia_leitos.sql
-- OBJETIVO: Analisar permanência média e dias acumulados por diagnóstico
-- ============================================================

USE projeto_sus;

-- 1. Top 10 por permanência média (mínimo de 100 internações)
SELECT
    d.DESCRICAO AS diagnostico,
    COUNT(*) AS total_internacoes,
    ROUND(AVG(i.DIAS_PERM), 2) AS permanencia_media
FROM internacoes_jan_2026 i
INNER JOIN dim_cid10 d ON i.DIAG_PRINC = d.CODIGO
GROUP BY d.DESCRICAO
HAVING COUNT(*) >= 100
ORDER BY permanencia_media DESC
LIMIT 10;

-- 2. Top 10 por dias de permanência acumulados
SELECT
    d.DESCRICAO AS diagnostico,
    COUNT(*) AS total_internacoes,
    SUM(i.DIAS_PERM) AS dias_permanencia_acumulados
FROM internacoes_jan_2026 i
INNER JOIN dim_cid10 d ON i.DIAG_PRINC = d.CODIGO
GROUP BY d.DESCRICAO
ORDER BY dias_permanencia_acumulados DESC
LIMIT 10;
