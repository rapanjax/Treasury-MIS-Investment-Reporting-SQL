# Treasury MIS & Investment Performance Reporting System

## Business Context
Treasury and mid-office teams require a centralized Management Information System (MIS) to monitor investment portfolios, track performance, manage liquidity, and control risk exposure.  
This project simulates a real-world Treasury MIS system where SQL acts as the core engine for valuation, reporting, and analytics, while visualization tools are used only for final presentation.

The system is designed to deliver accurate, timely, and audit-ready insights for management decision-making, closely reflecting how treasury analysts and financial MIS teams operate in practice.

---

## Project Objectives
- Build a SQL-driven Treasury MIS from scratch  
- Track portfolio valuation and unrealized P&L  
- Monitor instrument-wise and issuer-wise exposure  
- Compare investment performance against benchmarks  
- Forecast future cash inflows and outflows  
- Provide governed datasets for Power BI dashboards  

---

## Database Schema
The database follows a normalized relational design to reflect real treasury systems.

### Core Tables
- **investments** – Instrument master data (Equity, Bond, MF, T-Bill)  
- **portfolio_holdings** – Holdings with multiple purchase lots and dates  
- **daily_market_prices** – Daily market prices for valuation and performance  
- **cash_flows** – Interest, dividends, and redemption cash flows  
- **benchmarks** – Daily benchmark returns (e.g., NIFTY 50)  
- **counterparty_limits** – Issuer-wise exposure limits  

---

## MIS Reports & Analytics
All reports are built using advanced SQL constructs such as CTEs, window functions, temp tables, and aggregations.

### Key Reports
1. **Daily Treasury MIS Summary**  
   - Total portfolio value  
   - Unrealized P&L  
   - Cash inflow / outflow  
   - Instrument-wise exposure  

2. **Investment Performance vs Benchmark**  
   - Investment returns using price series  
   - Benchmark comparison  
   - Alpha and performance flags  

3. **Exposure & Limit Breach Report**  
   - Issuer-wise exposure  
   - Limit utilization  
   - Breach identification  

4. **Cash Flow Forecast MIS**  
   - Upcoming cash inflows  
   - Monthly liquidity view  

5. **Management Dashboard Dataset**  
   - Governed SQL view for Power BI reporting  

---

## Tools & Technologies
- SQL Server (SSMS)  
- Advanced SQL (CTEs, window functions, temp tables, views)  
- Power BI (for visualization only)  
- GitHub (version control and documentation)  

---

## How to Run
1. Run the table creation scripts from the `schema` folder  
2. Load sample data from the `data` folder  
3. Execute report scripts from the `reports` folder  
4. Create the dashboard view from the `views` folder  
5. Connect Power BI to the SQL view for visualization  

---

## Key Learning Outcomes
- Designed a treasury-style relational data model  
- Built production-grade SQL MIS queries  
- Applied as-of-date valuation logic  
- Used window functions for performance analysis  
- Created governed SQL views for BI tools  

---

## Author
This project was built as a portfolio demonstration of SQL, financial analytics, and MIS reporting skills aligned with Treasury Analyst, Financial MIS, and Data Analyst roles.
