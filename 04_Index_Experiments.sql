/*
  Video #08 - Index experiments

  IMPORTANT:
  - Lab/testing database only.
  - Run baseline before creating demo indexes.
  - DROP below targets only named demo indexes.
  - Verify ownership/purpose before dropping any index.
  - Enable Actual Execution Plan (Ctrl+M).
*/

------------------------------------------------------------
-- A. BASELINE: run before creating demo indexes
------------------------------------------------------------
SELECT
    TaskID,
    Title,
    Status
FROM dbo.Tasks
WHERE Status = 'Pending';
GO

------------------------------------------------------------
-- B. NONCLUSTERED INDEX ON Status
-- Run only if this demo index does not already exist.
------------------------------------------------------------
CREATE NONCLUSTERED INDEX IX_Tasks_Status
ON dbo.Tasks (Status);
GO

SELECT
    TaskID,
    Title,
    Status
FROM dbo.Tasks
WHERE Status = 'Pending';
GO

------------------------------------------------------------
-- C. COVERING INDEX: Status + INCLUDE (Title)
------------------------------------------------------------
-- Remove the experiment-B index, if it exists.
-- Do not run if this index belongs to an application workload.
IF EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_Tasks_Status'
      AND object_id = OBJECT_ID(N'dbo.Tasks')
)
BEGIN
    DROP INDEX IX_Tasks_Status ON dbo.Tasks;
END;
GO

-- Run only if this demo index does not already exist.
CREATE NONCLUSTERED INDEX IX_Tasks_Status_Title
ON dbo.Tasks (Status)
INCLUDE (Title);
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

------------------------------------------------------------
-- OPTIONAL CLEANUP
-- Uncomment only when finished and after verifying that
-- this index was created specifically for this exercise.
------------------------------------------------------------
/*
IF EXISTS
(
    SELECT 1
    FROM sys.indexes
    WHERE name = N'IX_Tasks_Status_Title'
      AND object_id = OBJECT_ID(N'dbo.Tasks')
)
BEGIN
    DROP INDEX IX_Tasks_Status_Title ON dbo.Tasks;
END;
GO
*/
