-- =============================================
-- RFM Analysis: Customer Segmentation
-- Author: Aline Sato
-- Tool: Google BigQuery
-- Dataset: Online Retail II (UCI)
-- Reference date: 2011-12-09 (last date in dataset)
-- =============================================

CREATE OR REPLACE TABLE `rfm-analysis-portfolio.rfm_analysis.rfm_segments` AS

WITH rfm_base AS (
  SELECT
    `Customer ID`                                        AS customer_id,
    MAX(DATE(InvoiceDate))                               AS last_purchase_date,
    COUNT(DISTINCT Invoice)                              AS frequency,
    ROUND(SUM(Quantity * Price), 2)                      AS monetary
  FROM `rfm-analysis-portfolio.rfm_analysis.online_retail`
  WHERE
    `Customer ID` IS NOT NULL
    AND Quantity > 0
    AND Price > 0
  GROUP BY `Customer ID`
),

rfm_calc AS (
  SELECT
    customer_id,
    DATE_DIFF(DATE '2011-12-09', last_purchase_date, DAY) AS recency,
    frequency,
    monetary
  FROM rfm_base
  WHERE monetary > 0
),

rfm_scores AS (
  SELECT
    customer_id,
    recency,
    frequency,
    monetary,
    NTILE(5) OVER (ORDER BY recency DESC)   AS r_score,
    NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,
    NTILE(5) OVER (ORDER BY monetary ASC)  AS m_score
  FROM rfm_calc
)

SELECT
  customer_id,
  recency,
  frequency,
  ROUND(monetary, 2)                             AS monetary,
  r_score,
  f_score,
  m_score,
  CONCAT(CAST(r_score AS STRING),
         CAST(f_score AS STRING),
         CAST(m_score AS STRING))                AS rfm_code,
  CASE
    WHEN r_score = 5 AND f_score >= 4            THEN 'Champions'
    WHEN r_score >= 4 AND f_score >= 3           THEN 'Loyal Customers'
    WHEN r_score >= 3 AND f_score = 1            THEN 'Promising'
    WHEN r_score = 5 AND f_score = 1             THEN 'New Customers'
    WHEN r_score <= 2 AND f_score >= 3           THEN 'At Risk'
    WHEN r_score = 1 AND f_score <= 2            THEN 'Lost'
    ELSE                                              'Needs Attention'
  END                                            AS segment
FROM rfm_scores
ORDER BY monetary DESC;
