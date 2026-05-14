# RFM Customer Segmentation Analysis

## Overview
This project applies RFM (Recency, Frequency, Monetary) methodology to segment 
customers of a UK-based online retail company, identifying behavioral patterns 
to support targeted marketing and retention strategies.

## Business Problem
The company needed to understand which customers drive the most revenue, 
which are at risk of churning, and which represent growth opportunities — 
enabling data-driven prioritization of marketing efforts.

## Dataset
- **Source:** Online Retail II dataset (UCI Machine Learning Repository)
- **Period:** December 2009 – December 2011
- **Volume:** 1,067,371 transactions | 5,942 unique customers
- **Tool:** Google BigQuery (SQL)

## Methodology

### Data Quality Assessment
Before analysis, key data issues were identified and addressed:
- 243,007 rows excluded due to missing Customer ID (guest purchases)
- 22,950 rows removed (returns/negative quantities)
- 6,207 rows removed (zero price)

### RFM Scoring
Each customer was scored 1–5 on three dimensions:
- **Recency:** Days since last purchase (lower = better)
- **Frequency:** Number of unique orders
- **Monetary:** Total revenue generated

Scores were assigned using `NTILE(5)` window function for equal distribution.

### Customer Segments
| Segment | Customers | Total Revenue | Avg. Monetary |
|---|---|---|---|
| Champions | 837 | £9,097,250 | £10,868 |
| Loyal Customers | 1,072 | £3,649,791 | £3,404 |
| Needs Attention | 1,898 | £2,854,605 | £1,504 |
| At Risk | 819 | £1,655,183 | £2,020 |
| Lost | 901 | £363,271 | £403 |
| Promising | 351 | £123,326 | £351 |

## Key Findings
- **Champions (14% of customers) generate 53% of total revenue** — a classic Pareto distribution
- **Needs Attention is the largest segment (32%)** — highest priority for re-engagement campaigns
- **At Risk customers have strong historical value (avg £2,020)** — recovery campaigns recommended

## Business Recommendations
| Segment | Recommended Action |
|---|---|
| Champions | Loyalty rewards, early access to new products |
| Loyal Customers | Upselling, referral programs |
| Needs Attention | Re-engagement emails, personalized offers |
| At Risk | Win-back campaigns with incentives |
| Lost | Low-cost reactivation or deprioritize |
| Promising | Onboarding sequences, first purchase incentives |

## Tools & Technologies
- **SQL:** Google BigQuery
- **Visualization:** Power BI *(dashboard in progress)*
- **Methodology:** RFM Segmentation, Window Functions, CTEs
