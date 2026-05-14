-- =============================================
-- RFM Analysis: Segment Summary
-- Author: Aline Sato
-- Tool: Google BigQuery
-- =============================================

SELECT
  segment,
  COUNT(customer_id)          AS total_customers,
  ROUND(AVG(recency), 1)      AS avg_recency_days,
  ROUND(AVG(frequency), 1)    AS avg_frequency,
  ROUND(AVG(monetary), 2)     AS avg_monetary,
  ROUND(SUM(monetary), 2)     AS total_revenue
FROM `rfm-analysis-portfolio.rfm_analysis.rfm_segments`
GROUP BY segment
ORDER BY total_revenue DESC;
