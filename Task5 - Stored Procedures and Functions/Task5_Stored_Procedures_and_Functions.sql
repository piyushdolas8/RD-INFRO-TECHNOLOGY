-- Task 5: Stored Procedures and Functions
USE management;  -- Replace with your actual database name

-- 🧩 1. Stored Procedure: Get all borrowed books with member details
DELIMITER //
CREATE PROCEDURE GetBorrowedBooks()
BEGIN
    SELECT 
        b.Borrow_ID,
        bk.Title AS Book_Title,
        m.Name AS Member_Name,
        b.Issue_Date,
        b.Due_Date,
        b.Return_Date,
        b.Fine
    FROM Borrow b
    JOIN Book bk ON b.Book_ID = bk.Book_ID
    JOIN Member m ON b.Member_ID = m.Member_ID;
END //
DELIMITER ;

-- Call the procedure
CALL GetBorrowedBooks();


-- 🧩 2. Stored Procedure: Add a new member
DELIMITER //
CREATE PROCEDURE AddMember(
    IN p_name VARCHAR(100),
    IN p_email VARCHAR(100),
    IN p_phone VARCHAR(20),
    IN p_address VARCHAR(255),
    IN p_joindate DATE
)
BEGIN
    INSERT INTO Member (Name, Email, Phone, Address, Join_Date)
    VALUES (p_name, p_email, p_phone, p_address, p_joindate);
END //
DELIMITER ;

-- Call example:
CALL AddMember('Rahul Sharma', 'rahul@gmail.com', '9123456789', 'Delhi', '2024-11-01');


-- 🧩 3. Function: Calculate fine for late returns
DELIMITER //
CREATE FUNCTION CalculateFine(
    due DATE,
    returned DATE
)
RETURNS DECIMAL(8,2)
DETERMINISTIC
BEGIN
    DECLARE fine DECIMAL(8,2);
    IF returned > due THEN
        SET fine = DATEDIFF(returned, due) * 10; -- ₹10 per day
    ELSE
        SET fine = 0;
    END IF;
    RETURN fine;
END //
DELIMITER ;

-- Test the function
SELECT Borrow_ID, 
       Member_ID, 
       CalculateFine(Due_Date, Return_Date) AS Fine_Calculated
FROM Borrow;


-- 🧩 4. Stored Procedure: Update fine in Borrow table automatically
DELIMITER //
CREATE PROCEDURE UpdateFines()
BEGIN
    UPDATE Borrow
    SET Fine = CalculateFine(Due_Date, Return_Date);
END //
DELIMITER ;

-- Call the procedure
CALL UpdateFines();
