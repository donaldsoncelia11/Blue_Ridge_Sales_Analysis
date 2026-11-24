# Blue Ridge Computer Sales Analysis

## Project Overview

This project uses SQL to analyze sales and financial performance for **Blue Ridge Computer Solutions**, a fictional computer repair and technology services business.

The goal is to evaluate business performance by examining sales trends, revenue streams, product and service profitability, and customer transactions. Using PostgreSQL, I analyze transactional data to identify patterns, evaluate profitability, and develop recommendations that could help business owners make more informed decisions.

This project demonstrates how SQL can be used to transform raw business data into meaningful insights that support operational and financial decision-making.

## Business Background

Blue Ridge Computer Solutions is a small technology business offering computer repair services, technical support, and equipment sales.

The dataset represents one year of business activity, from July 1, 2025, through June 30, 2026.

**Dataset Overview:**
- 900 transactions
- 180 customers
- 18 products and services
- One year of transactional data
- Includes sales, costs, quantities, and customer information
---
## Key Business Findings & Recommendations 
1. **Service Revenue and Profitability**

    Annual revenue is nearly evenly split between **services ($54,647)** and **equipment sales ($54,175).** However, services generate significantly higher profits, contributing $41,675 compared to $22,874 from equipment sales.


    ![Revenue Profit](Visualizations\profit_rev_analysis.png)

 *Chart made using Tableau Public*

**Recommendation:** Prioritize service expansion over inventory growth to improve overall profitability. Evaluate opportunities to introduce additional services, such as phone and tablet repairs or technology training. Cross-train employees to ensure the business can accommodate increased service demand as it grows.

2. **Highest-Revenue Service:** Malware Removal

    Malware removal is the highest-revenue service, generating $7,523 annually. This indicates strong customer demand for cybersecurity and malware-related support.

![Service Revenue](Visualizations\services_revenue.png)
    *Chart made using Tableau Public*

 **Recommendation:** Consider expanding cybersecurity services through additional offerings, such as security assessments, preventative maintenance, and customer education on safe internet practices.

3. **Hardware Diagnostic Pricing**

    Hardware diagnostics generate $2,218 annually, approximately 2% of total revenue. The business charges a $35 diagnostic fee regardless of whether customers proceed with the recommended repair.
    While this policy compensates technicians for their time and helps recover labor costs, it may discourage price-sensitive customers from pursuing repairs. New customers may be especially averse to this policy.
    
    **Recommendation:** Consider cash flow necessity of diagnostic fee. Evaluate alternative diagnostic pricing structures, such as applying the diagnostic fee toward completed repairs. This could reduce the initial cost barrier while encouraging customers to move forward with recommended services.

4. **Customer Retention and Growth**

    Customer retention is a significant strength of the business. **Repeat customers account for 98.3% of all transactions**, with an average transaction value of approximately $120.
    This suggests that established customers generate a substantial portion of business activity. However, it also highlights an opportunity to expand the customer base.

    **Recommendation:** Prioritize new customer acquisition through targeted marketing campaigns, referral incentives, and introductory service promotions. Free diagnostic may bring in customers who otherwise would be dissatisfied. Building a larger customer base while maintaining existing customer relationships could support long-term revenue growth without having to change pricing structures.


![Customer_retention_data](Visualizations\customer_data.png)









## Database Structure

The project uses a relational database with four primary tables:

| Table | Description |
|---|---|
| `transactions` | Individual customer transactions, including dates, quantities, prices, and costs |
| `customers` | Customer information |
| `services_products` | Products and services offered by the business |
| `categories` | Product and service category classifications |

The tables are connected using primary and foreign keys to allow analysis across customers, transactions, products, and categories.

## Tools & Technologies

- **PostgreSQL:** Database management and SQL analysis
- **SQL:** Data exploration, aggregation, joins, profitability calculations, and trend analysis
- **Visual Studio Code:** SQL development environment
- **Tableau**: data visualization and dashboards
-**ChatGBT**: artificial datasource
- **Git & GitHub:** Version control and project documentation

## SQL Skills Demonstrated

This project incorporates several SQL techniques used in business and data analysis:

- SELECT, WHERE, and ORDER BY
- Aggregate functions (SUM, COUNT, AVG)
- GROUP BY and HAVING
- INNER JOIN and LEFT JOIN
- CASE statements
- Common Table Expressions (CTEs)
- Revenue and gross profit calculations
- Profit margin analysis


