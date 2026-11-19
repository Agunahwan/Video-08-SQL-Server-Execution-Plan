/*
  Video #08 - Actual Execution Plan queries
  Enable Include Actual Execution Plan (Ctrl+M) in SSMS.
*/

-- Selective value: Pending
SELECT
    TaskID,
    Title,
    Status
FROM dbo.Tasks
WHERE Status = 'Pending';
GO

-- Common value: Done
SELECT
    TaskID,
    Title,
    Status
FROM dbo.Tasks
WHERE Status = 'Done';
GO
