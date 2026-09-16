-- load data
CREATE OR REPLACE TABLE raw_2025 AS
SELECT *
FROM read_csv('https://hoformedia.dk/csv/data_til_www_2025.csv', encoding='latin-1', column_names=['Id','device','Byggeperiode','BBR bygningstype','Areal','Aflæsningsdato','Energi [MWh]','Flow [m3]','Frem. [C]','Retur. [C]','validationInfo']);

CREATE OR REPLACE TABLE raw_2024 AS
SELECT *
FROM read_csv('https://hoformedia.dk/csv/data_www_2024.csv', encoding='latin-1', column_names=['Id','device','Byggeperiode','BBR bygningstype','Areal','Aflæsningsdato','Energi [MWh]','Flow [m3]','Frem. [C]','Retur. [C]','validationInfo']);

CREATE OR REPLACE TABLE raw_2023 AS
SELECT *
FROM read_csv('https://hoformedia.dk/csv/data_www_2023.csv', encoding='latin-1', column_names=['Id','device','Byggeperiode','BBR bygningstype','Areal','Aflæsningsdato','Energi [MWh]','Flow [m3]','Frem. [C]','Retur. [C]','validationInfo']);

CREATE OR REPLACE TABLE raw_2022 AS
SELECT *
FROM read_csv('https://hoformedia.dk/csv/data_www_2022.csv', encoding='latin-1', column_names=['Id','device','Byggeperiode','BBR bygningstype','Areal','Aflæsningsdato','Energi [MWh]','Flow [m3]','Frem. [C]','Retur. [C]','validationInfo']);

CREATE OR REPLACE TABLE raw_2021 AS
SELECT *
FROM read_csv('https://hoformedia.dk/csv/data_www_2021.csv', encoding='latin-1', column_names=['Id','device','Byggeperiode','BBR bygningstype','Areal','Aflæsningsdato','Energi [MWh]','Flow [m3]','Frem. [C]','Retur. [C]','validationInfo']);

-- staging
CREATE OR REPLACE TABLE stg_2025 AS
WITH base AS (
    SELECT
        Id AS id,
        device AS device_id,
        Byggeperiode AS byggeperiode,
        "BBR bygningstype" AS bygningstype,
        Areal AS areal,
        strptime("Aflæsningsdato", '%d-%m-%Y %H.%M.%S') AS aflæsningsdato,
        "Energi [MWh]" AS cum_energy,
        "Flow [m3]" AS cum_flow,
        "Frem. [C]" AS frem,
        "Retur. [C]" AS retur,
        validationInfo AS validation_info
    FROM raw_2025
),
with_lag AS (
    SELECT
        *,
        LAG(cum_energy) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_energy,
        LAG(cum_flow) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_flow
    FROM base
)
SELECT
    id,
    device_id,
    byggeperiode,
    bygningstype,
    areal,
    aflæsningsdato,
    cum_energy,
    cum_energy - previous_cum_energy AS hourly_energy,
    cum_flow,
    cum_flow - previous_cum_flow AS hourly_flow,
    frem,
    retur,
    validation_info,
    year(aflæsningsdato) AS year
FROM with_lag;


CREATE OR REPLACE TABLE stg_2024 AS
WITH base AS (
    SELECT
        Id AS id,
        device AS device_id,
        Byggeperiode AS byggeperiode,
        "BBR bygningstype" AS bygningstype,
        Areal AS areal,
        strptime("Aflæsningsdato", '%d-%m-%Y %H.%M.%S') AS aflæsningsdato,
        "Energi [MWh]" AS cum_energy,
        "Flow [m3]" AS cum_flow,
        "Frem. [C]" AS frem,
        "Retur. [C]" AS retur,
        validationInfo AS validation_info
    FROM raw_2024
),
with_lag AS (
    SELECT
        *,
        LAG(cum_energy) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_energy,
        LAG(cum_flow) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_flow
    FROM base
)
SELECT
    id,
    device_id,
    byggeperiode,
    bygningstype,
    areal,
    aflæsningsdato,
    cum_energy,
    cum_energy - previous_cum_energy AS hourly_energy,
    cum_flow,
    cum_flow - previous_cum_flow AS hourly_flow,
    frem,
    retur,
    validation_info,
    year(aflæsningsdato) AS year
FROM with_lag;


CREATE OR REPLACE TABLE stg_2023 AS
WITH base AS (
    SELECT
        Id AS id,
        device AS device_id,
        Byggeperiode AS byggeperiode,
        "BBR bygningstype" AS bygningstype,
        Areal AS areal,
        strptime("Aflæsningsdato", '%d-%m-%Y %H.%M.%S') AS aflæsningsdato,
        "Energi [MWh]" AS cum_energy,
        "Flow [m3]" AS cum_flow,
        "Frem. [C]" AS frem,
        "Retur. [C]" AS retur,
        validationInfo AS validation_info
    FROM raw_2023
),
with_lag AS (
    SELECT
        *,
        LAG(cum_energy) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_energy,
        LAG(cum_flow) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_flow
    FROM base
)
SELECT
    id,
    device_id,
    byggeperiode,
    bygningstype,
    areal,
    aflæsningsdato,
    cum_energy,
    cum_energy - previous_cum_energy AS hourly_energy,
    cum_flow,
    cum_flow - previous_cum_flow AS hourly_flow,
    frem,
    retur,
    validation_info,
    year(aflæsningsdato) AS year