## Project Structure

```text
blue_ridge_sales_analysis/
│
├── data/
│   └── CSV datasets
│
├── sql_queries/
│   ├── 01_create_tables.sql
│   ├── 02_exploratory_analysis.sql
│   ├── 03_revenue_analysis.sql
│   ├── 04_profitability_analysis.sql
│   └── 05_customer_behavior.sql
│
└── README.md
```


--- 

## Business Questions

The analysis is designed to answer the following questions:

### 1. Revenue Performance
- What is the total annual revenue generated during the reporting period?
- Which services generated the most money?
- Which services generated the least money?
- Which items sold generated the most money? 
- What is the average transaction value?


### 2. Profitability Analysis
- What is the total cost of goods sold?
- What is the overall gross profit?
- What is the business's gross profit margin?
- Which products and services generate the highest gross profit?
- Which products or services have the lowest profit margins?
- Are the highest-revenue products also the most profitable?

### 3. Customer Behavior 
- Which services and equipment are most frequently purchased?
- What percentage of revenue comes from one time customers vs repeat customers?
- What is the average transaction value for new customers vs repeat customers?

---




## SECTION 1: Revenue Performance
- What is the **total annual revenue** generated during the reporting period?
- Which **services** generated the most money?
- Which **items sold** generated the most money? 

**1. What is total annual Revenue?**
```
Select ROUND (sum(unit_price*quantity)) as revenue 
from transactions
```


**Total Annual Revenue = $108,823**



**2. Which services generate the most revenue**
```
select 
sp.item_name,
ROUND(sum(t.unit_price*t.quantity)) as revenue 
from categories as c
    INNER JOIN services_products as sp 
on sp.category_id=c.category_id
    INNER JOIN transactions as t
on t.item_id=sp.item_id
    where category_type='Service'
    GROUP by sp.item_name
        order by revenue DESC
``` 

**Malware Removal** is the highest-revenue service, generating **$7,523** in total revenue. This suggests that cybersecurity and malware-related issues represent a significant source of demand for the business.

**Hardware Diagnostics:** Blue Ridge Technology charges customers a $35 diagnostic fee for hardware-related issues, regardless of whether they proceed with the recommended repair. For example, a customer who brings in a computer requiring a hard drive replacement is still charged $35 even if they decide not to move forward with the repair.

While this policy provides the business with compensation for technicians' time and helps recover labor costs, it may also create a barrier for price-sensitive customers who are uncertain about committing to additional repairs.

Hardware diagnostics generated **$2,218, representing approximately 2% of total revenue**. Although this policy generates some revenue independently of completed repairs, it may be worth evaluating whether the diagnostic fee discourages customers from service altogether, potentially limiting additional repair revenue and customer retention.

![Services_Revenue](Visualizations\services_revenue.png)

*Visualization created using Tableau Public*

**3. Which Items Sold Generate the Most Revenue?**
```
select 
sp.item_name,
ROUND(sum(t.unit_price*t.quantity)) as revenue 
from categories as c
    INNER JOIN services_products as sp 
on sp.category_id=c.category_id
    INNER JOIN transactions as t
on t.item_id=sp.item_id
    where category_type='Product'
    GROUP by sp.item_name
        order by revenue DESC
```
![product revenue](Visualizations\Q1.3_Products_Revenue.png)
*Visualization created using Tableau Public*
- **Refurbished Laptops and Desktop Computers:** Refurbished laptops and desktop computers are the leading product revenue generators, accounting for approximately **55% of total equipment revenue**. Combined, these products generated **$31,317**, representing approximately **30% of the business's total revenue**.

    This demonstrates that refurbished computer sales are an important contributor to overall business performance. Blue Ridge Technology should continue prioritizing computer sales while evaluating inventory levels, product selection, and customer demand. 
- **SSD 500GB:** Sales of 500GB solid-state drives generated **$12,740 in revenue**, making this one of the more significant individual product categories.

    However, SSD sales should be considered in the context of the services they support. These products are frequently purchased as part of a larger computer repair, such as a hard drive replacement or system upgrade, rather than as standalone purchases. Consequently, equipment revenue alone may not fully capture the financial value of these transactions.





