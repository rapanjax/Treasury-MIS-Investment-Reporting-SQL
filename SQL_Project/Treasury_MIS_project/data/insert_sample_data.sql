-- 1. investments (10 rows) --

INSERT INTO investments VALUES
(1, 'Bond',   'GOI',        '2030-03-31', 7.10, 100000),
(2, 'Bond',   'GOI',        '2028-06-30', 6.85, 100000),
(3, 'Equity', 'Reliance',   NULL,         NULL, NULL),
(4, 'Equity', 'TCS',        NULL,         NULL, NULL),
(5, 'Equity', 'HDFC Bank',  NULL,         NULL, NULL),
(6, 'MF',     'HDFC AMC',   NULL,         NULL, NULL),
(7, 'MF',     'SBI MF',     NULL,         NULL, NULL),
(8, 'T-Bill', 'RBI',        '2026-01-15', 6.70, 100000),
(9, 'Equity', 'Infosys',    NULL,         NULL, NULL),
(10,'Bond',   'NTPC',       '2032-09-30', 7.40, 100000);


-- 2. portfolio_holdings (20 rows – multiple lots) --

INSERT INTO portfolio_holdings VALUES
(1, 1, 50,  98500, '2024-01-10'),
(2, 1, 30,  99000, '2024-04-15'),
(3, 2, 40,  97000, '2024-02-12'),
(4, 2, 20,  97500, '2024-05-20'),

(5, 3, 100, 2450,  '2024-03-01'),
(6, 3, 50,  2520,  '2024-06-18'),

(7, 4, 80,  3650,  '2024-01-25'),
(8, 4, 40,  3720,  '2024-07-02'),

(9, 5, 120, 1450,  '2024-02-14'),
(10,5, 60,  1485,  '2024-08-10'),

(11,6, 200, 102.5, '2024-01-05'),
(12,6, 150, 105.2, '2024-05-22'),

(13,7, 180, 98.6,  '2024-03-18'),

(14,8, 60,  99000, '2024-09-01'),

(15,9, 90,  1320,  '2024-02-08'),
(16,9, 40,  1355,  '2024-06-30'),

(17,10,70,  97500, '2024-04-11'),
(18,10,30,  98000, '2024-08-05'),

(19,3, 40,  2550,  '2024-10-10'),
(20,5, 50,  1505,  '2024-11-01');


-- 3. daily_market_prices (≈ 300 rows) --

;WITH dates AS (
    SELECT CAST('2024-11-01' AS DATE) AS price_date
    UNION ALL
    SELECT DATEADD(DAY, 1, price_date)
    FROM dates
    WHERE price_date < '2024-11-30'
),
base_prices AS (
    SELECT investment_id,
           CASE instrument_type
               WHEN 'Equity' THEN 1000
               WHEN 'MF' THEN 100
               WHEN 'Bond' THEN 100000
               WHEN 'T-Bill' THEN 100000
           END AS base_price
    FROM investments
)
INSERT INTO daily_market_prices
SELECT
    d.price_date,
    b.investment_id,
    ROUND(
        b.base_price *
        (1 + (ABS(CHECKSUM(NEWID())) % 100 - 50) / 10000.0),
        2
    ) AS market_price
FROM dates d
CROSS JOIN base_prices b
OPTION (MAXRECURSION 1000);


-- 4. cash_flows (≈ 50 rows)

INSERT INTO cash_flows VALUES
(1, '2024-12-31', 'Interest',   3550, 1),
(2, '2025-06-30', 'Interest',   3550, 1),
(3, '2024-12-31', 'Interest',   3425, 2),
(4, '2025-06-30', 'Interest',   3425, 2),

(5, '2024-11-20', 'Dividend',   1200, 3),
(6, '2025-03-15', 'Dividend',   1350, 3),
(7, '2024-12-10', 'Dividend',   1800, 4),
(8, '2025-04-10', 'Dividend',   1950, 4),

(9, '2024-12-05', 'Dividend',   1100, 5),
(10,'2025-03-25', 'Dividend',   1250, 5),

(11,'2024-11-30', 'Dividend',   850,  6),
(12,'2025-02-28', 'Dividend',   900,  6),

(13,'2024-12-15', 'Dividend',   780,  7),
(14,'2025-03-15', 'Dividend',   820,  7),

(15,'2026-01-15', 'Redemption',100000,8),

(16,'2024-12-20', 'Dividend',   1400, 9),
(17,'2025-03-20', 'Dividend',   1550, 9),

(18,'2025-09-30', 'Redemption',100000,10);


-- 5. benchmarks (≈ 250 rows) --

;WITH dates AS (
    SELECT CAST('2024-11-01' AS DATE) AS benchmark_date
    UNION ALL
    SELECT DATEADD(DAY, 1, benchmark_date)
    FROM dates
    WHERE benchmark_date < '2025-07-08'
)
INSERT INTO benchmarks
SELECT
    1 AS benchmark_id,
    'NIFTY 50' AS benchmark_name,
    benchmark_date,
    ROUND((ABS(CHECKSUM(NEWID())) % 80 - 40) / 100.0, 3)
FROM dates
OPTION (MAXRECURSION 1000);


-- 6. counterparty_limits (6 rows) --

INSERT INTO counterparty_limits VALUES
('GOI',        5000000),
('Reliance',   2000000),
('TCS',        1800000),
('HDFC Bank',  1600000),
('NTPC',       1500000),
('RBI',        4000000);
