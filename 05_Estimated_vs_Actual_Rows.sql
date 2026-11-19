/*
  Video #08 - Compare Estimated Rows and Actual Rows
  Enable Include Actual Execution Plan (Ctrl+M).
  Select relevant operators and inspect Properties.
*/

-- Pending
SELECT
    TaskID,
    Title,
    Status
FROM dbo.Tasks
WHERE Status = 'Pending';
GO

-- Done
SELECT
    TaskID,
    Title,
    Status
FROM dbo.Tasks
WHERE Status = 'Done';
GO

/*
  Inspect these properties where available:
  - Estimated Number of Rows
  - Actual Number of Rows / Actual Number of Rows for All Executions
  - Actual Number of Rows Read
  - Number of Executions

  Property labels/availability vary by SQL Server/SSMS version
  and by the selected operator.
*/
