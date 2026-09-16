COPY fact_forbrug
TO 'data/fact_forbrug.parquet'
(FORMAT PARQUET);

COPY dim_installation
TO 'data/dim_installation.parquet'
(FORMAT PARQUET);

COPY dim_device
TO 'data/dim_device.parquet'
(FORMAT PARQUET);

COPY dim_date
TO 'data/dim_date.parquet'
(FORMAT PARQUET);
