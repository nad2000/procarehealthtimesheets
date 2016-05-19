CREATE FUNCTION dbo.to_nz_datetime( @LocalDateTime DATETIME )
RETURNS DATETIME
AS
BEGIN 
  RETURN DATEADD( HOUR, DATEDIFF( HOUR, GETDATE(), GETUTCDATE() )+12, @LocalDateTime )
END 
GO

-- CREATE FUNCTION to_nz_date( @LocalDate DATE ) RETURNS DATE AS BEGIN RETURN NULL END
ALTER FUNCTION dbo.to_nz_date( @LocalDate DATE )
RETURNS DATE
AS
BEGIN
  RETURN CAST( dbo.to_nz_datetime( @LocalDate) AS DATE)
END 

GO
-- TEST: SELECT dbo.to_nz_date('11/1/2010')
-- TEST: SELECT dbo.to_nz_datetime('11/1/2010 23:00')