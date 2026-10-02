CREATE DATABASE ecommerce_return_analysis;

USE ecommerce_return_analysis;

SELECT
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns;

SELECT
    product_category,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY product_category
ORDER BY return_rate DESC;

SELECT
    delivery_delay_days,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY delivery_delay_days
ORDER BY delivery_delay_days;

SELECT
    CASE
        WHEN discount_percent < 10 THEN '0-10%'
        WHEN discount_percent < 20 THEN '10-20%'
        WHEN discount_percent < 30 THEN '20-30%'
        WHEN discount_percent < 40 THEN '30-40%'
        WHEN discount_percent < 50 THEN '40-50%'
        ELSE '50%+'
    END AS discount_range,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY discount_range
ORDER BY 
    MIN(discount_percent);
    
SELECT
    CASE
        WHEN product_rating < 1 THEN '0-1'
        WHEN product_rating < 2 THEN '1-2'
        WHEN product_rating < 3 THEN '2-3'
        WHEN product_rating < 4 THEN '3-4'
        ELSE '4-5'
    END AS rating_range,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY rating_range
ORDER BY MIN(product_rating);

SELECT
    CASE
        WHEN past_return_rate < 0.10 THEN '0-10%'
        WHEN past_return_rate < 0.20 THEN '10-20%'
        WHEN past_return_rate < 0.30 THEN '20-30%'
        WHEN past_return_rate < 0.40 THEN '30-40%'
        WHEN past_return_rate < 0.50 THEN '40-50%'
        ELSE '50%+'
    END AS past_return_range,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY past_return_range
ORDER BY MIN(past_return_rate);

SELECT
    coupon_status,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY coupon_status
ORDER BY return_rate DESC;

SELECT
    shipping_method,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY shipping_method
ORDER BY return_rate DESC;

SELECT
    payment_method,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY payment_method
ORDER BY return_rate DESC;

SELECT
    CASE
        WHEN customer_age < 20 THEN 'Under 20'
        WHEN customer_age < 30 THEN '20-29'
        WHEN customer_age < 40 THEN '30-39'
        WHEN customer_age < 50 THEN '40-49'
        WHEN customer_age < 60 THEN '50-59'
        ELSE '60+'
    END AS age_group,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY age_group
ORDER BY MIN(customer_age);

SELECT
    CASE
        WHEN past_purchase_count < 5 THEN '0-4'
        WHEN past_purchase_count < 10 THEN '5-9'
        WHEN past_purchase_count < 20 THEN '10-19'
        WHEN past_purchase_count < 30 THEN '20-29'
        ELSE '30+'
    END AS purchase_range,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY purchase_range
ORDER BY MIN(past_purchase_count);

SELECT
    CASE
        WHEN session_length_minutes < 30 THEN '0-30 min'
        WHEN session_length_minutes < 60 THEN '30-60 min'
        WHEN session_length_minutes < 90 THEN '60-90 min'
        WHEN session_length_minutes < 120 THEN '90-120 min'
        ELSE '120+ min'
    END AS session_range,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY session_range
ORDER BY MIN(session_length_minutes);

SELECT
    CASE
        WHEN num_product_views < 10 THEN '0-9'
        WHEN num_product_views < 20 THEN '10-19'
        WHEN num_product_views < 30 THEN '20-29'
        WHEN num_product_views < 40 THEN '30-39'
        ELSE '40+'
    END AS views_range,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY views_range
ORDER BY MIN(num_product_views);

SELECT
    CASE
        WHEN product_price < 25 THEN 'Under 25'
        WHEN product_price < 50 THEN '25-49'
        WHEN product_price < 100 THEN '50-99'
        WHEN product_price < 150 THEN '100-149'
        ELSE '150+'
    END AS price_range,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY price_range
ORDER BY MIN(product_price);

SELECT
    device_type,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY device_type
ORDER BY return_rate DESC;

WITH customer_segments AS (
    SELECT
        CASE
            WHEN past_return_rate < 0.20 THEN 'Low Historical Return'
            WHEN past_return_rate < 0.40 THEN 'Medium Historical Return'
            ELSE 'High Historical Return'
        END AS customer_segment,
        COUNT(*) AS total_orders,
        SUM(returned) AS returned_orders,
        ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
    FROM online_returns
    GROUP BY
        CASE
            WHEN past_return_rate < 0.20 THEN 'Low Historical Return'
            WHEN past_return_rate < 0.40 THEN 'Medium Historical Return'
            ELSE 'High Historical Return'
        END
)
SELECT *
FROM customer_segments
ORDER BY return_rate DESC;

WITH category_returns AS (
    SELECT
        product_category,
        COUNT(*) AS total_orders,
        SUM(returned) AS returned_orders,
        ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
    FROM online_returns
    GROUP BY product_category
)
SELECT *
FROM category_returns
WHERE return_rate > (
    SELECT AVG(return_rate)
    FROM category_returns
)
ORDER BY return_rate DESC;

WITH category_returns AS (
    SELECT
        product_category,
        COUNT(*) AS total_orders,
        SUM(returned) AS returned_orders,
        ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
    FROM online_returns
    GROUP BY product_category
)
SELECT
    product_category,
    total_orders,
    returned_orders,
    return_rate,
    RANK() OVER (ORDER BY return_rate DESC) AS return_rate_rank
FROM category_returns
ORDER BY return_rate_rank;

SELECT
    product_category,
    shipping_method,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM online_returns
GROUP BY
    product_category,
    shipping_method
ORDER BY return_rate DESC;

WITH risk_scoring AS (
    SELECT
        order_id,
        product_category,
        shipping_method,
        past_return_rate,
        discount_percent,
        delivery_delay_days,
        product_price,
        returned,

        (
            CASE
                WHEN past_return_rate >= 0.40 THEN 2
                WHEN past_return_rate >= 0.20 THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN discount_percent >= 40 THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN delivery_delay_days >= 3 THEN 1
                ELSE 0
            END
            +
            CASE
                WHEN product_price >= 100 THEN 1
                ELSE 0
            END
        ) AS risk_score

    FROM online_returns
)
SELECT
    CASE
        WHEN risk_score >= 4 THEN 'High Risk'
        WHEN risk_score >= 2 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level,
    COUNT(*) AS total_orders,
    SUM(returned) AS returned_orders,
    ROUND(SUM(returned) * 100.0 / COUNT(*), 2) AS return_rate
FROM risk_scoring
GROUP BY
    CASE
        WHEN risk_score >= 4 THEN 'High Risk'
        WHEN risk_score >= 2 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END
ORDER BY return_rate DESC;