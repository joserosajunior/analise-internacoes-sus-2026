-- ============================================================
-- PROJETO: Análise de Internações Hospitalares do SUS
-- PERÍODO: Janeiro de 2026
-- ARQUIVO: 01_validacao_kpis.sql
-- OBJETIVO: Validar os principais KPIs utilizados no dashboard
-- ============================================================

USE projeto_sus;

SELECT
    COUNT(*) AS total_internacoes,
    SUM(CASE WHEN MORTE = 1 THEN 1 ELSE 0 END) AS total_obitos,
    ROUND(SUM(CASE WHEN MORTE = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_mortalidade,
    ROUND(SUM(VAL_TOT), 2) AS valor_total_registrado,
    ROUND(AVG(VAL_TOT), 2) AS valor_medio_por_internacao,
    ROUND(AVG(DIAS_PERM), 2) AS permanencia_media,
    SUM(DIAS_PERM) AS dias_permanencia_acumulados
FROM internacoes_jan_2026;

-- Valores esperados após a validação final:
-- 236540 internações | 12005 óbitos | 5.08% mortalidade
-- R$ 448558356.61 total | R$ 1896.33 médio
-- 5.08 dias de permanência média | 1201804 dias acumulados
