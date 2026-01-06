/* Cash Flow Forecast MIS */
DECLARE @as_of_date DATE;

SELECT @as_of_date = MAX(price_date)
FROM daily_market_prices;

SELECT
    FORMAT(flow_date, 'yyyy-MM') AS month,
    flow_type,
    SUM(amount) AS expected_cash_flow
FROM cash_flows
WHERE flow_date >= @as_of_date
GROUP BY FORMAT(flow_date, 'yyyy-MM'), flow_type
ORDER BY month, flow_type;
 
-- I aggregated future cash flows by month to support liquidity planning and treasury forecasting.