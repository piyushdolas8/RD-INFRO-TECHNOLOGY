-- Task 7: Performance Optimization
USE management;  -- Replace with your database name

-- 🧩 1. Check performance of a normal query before optimization
EXPLAIN
SELECT m.Name, bk.Title
FROM Member m
JOIN Borrow b ON m.Member_ID = b.Member_ID
JOIN Book bk ON b.Book_ID = bk.Book_ID
WHERE bk.Title LIKE '%Python%';

-- 🧩 2. Create indexes on frequently searched columns
CREATE INDEX idx_book_title ON Book(Title);
CREATE INDEX idx_member_name ON Member(Name);
CREATE INDEX idx_borrow_memberid ON Borrow(Member_ID);
CREATE INDEX idx_borrow_bookid ON Borrow(Book_ID);

-- 🧩 3. Re-run EXPLAIN to check improvement
EXPLAIN
SELECT m.Name, bk.Title
FROM Member m
JOIN Borrow b ON m.Member_ID = b.Member_ID
JOIN Book bk ON b.Book_ID = bk.Book_ID
WHERE bk.Title LIKE '%Python%';

-- 🧩 4. Use ORDER BY and LIMIT for optimized queries
SELECT Title, Author
FROM Book
ORDER BY Available_Copies DESC
LIMIT 5;

-- 🧩 5. Optimize GROUP BY query with index usage
EXPLAIN
SELECT m.Name, COUNT(b.Borrow_ID) AS Total_Books
FROM Member m
JOIN Borrow b ON m.Member_ID = b.Member_ID
GROUP BY m.Name;

-- 🧩 6. View all indexes in the database
SHOW INDEXES FROM Book;
SHOW INDEXES FROM Borrow;
