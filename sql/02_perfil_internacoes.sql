-- ============================================================
-- PROJETO: Análise de Internações Hospitalares do SUS
-- PERÍODO: Janeiro de 2026
-- ARQUIVO: 02_perfil_internacoes.sql
-- OBJETIVO: Analisar o perfil das internações por sexo, idade e raça/cor
-- ============================================================

USE projeto_sus;

-- 1. Perfil por sexo
SELECT
    CASE WHEN SEXO = 1 THEN 'Masculino' WHEN SEXO = 3 THEN 'Feminino' ELSE 'Não informado' END AS sexo,
    COUNT(*) AS total_internacoes,
    ROUND(AVG(IDADE), 2) AS idade_media,
    ROUND(AVG(DIAS_PERM), 2) AS permanencia_media
FROM internacoes_jan_2026
GROUP BY CASE WHEN SEXO = 1 THEN 'Masculino' WHEN SEXO = 3 THEN 'Feminino' ELSE 'Não informado' END
ORDER BY total_internacoes DESC;

-- 2. Perfil por faixa etária
SELECT
    faixa_etaria,
    COUNT(*) AS total_internacoes,
    ROUND(AVG(DIAS_PERM), 2) AS permanencia_media
FROM (
    SELECT
        CASE
            WHEN IDADE BETWEEN 0 AND 12 THEN '0-12'
            WHEN IDADE BETWEEN 13 AND 18 THEN '13-18'
            WHEN IDADE BETWEEN 19 AND 39 THEN '19-39'
            WHEN IDADE BETWEEN 40 AND 59 THEN '40-59'
            WHEN IDADE >= 60 THEN '60+'
            ELSE 'Não informado'
        END AS faixa_etaria,
        DIAS_PERM
    FROM internacoes_jan_2026
) base
GROUP BY faixa_etaria
ORDER BY CASE faixa_etaria WHEN '0-12' THEN 1 WHEN '13-18' THEN 2 WHEN '19-39' THEN 3 WHEN '40-59' THEN 4 WHEN '60+' THEN 5 ELSE 6 END;

-- 3. Perfil por raça/cor
SELECT
    CASE
        WHEN RACA_COR = 1 THEN 'Branca'
        WHEN RACA_COR = 2 THEN 'Preta'
        WHEN RACA_COR = 3 THEN 'Parda'
        WHEN RACA_COR = 4 THEN 'Amarela'
        WHEN RACA_COR = 5 THEN 'Indígena'
        WHEN RACA_COR = 99 THEN 'Sem informação'
        ELSE 'Não informado'
    END AS raca_cor,
    COUNT(*) AS total_internacoes
FROM internacoes_jan_2026
GROUP BY CASE
        WHEN RACA_COR = 1 THEN 'Branca'
        WHEN RACA_COR = 2 THEN 'Preta'
        WHEN RACA_COR = 3 THEN 'Parda'
        WHEN RACA_COR = 4 THEN 'Amarela'
        WHEN RACA_COR = 5 THEN 'Indígena'
        WHEN RACA_COR = 99 THEN 'Sem informação'
        ELSE 'Não informado'
    END
ORDER BY total_internacoes DESC;

-- 4. Mortalidade por sexo
SELECT
    CASE WHEN SEXO = 1 THEN 'Masculino' WHEN SEXO = 3 THEN 'Feminino' ELSE 'Não informado' END AS sexo,
    COUNT(*) AS total_internacoes,
    SUM(CASE WHEN MORTE = 1 THEN 1 ELSE 0 END) AS total_obitos,
    ROUND(SUM(CASE WHEN MORTE = 1 THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS taxa_mortalidade
FROM internacoes_jan_2026
GROUP BY CASE WHEN SEXO = 1 THEN 'Masculino' WHEN SEXO = 3 THEN 'Feminino' ELSE 'Não informado' END
ORDER BY taxa_mortalidade DESC;
