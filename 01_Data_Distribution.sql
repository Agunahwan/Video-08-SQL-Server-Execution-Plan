/*
  Video #08 - Check data distribution
*/
SELECT
    Status,
    COUNT(*) AS TotalRows
FROM dbo.Tasks
GROUP BY Status
ORDER BY TotalRows DESC;
GO

-- Optional: verify total row count.
SELECT COUNT(*) AS TotalTasks
FROM dbo.Tasks;
GO
