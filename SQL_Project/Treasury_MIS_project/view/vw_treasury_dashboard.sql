/* 5.5 — Management Dashboard Dataset (FINAL SQL VIEW) */

CREATE OR ALTER VIEW vw_treasury_dashboard AS
WITH as_of_date AS (
    SELECT MAX(price_date) AS valuation_date
    FROM daily_market_prices
)
SELECT
    i.instrument_type,
    i.issuer,
    SUM(p.quantity * d.market_price) AS market_value,
    SUM((d.market_price - p.purchase_price) * p.quantity) AS unrealized_pnl
FROM portfolio_holdings p
JOIN investments i
    ON p.investment_id = i.investment_id
JOIN daily_market_prices d
    ON p.investment_id = d.investment_id
JOIN as_of_date a
    ON d.price_date = a.valuation_date
GROUP BY
    i.instrument_type,
    i.issuer;
