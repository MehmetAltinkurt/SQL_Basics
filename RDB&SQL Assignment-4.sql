  
  --f4526-Mehmet
  
  --Create a scalar-valued function that returns the factorial of a number you gave it.



CREATE OR ALTER FUNCTION fn_factorial(@NUM INT) 
RETURNS INT
AS
BEGIN
	DECLARE @RESULT INT
	SET @RESULT = 1
	
	WHILE @NUM>0
	BEGIN
		SET @RESULT = @RESULT*@NUM
		SET @NUM = @NUM-1
	END
	RETURN @RESULT

END
GO

SELECT dbo.fn_factorial(6) AS factorial

