-- Task 6: Triggers and Constraints
USE management;  -- Replace with your actual database name

-- 🧩 1. Adding Constraints to Ensure Data Integrity

-- Ensure Available_Copies cannot be negative
ALTER TABLE Book
ADD CONSTRAINT chk_available_copies CHECK (Available_Copies >= 0);

-- Ensure Fine is never negative
ALTER TABLE Borrow
ADD CONSTRAINT chk_fine CHECK (Fine >= 0);

-- Ensure unique email for Members and Librarians
ALTER TABLE Member ADD CONSTRAINT unique_member_email UNIQUE (Email);
ALTER TABLE Librarian ADD CONSTRAINT unique_librarian_email UNIQUE (Email);


-- 🧩 2. Creating a Log Table to Track Events
CREATE TABLE Logs (
    Log_ID INT PRIMARY KEY AUTO_INCREMENT,
    Action VARCHAR(255),
    Action_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 🧩 3. Trigger: Log when a new member is added
DELIMITER //
CREATE TRIGGER after_member_insert
AFTER INSERT ON Member
FOR EACH ROW
BEGIN
    INSERT INTO Logs (Action)
    VALUES (CONCAT('New member added: ', NEW.Name));
END //
DELIMITER ;

-- 🧩 4. Trigger: Log when a book is borrowed
DELIMITER //
CREATE TRIGGER after_borrow_insert
AFTER INSERT ON Borrow
FOR EACH ROW
BEGIN
    INSERT INTO Logs (Action)
    VALUES (CONCAT('Book ID ', NEW.Book_ID, ' issued to Member ID ', NEW.Member_ID));
END //
DELIMITER ;

-- 🧩 5. Trigger: Automatically decrease available copies after borrowing
DELIMITER //
CREATE TRIGGER decrease_book_stock
AFTER INSERT ON Borrow
FOR EACH ROW
BEGIN
    UPDATE Book
    SET Available_Copies = Available_Copies - 1
    WHERE Book_ID = NEW.Book_ID;
END //
DELIMITER ;

-- 🧩 6. Trigger: Automatically increase available copies after return
DELIMITER //
CREATE TRIGGER increase_book_stock
AFTER UPDATE ON Borrow
FOR EACH ROW
BEGIN
    IF NEW.Return_Date IS NOT NULL THEN
        UPDATE Book
        SET Available_Copies = Available_Copies + 1
        WHERE Book_ID = NEW.Book_ID;
    END IF;
END //
DELIMITER ;

-- 🧩 7. View Logs
SELECT * FROM Logs;