## Section 2: Profitability Analysis
- What is the total cost of goods sold?
- What is the overall gross profit?
- What is the business's gross profit margin?
- Which products and services generate the highest gross profit?
- Which products or services have the lowest profit margins?
- Are the highest-revenue products also the most profitable?

**1. What is the total COGS and gross profit?**
```
SELECT
ROUND(SUM(revenue)) AS TOTAL_Revenue,
ROUND(SUM(cogs)) as TOTAL_COGS,
ROUND(SUM(gross_profit)) as TOTAL_gross_profit
 FROM transactions
```

- **TOTAL REVENUE**: $108,823

- **TOTAL COST OF GOODS SOLD: $44,274**

- **TOTAL GROSS PROFIT**: $64,549


**2. Which products have the highest and lowest gross margins?**
```
SELECT
sp.item_name,
ROUND(SUM(revenue)) AS TOTAL_Revenue,
ROUND(SUM(gross_profit)) as gross_profit_total,
    ROUND(
        SUM(t.gross_profit) / NULLIF(SUM(t.revenue), 0) * 100,
        2
    ) AS gross_profit_margin
FROM categories as c 

    INNER JOIN services_products as sp 
on sp.category_id=c.category_id
    INNER JOIN transactions as t
on t.item_id=sp.item_id
    where category_type='Product'
    GROUP by sp.item_name
        order by gross_profit_total DESC
```
![product table](Visualizations\products_table.png)

**Healthy product sales after accounting for cost of goods**
- Refurbished laptops are leading total Revenue as well as gross profits
- Refurbished desktops has the second highest total revenue but is behind SSD sales in gross profit. The difference is however marginal with SSD's only profiting more than Refurbished desktops by $553. 

**3. Which services have the highest profit?**
```
SELECT

sp.item_name,
ROUND(SUM(revenue)) AS TOTAL_Revenue,
ROUND(SUM(cogs)) as COGS,
ROUND(SUM(gross_profit)) as gross_profit_total,
    ROUND(
        SUM(t.gross_profit) / NULLIF(SUM(t.revenue), 0) * 100,
        2
    ) AS gross_profit_margin
FROM categories as c 

    INNER JOIN services_products as sp 
on sp.category_id=c.category_id
    INNER JOIN transactions as t
on t.item_id=sp.item_id
    where category_type='Service'
    GROUP by sp.item_name
        order by gross_profit_total DESC
```

![service_profits](Visualizations\service_profits.png)

**Very healthy Gross Profit Margins for all services**
- Services that are leading total revenue are also leading comparible positions in gross profits. 


## Section 3: Customer Behavior 

 **1. Do repeat customers spend more than one-time customers?**
```
WITH customer_spending AS (
    SELECT
        customer_id,
        COUNT(transaction_id) AS transaction_count,
        SUM(unit_price * quantity) AS total_spent

    FROM transactions

    WHERE customer_id IS NOT NULL

    GROUP BY customer_id
)

SELECT
    CASE
        WHEN transaction_count > 1 THEN 'Repeat Customer'
        ELSE 'One-Time Customer'
    END AS customer_type,

    COUNT(customer_id) AS total_customers,
    ROUND(SUM(total_spent), 2) AS total_revenue,
    ROUND(AVG(total_spent), 2) AS avg_lifetime_customer_spending,
    ROUND(
        SUM(total_spent) / SUM(transaction_count), 2
    ) AS avg_spending_per_transaction


FROM customer_spending

GROUP BY customer_type

ORDER BY avg_lifetime_customer_spending DESC;

```
![repeat customers ](Visualizations\repeat_vs_once.png)
**Repeat Customer Spending** is a huge aspect of business 
- repeat customers spend on average **$120 per visit**, contributing to **98% of total revenue!**
- Majority of new customers come back. If business can get new customers in the door, they more than likely will return several times annually. 

**2. What percentage of transactions come from repeat customers?**
```
WITH customer_transactions AS (
    SELECT
        customer_id,
        COUNT(*) AS transaction_count
        
    FROM transactions
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
)

SELECT
    ROUND(
        COUNT(*) FILTER (
            WHERE ct.transaction_count > 1
        ) * 100.0 / COUNT(*),
        2
    ) AS repeat_customer_transaction_rate

FROM transactions t

INNER JOIN customer_transactions ct
    ON t.customer_id = ct.customer_id;
```
**98% of transactions come from repeat Customers**