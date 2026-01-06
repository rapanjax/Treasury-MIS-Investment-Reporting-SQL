--Schema Design--

CREATE TABLE investments (
    investment_id INT PRIMARY KEY,
    instrument_type VARCHAR(50),
    issuer VARCHAR(100),
    maturity_date DATE,
    coupon_rate DECIMAL(5,2),
    face_value DECIMAL(18,2)
);

--Portfolio Holdings--

CREATE TABLE portfolio_holdings (
    holding_id INT PRIMARY KEY,
    investment_id INT,
    quantity INT,
    purchase_price DECIMAL(18,2),
    purchase_date DATE,
    FOREIGN KEY (investment_id) REFERENCES investments(investment_id)
);

--Daily Market Prices--

CREATE TABLE daily_market_prices (
    price_date DATE,
    investment_id INT,
    market_price DECIMAL(18,2),
    PRIMARY KEY (price_date, investment_id),
    FOREIGN KEY (investment_id) REFERENCES investments(investment_id)
);

--Cash Flows--

CREATE TABLE cash_flows (
    flow_id INT PRIMARY KEY,
    flow_date DATE,
    flow_type VARCHAR(50),
    amount DECIMAL(18,2),
    investment_id INT,
    FOREIGN KEY (investment_id) REFERENCES investments(investment_id)
);

--Benchmarks--

CREATE TABLE benchmarks (
    benchmark_id INT,
    benchmark_name VARCHAR(50),
    benchmark_date DATE,
    benchmark_return DECIMAL(6,3)
);

--Counterparty Limits--

CREATE TABLE counterparty_limits (
    issuer VARCHAR(100),
    exposure_limit DECIMAL(18,2)
);



