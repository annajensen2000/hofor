select count(distinct id) from fact_forbrug;

SELECT distinct validation_info
FROM fact_forbrug;

SELECT
    installation_id,
    COUNT(DISTINCT device_id) AS antal_devices
FROM fact_forbrug
GROUP BY installation_id
HAVING COUNT(DISTINCT device_id) > 1
ORDER BY antal_devices DESC;

SELECT
    COUNT(*) AS installations,
    SUM(CASE WHEN antal_devices = 1 THEN 1 ELSE 0 END) AS one_device,
    SUM(CASE WHEN antal_devices > 1 THEN 1 ELSE 0 END) AS multiple_devices
FROM (
    SELECT
        installation_id,
        COUNT(DISTINCT device_id) AS antal_devices
    FROM fact_forbrug
    GROUP BY installation_id
);

-- HUH?
SELECT
    installation_id,
    COUNT(DISTINCT device_id) AS antal_devices,
    COUNT(DISTINCT areal) AS antal_arealer,
    MIN(areal) AS min_areal,
    MAX(areal) AS max_areal
FROM fact_forbrug
GROUP BY installation_id
HAVING COUNT(DISTINCT device_id) > 1
ORDER BY installation_id;

-- undersøger umiddelbare tendenser for energiforbrug for byggeperiode og år
select avg(cum_energy/areal), byggeperiode, year from fact_forbrug group by byggeperiode, year
order by year desc;

SELECT
    device_id,
    byggeperiode,
    year,
    SUM(hourly_energy) AS annual_energy,
    MAX(areal) AS areal
FROM fact_forbrug
GROUP BY
    device_id,
    byggeperiode,
    year;

SELECT
    COUNT(*) AS rows,
    COUNT(DISTINCT installation_id) AS ids,
    COUNT(DISTINCT device_id) AS devices,
    COUNT(DISTINCT aflæsningsdato) AS dates,
    MIN(aflæsningsdato) AS min_date,
    MAX(aflæsningsdato) AS max_date
FROM fact_forbrug;

SELECT
    device_id,
    aflæsningsdato,
    COUNT(*) AS antal
FROM fact_forbrug
GROUP BY device_id, aflæsningsdato
HAVING COUNT(*) > 1
ORDER BY antal DESC;

--ser at der fremkommer dubletter for vidse aflæsgningsdatoer + device id kombinationer.
--Ved at inspicere data ligner det at det skyldes ændring til vintertid
-- begge afslæsninger er derfor valide

SELECT *
FROM fact_forbrug
WHERE device_id = 533276198
  AND aflæsningsdato = '2025-10-26 02:00:00';

SELECT
    aflæsningsdato,
    energi,
    flow,
    frem,
    retur,
    validation_info
FROM fact_forbrug
WHERE device_id = 533276198
ORDER BY aflæsningsdato;

SELECT
    year,
    COUNT(*) AS rows,
    COUNT(DISTINCT device_id) AS devices,
    COUNT(DISTINCT aflæsningsdato) AS dates,
    MIN(aflæsningsdato) AS first_date,
    MAX(aflæsningsdato) AS last_date
FROM fact_forbrug
GROUP BY year
ORDER BY year;

-- påbegynder lidt mere proper analyse:
SELECT
    byggeperiode,
    year,
    AVG(hourly_energy) AS avg_hourly_energy
FROM fact_forbrug
GROUP BY
    byggeperiode,
    year
ORDER BY
    year,
    byggeperiode;

SELECT
    byggeperiode,
    year,
    AVG(hourly_energy / areal) AS avg_energy_per_m2
FROM fact_forbrug
WHERE hourly_energy IS NOT NULL
  AND areal > 0
GROUP BY
    byggeperiode,
    year
ORDER BY
    year,
    byggeperiode;

SELECT
    year,
    COUNT(*) AS readings,
    COUNT(DISTINCT id) AS installations,
    COUNT(DISTINCT device_id) AS devices
FROM fact_forbrug
GROUP BY year
ORDER BY year;

SELECT
    installation_id,
    COUNT(DISTINCT byggeperiode) AS byggeperioder,
    COUNT(DISTINCT bygningstype) AS bygningstyper,
    COUNT(DISTINCT areal) AS arealer
FROM fact_forbrug
GROUP BY installation_id
HAVING
    COUNT(DISTINCT byggeperiode) > 1
    OR COUNT(DISTINCT bygningstype) > 1
    OR COUNT(DISTINCT areal) > 1;

SELECT
    installation_id,
    device_id,
    areal,
    COUNT(*) AS antal_readings
FROM fact_forbrug
WHERE installation_id IN (1993142, 5788454, 253039)
GROUP BY
    installation_id,
    device_id,
    areal
ORDER BY
    installation_id,
    device_id,
    areal;

SELECT
    device_id,
    COUNT(DISTINCT installation_id) AS antal_installationer
FROM fact_forbrug
GROUP BY device_id
HAVING COUNT(DISTINCT installation_id) > 1;
