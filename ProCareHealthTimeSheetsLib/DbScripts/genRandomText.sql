--DECLARE @maxlength INT = 254, @minlength INT = 50
DECLARE @randWords TABLE ( Word VARCHAR(2000) )
DECLARE @randSentences TABLE ( Sentence VARCHAR(2000) )


INSERT INTO @randWords
SELECT
(
  select top (abs(checksum(newid())) % 7 + 6)
   char(abs(checksum(newid())) % 26 + ascii('a'))
  from sys.all_objects a1
  where sign(a1.object_id) = sign(t.object_id) /* Meaningless thing to force correlation */
  for xml path('')
) as RandomWords
-- ,*
FROM sys.all_objects t;

INSERT INTO @randSentences
SELECT
(
  select top (abs(checksum(newid())) % 7 + 3)
   Word+' '
  from @randWords
  where LEN(Word) % 3-1 = sign(t.object_id) /* Meaningless thing to force correlation */
  order by NEWID()
  for xml path('')
) as RandomSentence
-- ,*
FROM sys.all_objects t;

UPDATE tse
SET tse.Comment = rs.Sentence
FROM dbo.TimeSheetEntries AS tse JOIN @randSentences AS rs
  ON CHECKSUM( rs.Sentence ) % (SELECT MAX(Id) FROM dbo.TimeSheetEntries) = tse.Id
WHERE tse.Comment IS NULL