FROM with_lag;


CREATE OR REPLACE TABLE stg_2022 AS
WITH base AS (
    SELECT
        Id AS id,
        device AS device_id,
        Byggeperiode AS byggeperiode,
        "BBR bygningstype" AS bygningstype,
        Areal AS areal,
        strptime("Aflæsningsdato", '%d-%m-%Y %H.%M.%S') AS aflæsningsdato,
        "Energi [MWh]" AS cum_energy,
        "Flow [m3]" AS cum_flow,
        "Frem. [C]" AS frem,
        "Retur. [C]" AS retur,
        validationInfo AS validation_info
    FROM raw_2022
),
with_lag AS (
    SELECT
        *,
        LAG(cum_energy) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_energy,
        LAG(cum_flow) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_flow
    FROM base
)
SELECT
    id,
    device_id,
    byggeperiode,
    bygningstype,
    areal,
    aflæsningsdato,
    cum_energy,
    cum_energy - previous_cum_energy AS hourly_energy,
    cum_flow,
    cum_flow - previous_cum_flow AS hourly_flow,
    frem,
    retur,
    validation_info,
    year(aflæsningsdato) AS year
FROM with_lag;


CREATE OR REPLACE TABLE stg_2021 AS
WITH base AS (
    SELECT
        Id AS id,
        device AS device_id,
        Byggeperiode AS byggeperiode,
        "BBR bygningstype" AS bygningstype,
        Areal AS areal,
        strptime("Aflæsningsdato", '%d-%m-%Y %H.%M.%S') AS aflæsningsdato,
        "Energi [MWh]" AS cum_energy,
        "Flow [m3]" AS cum_flow,
        "Frem. [C]" AS frem,
        "Retur. [C]" AS retur,
        validationInfo AS validation_info
    FROM raw_2021
),
with_lag AS (
    SELECT
        *,
        LAG(cum_energy) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_energy,
        LAG(cum_flow) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_flow
    FROM base
)
SELECT
    id,
    device_id,
    byggeperiode,
    bygningstype,
    areal,
    aflæsningsdato,
    cum_energy,
    cum_energy - previous_cum_energy AS hourly_energy,
    cum_flow,
    cum_flow - previous_cum_flow AS hourly_flow,
    frem,
    retur,
    validation_info,
    year(aflæsningsdato) AS year
FROM with_lag;

-- normalize schema
CREATE OR REPLACE TABLE fact_forbrug AS

WITH all_years AS (

    SELECT
        id AS installation_id,
        device_id,
        byggeperiode,
        bygningstype,
        areal,
        aflæsningsdato,
        cum_energy,
        cum_flow,
        frem,
        retur,
        validation_info
    FROM stg_2021

    UNION ALL

    SELECT
        id AS installation_id,
        device_id,
        byggeperiode,
        bygningstype,
        areal,
        aflæsningsdato,
        cum_energy,
        cum_flow,
        frem,
        retur,
        validation_info
    FROM stg_2022

    UNION ALL

    SELECT
        id AS installation_id,
        device_id,
        byggeperiode,
        bygningstype,
        areal,
        aflæsningsdato,
        cum_energy,
        cum_flow,
        frem,
        retur,
        validation_info
    FROM stg_2023

    UNION ALL

    SELECT
        id AS installation_id,
        device_id,
        byggeperiode,
        bygningstype,
        areal,
        aflæsningsdato,
        cum_energy,
        cum_flow,
        frem,
        retur,
        validation_info
    FROM stg_2024

    UNION ALL

    SELECT
        id AS installation_id,
        device_id,
        byggeperiode,
        bygningstype,
        areal,
        aflæsningsdato,
        cum_energy,
        cum_flow,
        frem,
        retur,
        validation_info
    FROM stg_2025
),

with_lag AS (

    SELECT
        *,

        LAG(cum_energy) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_energy,

        LAG(cum_flow) OVER (
            PARTITION BY device_id
            ORDER BY aflæsningsdato
        ) AS previous_cum_flow

    FROM all_years
)

SELECT
    installation_id,
    device_id,

    CAST(aflæsningsdato AS DATE) AS dato,
    aflæsningsdato,

    byggeperiode,
    bygningstype,
    areal,

    cum_energy,
    cum_energy - previous_cum_energy AS hourly_energy,

    cum_flow,
    cum_flow - previous_cum_flow AS hourly_flow,

    frem,
    retur,
    validation_info

FROM with_lag;


CREATE OR REPLACE TABLE dim_installation AS

SELECT
    installation_id,
    ANY_VALUE(byggeperiode) AS byggeperiode,
    ANY_VALUE(bygningstype) AS bygningstype
FROM fact_forbrug
GROUP BY installation_id;


CREATE OR REPLACE TABLE dim_device AS

SELECT DISTINCT
    device_id,
    installation_id
FROM fact_forbrug;


CREATE OR REPLACE TABLE dim_date AS

SELECT DISTINCT
    dato,

    year(dato) AS year,
    month(dato) AS month,
    quarter(dato) AS quarter,
    day(dato) AS day,
    dayofweek(dato) AS weekday

FROM fact_forbrug

ORDER BY dato;
