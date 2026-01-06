/* Investment Performance vs Benchmark */

DECLARE @as_of_date DATE;

SELECT @as_of_date = MAX(price_date)
FROM daily_market_prices;

DROP TABLE IF EXISTS #investment_returns;

WITH price_series AS (
    SELECT
        d.investment_id,
        d.price_date,
        d.market_price,
        FIRST_VALUE(d.market_price) OVER (
            PARTITION BY d.investment_id
            ORDER BY d.price_date
        ) AS start_price
    FROM daily_market_prices d
)
SELECT
    investment_id,
    MAX(
        (market_price - start_price) / start_price * 100.0
    ) AS investment_return_pct
INTO #investment_returns
FROM price_series
WHERE price_date = @as_of_date
GROUP BY investment_id;

DROP TABLE IF EXISTS #benchmark_return;

SELECT
    benchmark_name,
    benchmark_return AS benchmark_return_pct
INTO #benchmark_return
FROM benchmarks
WHERE benchmark_date = @as_of_date;

SELECT
    i.investment_id,
    i.instrument_type,
    r.investment_return_pct,
    b.benchmark_return_pct,
    (r.investment_return_pct - b.benchmark_return_pct) AS alpha_pct,
    CASE
        WHEN r.investment_return_pct > b.benchmark_return_pct
            THEN 'OUTPERFORM'
        ELSE 'UNDERPERFORM'
    END AS performance_flag
FROM #investment_returns r
JOIN investments i
    ON r.investment_id = i.investment_id
JOIN #benchmark_return b
    ON b.benchmark_name = 'NIFTY 50';
/* I calculated investment returns using window functions 
   and compared them against benchmark returns to derive alpha and performance flags. */
