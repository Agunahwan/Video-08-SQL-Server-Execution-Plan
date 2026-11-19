/*
  Video #08 - Measure query work
  Enable Include Actual Execution Plan (Ctrl+M).
  Read output in the Messages tab.
*/
SET STATISTICS IO ON;
SET STATISTICS TIME ON;
GO

SELECT
    TaskID,
    Title,
    Status
FROM dbo.Tasks
WHERE Status = 'Pending';
GO

SELECT
    TaskID,
    Title,
    Status
FROM dbo.Tasks
WHERE Status = 'Done';
GO

SET STATISTICS TIME OFF;
SET STATISTICS IO OFF;
GO
