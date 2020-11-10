USE [WeatherDB]
GO

SET NOCOUNT ON

MERGE INTO [dbo].[Summary] AS [Target]
USING (VALUES
  (1, 'Freezing'), 
  (2, 'Bracing'), 
  (3, 'Chilly'), 
  (4, 'Cool'), 
  (5, 'Mild'), 
  (6, 'Warm'), 
  (7, 'Balmy'),
  (8, 'Hot'),
  (9, 'Sweltering'),
  (10, 'Scorching')
) AS [Source] ([Id],[Summary])
ON ([Target].[Id] = [Source].[Id])
WHEN MATCHED AND (
	NULLIF([Source].[Summary], [Target].[Summary]) IS NOT NULL OR NULLIF([Target].[Summary], [Source].[Summary]) IS NOT NULL) THEN
 UPDATE SET
  [Summary] = [Source].[Summary]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Summary])
 VALUES([Source].[Id],[Source].[Summary])
WHEN NOT MATCHED BY SOURCE THEN 
 DELETE
;
GO

DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [dbo].[Summary]. Rows affected: ' + CAST(@mergeCount AS VARCHAR(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[dbo].[Summary] rows affected by MERGE: ' + CAST(@mergeCount AS VARCHAR(100));
 END
GO

SET NOCOUNT OFF
GO