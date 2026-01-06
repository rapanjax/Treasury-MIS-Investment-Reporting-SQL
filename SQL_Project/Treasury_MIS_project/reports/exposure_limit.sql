-- Exposure & Limit Breach Report

DROP TABLE IF EXISTS #issuer_exposure;

WITH as_of_date AS (
    SELECT MAX(price_date) AS valuation_date
    FROM daily_market_prices
)
SELECT
    i.issuer,
    SUM(p.quantity * d.market_price) AS exposure
INTO #issuer_exposure
FROM portfolio_holdings p
JOIN investments i
    ON p.investment_id = i.investment_id
JOIN daily_market_prices d
    ON p.investment_id = d.investment_id
JOIN as_of_date a
    ON d.price_date = a.valuation_date
GROUP BY i.issuer;

SELECT
    e.issuer,
    e.exposure,
    c.exposure_limit,
    ROUND(e.exposure * 100.0 / c.exposure_limit, 2) AS utilization_pct,
    CASE
        WHEN e.exposure > c.exposure_limit
            THEN 'BREACH'
        ELSE 'OK'
    END AS breach_flag
FROM #issuer_exposure e
JOIN counterparty_limits c
    ON e.issuer = c.issuer
ORDER BY utilization_pct DESC;
