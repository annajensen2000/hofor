# HOFOR case

Data from https://www.hofor.dk/erhverv/fjernvarme/forbrugsanalyser-af-fjernvarme/

## Case process

1. Data load
2. Data prep
3. Data modelling
4. Export of data to parquet files
5. Upload to GitHub as blob storage
6. Import data to Power BI for semantic modelling
7. Perform semantic modelling
8. Visualise

## DuckDB pipeline

Data load, model and export is run with

```
duckdb -f sql/datamodeling.sql db.duckdb
duckdb -f sql/export.sql db.duckdb
```
