CREATE FUNCTION dbo.GetValuesBetween(@StartInt INT, @EndInt INT)
RETURNS @ValuesTable TABLE (Value INT)
AS
BEGIN
    DECLARE @Counter INT = @StartInt;
    WHILE @Counter <= @EndInt
    BEGIN
        INSERT INTO @ValuesTable (Value)
        VALUES (@Counter);
        SET @Counter = @Counter + 1;
    END
    RETURN;
END;

SELECT * FROM dbo.GetValuesBetween(1, 10);

CREATE FUNCTION dbo.GetStudentDetails(@StudentNo INT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        CONCAT(s.FirstName, ' ', s.LastName) AS FullName, 
        d.DepartmentName
    FROM Students s
    JOIN Departments d ON s.DepartmentID = d.DepartmentID
    WHERE s.StudentID = @StudentNo
);
SELECT * FROM dbo.GetStudentDetails(101);

CREATE FUNCTION dbo.FormatManagerHiringDate(@Format INT)
RETURNS TABLE
AS
RETURN (
    SELECT 
        d.DepartmentName, 
        m.ManagerName, 
        CASE @Format
            WHEN 1 THEN FORMAT(m.HiringDate, 'MM/dd/yyyy')
            WHEN 2 THEN FORMAT(m.HiringDate, 'dd-MM-yyyy')
            WHEN 3 THEN FORMAT(m.HiringDate, 'yyyy-MM-dd')
            ELSE FORMAT(m.HiringDate, 'dd MMM yyyy')
        END AS FormattedDate
    FROM Managers m
    JOIN Departments d ON m.DepartmentID = d.DepartmentID
);

SELECT * FROM dbo.FormatManagerHiringDate(1);

