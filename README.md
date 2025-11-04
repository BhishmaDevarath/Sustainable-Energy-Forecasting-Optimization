# ⚡ Sustainable Energy Production & Demand Forecasting

- A full-scale, end-to-end data analytics and optimization framework for sustainable energy systems — combining **machine learning forecasting**, **renewable production modeling**, and **battery dispatch optimization**.

---

## 🌍 Project Overview

This project simulates a real-world power system where renewable and non-renewable energy sources interact under varying demand and weather conditions.  
It covers **data engineering, time-series forecasting, optimization modeling, scenario simulation, and Power BI visualization** — all built from scratch using Python and SQL Server.

The goal:  
- To enable **data-driven energy management** by predicting demand, optimizing resource utilization, and improving sustainability metrics.

---

## 🔧 Tech Stack

| Category | Tools & Technologies |
|-----------|----------------------|
| **Languages** | Python 3.10+, SQL (MS SQL Server) |
| **Libraries** | Pandas, NumPy, Scikit-learn, Matplotlib, PuLP |
| **Data Visualization** | Power BI, Matplotlib |
| **Database** | Microsoft SQL Server (local instance) |
| **Version Control** | Git & GitHub |
| **Simulation Techniques** | Monte Carlo Analysis, Linear Programming |

---

## 🧩 Dashboard Preview

### 1. Executive Overview
![Executive Overview](./Power%20BI%20Dashboards/Executive%20Overview.jpeg)

### 2. Regional Operations
![Regional Operations](./Power%20BI%20Dashboards/Regional%20Operations.jpeg)

### 3. Forecast & Risk
![Forecast & Risk](./Power%20BI%20Dashboards/Forecast%20&%20Risk.jpeg)

---

## 🧠 Key Components

### 1️⃣ Data Engineering
- Generated **synthetic energy, weather, and financial datasets** with realistic variability.
- Performed SQL-based joins and aggregations to build a unified analytical model.
- Designed dimension and fact tables for efficient querying.

### 2️⃣ Predictive Analytics
- Developed regional **energy demand forecasting models** using:
  - Linear Regression (baseline)
  - Random Forest Regressor
  - Gradient Boosting Regressor  
- Achieved an average **R² score > 0.85** on out-of-sample forecasts.
- Evaluated via RMSE, MAE, and precision-recall metrics.

### 3️⃣ Optimization & Simulation
- Built an **LP-based battery dispatch optimizer** (using PuLP).
- Modeled SOC (State of Charge), charge/discharge efficiency, and import cost.
- Conducted **Monte Carlo simulations (n=200)** to assess operational risk and uncertainty.

### 4️⃣ Visualization & BI
- Designed **interactive Power BI dashboards**:
  - Real-time energy mix and consumption trends
  - Forecast accuracy and error heatmaps
  - Battery dispatch and scenario analysis
- Integrated SQL + Power BI models for refreshable reporting.

---

## 📈 Key Insights

| Insight | Metric |
|----------|--------|
| Forecast Accuracy | R² = 0.85+ across all regions |
| Renewable Contribution | 58–72% of total energy production |
| Optimization Benefit | 30% reduction in grid import via smart battery dispatch |
| Resilience | Maintained stability under ±15% demand fluctuations |

---

## 📌 Author
👤 **Aman Kumar Singh**  
📧 amankrsingh1831@gmail.com  
🔗 www.linkedin.com/in/aman-kumar-singh-3a3305387  

---

## 📄 License
MIT License  
Feel free to fork and adapt for educational or professional use.
