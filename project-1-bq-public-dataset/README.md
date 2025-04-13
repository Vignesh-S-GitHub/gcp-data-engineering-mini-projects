# Project 1: BigQuery Public Dataset Analysis

## Description
This project uses a public BigQuery dataset to run analytical SQL queries and extract business insights. The final result is exported to Cloud Storage for further use.

## Architecture
- **BigQuery Public Dataset**: `bigquery-public-data.stackoverflow`
- **SQL Queries**: Executed in BigQuery
- **Data Export**: Result exported to GCS (CSV)

## Tools & Stack
- GCP: BigQuery, Cloud Storage
- Language: SQL

## Steps to Run
1. Go to [BigQuery Explorer](https://console.cloud.google.com/bigquery)
2. Choose a public dataset (`stackoverflow`)
3. Write SQL queries to extract insights
4. Run the queries
5. Click on "Save Results" → "Export to Google Cloud Storage"
6. Verify output CSV in GCS bucket

