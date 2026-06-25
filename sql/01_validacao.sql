-- Total de registros

SELECT COUNT(*) AS TOTAL_REGISTROS
FROM internacoes_jan_2026;

-- Distribuição por sexo

SELECT SEXO, COUNT(*) AS TOTAL
FROM internacoes_jan_2026
GROUP BY SEXO
ORDER BY SEXO;

-- Distribuição por mortalidade

SELECT MORTE, COUNT(*) AS TOTAL
FROM internacoes_jan_2026
GROUP BY MORTE
ORDER BY MORTE;

-- Distribuição por raça/cor

SELECT RACA_COR, COUNT(*) AS TOTAL
FROM internacoes_jan_2026
GROUP BY RACA_COR
ORDER BY RACA_COR;
