/* Daily Treasury MIS Summary */

-- Step 1: Materialize the CTE into a temp table
WITH as_of_date AS (
    SELECT MAX(price_date) AS valuation_date
    FROM daily_market_prices
)
SELECT
    i.instrument_type,
    p.investment_id,
    SUM(p.quantity * d.market_price) AS market_value,
    SUM((d.market_price - p.purchase_price) * p.quantity) AS unrealized_pnl
INTO #portfolio_metrics
FROM portfolio_holdings p
JOIN investments i
    ON p.investment_id = i.investment_id
JOIN daily_market_prices d
    ON p.investment_id = d.investment_id
JOIN as_of_date a
    ON d.price_date = a.valuation_date
GROUP BY
    i.instrument_type,
    p.investment_id;

-- Step 2: Exposure by instrument
SELECT
    instrument_type,
    SUM(market_value) AS total_exposure,
    SUM(unrealized_pnl) AS total_unrealized_pnl,
    ROUND(
        SUM(market_value) * 100.0 /
        SUM(SUM(market_value)) OVER (),
        2
    ) AS exposure_pct_of_portfolio
FROM #portfolio_metrics
GROUP BY instrument_type
ORDER BY total_exposure DESC;

-- Step 3: Total portfolio summary
SELECT
    SUM(market_value) AS total_portfolio_value,
    SUM(unrealized_pnl) AS total_unrealized_pnl
FROM #portfolio_metrics;

-- Step 4: Cash inflow / outflow
WITH as_of_date AS (
    SELECT MAX(price_date) AS valuation_date
    FROM daily_market_prices
)
SELECT
    flow_type,
    SUM(amount) AS total_amount
FROM cash_flows c
JOIN as_of_date a
    ON c.flow_date = a.valuation_date
GROUP BY flow_type;