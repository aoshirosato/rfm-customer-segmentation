-- =============================================
-- RFM Analysis: Data Quality Assessment
-- Author: Aline Sato
-- Tool: Google BigQuery
-- Dataset: Online Retail II (UCI)
-- =============================================

SELECT
  COUNT(*)                                        AS total_rows,
  COUNTIF(`Customer ID` IS NULL)                  AS missing_customers,
  COUNTIF(Quantity <= 0)                          AS returns_or_errors,
  COUNTIF(Price <= 0)                             AS zero_price,
  MIN(DATE(InvoiceDate))                          AS earliest_date,
  MAX(DATE(InvoiceDate))                          AS latest_date,
  COUNT(DISTINCT `Customer ID`)                   AS unique_customers,
  COUNT(DISTINCT Invoice)                         AS unique_invoices
FROM `rfm-analysis-portfolio.rfm_analysis.online_retail`;
