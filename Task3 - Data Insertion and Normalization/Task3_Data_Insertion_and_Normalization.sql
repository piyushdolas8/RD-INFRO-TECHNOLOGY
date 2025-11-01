-- Task 3: Data Insertion and Normalization
USE management;  
-- Publisher Data
INSERT INTO Publisher (Name, Contact) VALUES
('Penguin Books', 'penguin@gmail.com'),
('HarperCollins', 'harpercollins@gmail.com'),
('Oxford Press', 'oxford@gmail.com');

-- Category Data
INSERT INTO Category (Category_Name) VALUES
('Fiction'), ('Science'), ('Technology'), ('History');

-- Librarian Data
INSERT INTO Librarian (Name, Email, Phone) VALUES
('Amit Sharma', 'amit@library.com', '9876543210'),
('Priya Verma', 'priya@library.com', '8765432109');

-- Member Data
INSERT INTO Member (Name, Email, Phone, Address, Join_Date) VALUES
('Rohan Mehta', 'rohan@gmail.com', '9998887776', 'Pune', '2024-05-15'),
('Sneha Patil', 'sneha@gmail.com', '8889997776', 'Mumbai', '2024-07-20'),
('Ananya Joshi', 'ananya@gmail.com', '7776665554', 'Nagpur', '2024-08-10');

-- Book Data
INSERT INTO Book (Title, Author, Publisher_ID, ISBN, Total_Copies, Available_Copies) VALUES
('The Time Machine', 'H.G. Wells', 1, 'ISBN001', 5, 5),
('Atomic Habits', 'James Clear', 2, 'ISBN002', 8, 8),
('Python Programming', 'John Zelle', 3, 'ISBN003', 6, 6),
('World History', 'J. Warner', 3, 'ISBN004', 4, 4);

-- Book_Category Data
INSERT INTO Book_Category (Book_ID, Category_ID) VALUES
(1, 1),
(2, 1),
(3, 3),
(4, 4);

-- Borrow Data
INSERT INTO Borrow (Book_ID, Member_ID, Librarian_ID, Issue_Date, Due_Date, Return_Date, Fine) VALUES
(1, 1, 1, '2024-10-01', '2024-10-15', '2024-10-12', 0.00),
(2, 2, 1, '2024-10-10', '2024-10-25', NULL, 0.00),
(3, 3, 2, '2024-09-15', '2024-09-30', '2024-10-02', 50.00);
