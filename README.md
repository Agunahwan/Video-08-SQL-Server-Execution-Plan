# Video #08 — SQL Server Execution Plan Deep Dive

A collection of SQL scripts for the **AA Programming Video #08** hands-on session.

This repository contains sample queries and experiments to help you understand how Microsoft SQL Server chooses execution strategies and how to analyze query performance using the Actual Execution Plan, `STATISTICS IO`, and `STATISTICS TIME`.

## 📌 Video Topics

- Estimated Execution Plan and Actual Execution Plan
- Index Seek, Index Scan, Clustered Index Scan, and Table Scan
- Key Lookup
- Nested Loops and Hash Match
- Sort and Filter
- Estimated Rows vs. Actual Rows
- Actual Number of Rows Read
- Logical Reads, CPU Time, and Elapsed Time
- Nonclustered Index and Covering Index

## 📂 Repository Structure

```text
Video-08-SQL-Server-Execution-Plan/
├── README.md
├── 01_Data_Distribution.sql
├── 02_Execution_Plan_Queries.sql
├── 03_Statistics_IO_TIME.sql
├── 04_Index_Experiments.sql
└── 05_Estimated_vs_Actual_Rows.sql
```

## 🛠️ Requirements

- Microsoft SQL Server
- SQL Server Management Studio (SSMS)
- A practice database that already contains the `dbo.Tasks` table
- The `TaskID`, `Title`, and `Status` columns
- `TaskID` configured as the Clustered Primary Key, matching the demo database structure used in the video

> These scripts use the `dbo.Tasks` table from the practice database used in the video. They do not create a database, table, or sample data.

## 🚀 How to Use

1. Open your practice database in SQL Server Management Studio.
2. Make sure the `dbo.Tasks` table exists and contains the required columns.
3. Enable **Include Actual Execution Plan** by pressing `Ctrl + M`.
4. Run the scripts in the following order:

| File | Description |
|---|---|
| `01_Data_Distribution.sql` | Checks the row count for each Status value |
| `02_Execution_Plan_Queries.sql` | Runs queries using the `Pending` and `Done` Status values |
| `03_Statistics_IO_TIME.sql` | Measures Logical Reads, CPU Time, and Elapsed Time |
| `04_Index_Experiments.sql` | Compares the baseline, Nonclustered Index, and Covering Index |
| `05_Estimated_vs_Actual_Rows.sql` | Checks estimated and actual row counts for operators |

## 📊 Sample Data Distribution

The following data distribution was used when recording the video:

| Status | Total Rows | Percentage |
|---|---:|---:|
| Done | 195,000 | 65% |
| InProgress | 75,000 | 25% |
| Review | 29,100 | 9.7% |
| Pending | 900 | 0.3% |
| **Total** | **300,000** | **100%** |

Your database may contain a different number of rows. Run `01_Data_Distribution.sql` to check the actual distribution in your environment.

## 🔎 Index Experiments

The hands-on exercises in `04_Index_Experiments.sql` are performed in stages:

1. **Baseline** — run the query before creating any additional indexes.
2. **Nonclustered Index** — create an index on the `Status` column.
3. **Covering Index** — create an index on `Status` with `Title` as an included column.
4. **Common Status** — run the query using the `Done` value to observe the Query Optimizer's execution plan choice.

Example Covering Index:

```sql
CREATE NONCLUSTERED INDEX IX_Tasks_Status_Title
ON dbo.Tasks (Status)
INCLUDE (Title);
```

Because `TaskID` is the Clustered Key, the row locator in the Nonclustered Index also provides the Clustered Key value. As a result, a query selecting `TaskID`, `Title`, and `Status` may be satisfied by this index without a Key Lookup.

The execution operators are still chosen by the Query Optimizer based on statistics, data distribution, and estimated cost.

## 📈 Performance Metrics

Pay attention to the following metrics when analyzing the results:

- **Estimated Number of Rows** — the number of rows estimated by the Query Optimizer.
- **Actual Number of Rows** — the actual number of rows produced by an operator.
- **Actual Number of Rows Read** — the number of rows read by an operator.
- **Number of Executions** — how many times an operator was executed.
- **Logical Reads** — the number of pages read from the buffer cache.
- **CPU Time** — the amount of CPU time used.
- **Elapsed Time** — the total query execution duration.

Results may vary depending on the data, statistics, SQL Server version, configuration, and server workload.

## ⚠️ Important Notes

- Run index experiments only in a lab or testing database.
- Capture the baseline results before creating additional indexes.
- The `04_Index_Experiments.sql` script uses the demo index names `IX_Tasks_Status` and `IX_Tasks_Status_Title`. Before running any `DROP INDEX` statement, make sure the target index was created specifically for this experiment.
- Do not drop indexes used by an application or other workloads.
- Do not clear the buffer cache or plan cache on a production server for benchmarking purposes.
- Run tests multiple times under consistent conditions. Separate warm-up runs and record the actual results.
- An `Index Seek` does not always mean a query is faster than a Scan.
- Missing Index Recommendations are suggestions from the Query Optimizer, not instructions that must always be followed.

## ▶️ Related Video

**Video #07 — SQL Server Index Explained: How Clustered & Nonclustered Indexes Work**

Learn the fundamentals of SQL Server indexes before diving deeper into Execution Plans.

---

**AA PROGRAMMING**  
Real Code. Real Problems. Practical Solutions.
