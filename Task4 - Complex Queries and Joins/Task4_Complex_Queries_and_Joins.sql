-- Task 4: Complex Queries & Joins
USE management;  

-- 1️⃣ INNER JOIN - List of all borrowed books with member and librarian details
SELECT 
    b.Borrow_ID,
    bk.Title AS Book_Title,
    m.Name AS Member_Name,
    l.Name AS Librarian_Name,
    b.Issue_Date,
    b.Due_Date,
    b.Return_Date
FROM Borrow b
INNER JOIN Book bk ON b.Book_ID = bk.Book_ID
INNER JOIN Member m ON b.Member_ID = m.Member_ID
INNER JOIN Librarian l ON b.Librarian_ID = l.Librarian_ID;

-- 2️⃣ LEFT JOIN - List all members and their borrowed books (including those who didn’t borrow yet)
SELECT 
    m.Member_ID,
    m.Name AS Member_Name,
    bk.Title AS Borrowed_Book
FROM Member m
LEFT JOIN Borrow b ON m.Member_ID = b.Member_ID
LEFT JOIN Book bk ON b.Book_ID = bk.Book_ID
ORDER BY m.Member_ID;

-- 3️⃣ GROUP BY - Count how many books each member borrowed
SELECT 
    m.Name AS Member_Name,
    COUNT(b.Borrow_ID) AS Total_Books_Borrowed
FROM Member m
LEFT JOIN Borrow b ON m.Member_ID = b.Member_ID
GROUP BY m.Name
ORDER BY Total_Books_Borrowed DESC;

-- 4️⃣ HAVING - Show members who borrowed more than 1 book
SELECT 
    m.Name AS Member_Name,
    COUNT(b.Borrow_ID) AS Total_Books
FROM Member m
JOIN Borrow b ON m.Member_ID = b.Member_ID
GROUP BY m.Name
HAVING COUNT(b.Borrow_ID) > 1;

-- 5️⃣ ORDER BY - Show books sorted by available copies (descending)
SELECT 
    Book_ID,
    Title,
    Available_Copies
FROM Book
ORDER BY Available_Copies DESC;

-- 6️⃣ Nested Query (Subquery) - Members who borrowed a book from “Technology” category
SELECT DISTINCT m.Name AS Member_Name
FROM Member m
WHERE m.Member_ID IN (
    SELECT b.Member_ID
    FROM Borrow b
    JOIN Book_Category bc ON b.Book_ID = bc.Book_ID
    JOIN Category c ON bc.Category_ID = c.Category_ID
    WHERE c.Category_Name = 'Technology'
);
