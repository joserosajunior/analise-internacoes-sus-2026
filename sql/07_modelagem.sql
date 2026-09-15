-- ============================================================
-- PROJETO: Análise de Internações Hospitalares do SUS
-- PERÍODO: Janeiro de 2026
-- ARQUIVO: 07_modelagem.sql
-- OBJETIVO: Documentar a criação e validação da dimensão CID-10
-- ============================================================

USE projeto_sus;

-- PRÉ-REQUISITOS:
-- cid10(SUBCAT, DESCRICAO) e cid10_categorias(CAT, DESCRICAO)
-- devem estar previamente carregadas.

DROP TABLE IF EXISTS dim_cid10;

CREATE TABLE dim_cid10 AS
SELECT CODIGO, DESCRICAO, NIVEL
FROM (
    SELECT
        CODIGO,
        DESCRICAO,
        NIVEL,
        ROW_NUMBER() OVER (PARTITION BY CODIGO ORDER BY prioridade) AS rn
    FROM (
        SELECT SUBCAT AS CODIGO, DESCRICAO, 'SUBCATEGORIA' AS NIVEL, 1 AS prioridade
        FROM cid10
        UNION ALL
        SELECT CAT AS CODIGO, DESCRICAO, 'CATEGORIA' AS NIVEL, 2 AS prioridade
        FROM cid10_categorias
    ) fontes
) deduplicado
WHERE rn = 1;

ALTER TABLE dim_cid10 MODIFY CODIGO VARCHAR(10) NOT NULL;
ALTER TABLE dim_cid10 ADD PRIMARY KEY (CODIGO);

-- Validação de duplicidades: resultado esperado = nenhuma linha
SELECT CODIGO, COUNT(*) AS quantidade
FROM dim_cid10
GROUP BY CODIGO
HAVING COUNT(*) > 1;

-- Distribuição por nível
SELECT NIVEL, COUNT(*) AS quantidade_codigos
FROM dim_cid10
GROUP BY NIVEL
ORDER BY quantidade_codigos DESC;

-- Correspondência com DIAG_PRINC
SELECT COUNT(*) AS total_sem_correspondencia
FROM internacoes_jan_2026 i
LEFT JOIN dim_cid10 d ON i.DIAG_PRINC = d.CODIGO
WHERE d.CODIGO IS NULL;
