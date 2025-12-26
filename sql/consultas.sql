-- ======================================
-- PROYECTO 2: ANALISIS DE INCIDENCIAS
-- ======================================
-- Base de datos: analisis_incidencias
-- Herramienta: MySQL
-- ======================================

-- KPI 1 — Total de incidencias

SELECT COUNT(*) AS total_incidencias
FROM incidencias_operativas;

-- ======================================

-- KPI 2 — Incidencias por estado 

SELECT 
    estado,
    COUNT(*) AS total
FROM incidencias_operativas
GROUP BY estado
ORDER BY total DESC;

-- ======================================

-- KPI 3 — Porcentaje de incidencias atendidas

SELECT
    ROUND(
        SUM(CASE WHEN estado = 'Atendida' THEN 1 ELSE 0 END) 
        / COUNT(*) * 100
    , 2) AS porcentaje_atendidas
FROM incidencias_operativas;

-- ======================================

-- KPI 4 — Tiempo promedio de atención (general) 

SELECT 
    ROUND(AVG(tiempo_atencion_horas), 2) AS tiempo_atencion_horas
FROM incidencias_operativas
WHERE estado = 'Atendida';

-- ======================================

-- KPI 5 — Análisis — Tiempo promedio por prioridad

SELECT
    prioridad,
    ROUND(AVG(tiempo_atencion_horas), 2) AS tiempo_atencion_horas
FROM incidencias_operativas
WHERE estado = 'Atendida'
GROUP BY prioridad
ORDER BY tiempo_atencion_horas DESC;

-- ======================================

-- KPI 6 — Análisis — Estaciones con más incidencias

SELECT
    estacion,
    COUNT(*) AS total_incidencias
FROM incidencias_operativas
GROUP BY estacion
ORDER BY total_incidencias DESC
LIMIT 5;

-- ======================================

-- KPI 7 — Incidencias por mes (ordenado correctamente)

SELECT
    mes_reporte,
    COUNT(*) AS total_incidencias
FROM incidencias_operativas
GROUP BY mes_reporte
ORDER BY mes_reporte;

-- ======================================

-- KPI 8 — Separar año y mes solo para el análisis

SELECT
    SUBSTRING(mes_reporte, 1, 4) AS anio,
    SUBSTRING(mes_reporte, 6, 2) AS mes,
    COUNT(*) AS total_incidencias
FROM incidencias_operativas
GROUP BY anio, mes
ORDER BY anio, mes;