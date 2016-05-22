-- TODO: Change DB Name accordingly:
USE TimeSheetDB
GO

/*
  SQL Server 2005 does not provide specific functions for Base64 encoding / decoding,
  but you can create them easily enough by leveraging the XML functionality.
*/

DROP FUNCTION [dbo].[base64_encode]
GO
CREATE FUNCTION [dbo].[base64_encode] (@data VARBINARY(max)) RETURNS VARCHAR(max)
WITH SCHEMABINDING, RETURNS NULL ON NULL INPUT
BEGIN
RETURN (
  SELECT [text()] = @data
  FOR XML PATH('')
)
END
GO


/*
SQL Server 2005 does not provide specific functions for Base64 encoding / decoding,
but you can create them easily enough by leveraging the XML functionality.
*/
DROP FUNCTION [dbo].[base64_decode]
GO
CREATE FUNCTION [dbo].[base64_decode] (@base64_text VARCHAR(max)) RETURNS VARBINARY(max)
WITH SCHEMABINDING, RETURNS NULL ON NULL INPUT
BEGIN
  DECLARE @x XML; SET @x = @base64_text
  RETURN @x.value('(/)[1]', 'VARBINARY(max)')
END
GO