-- Task 8: Backup, Restore and Security
USE management;  -- Replace with your actual database name

-- 🧩 1. Creating a New User with Limited Access
CREATE USER 'readonly_user'@'localhost' IDENTIFIED BY 'readonly123';

-- Grant read-only access to this user
GRANT SELECT ON library_db.* TO 'readonly_user'@'localhost';

-- Verify privileges
SHOW GRANTS FOR 'readonly_user'@'localhost';


-- 🧩 2. Creating a New User with Full Access
CREATE USER 'librarian_user'@'localhost' IDENTIFIED BY 'librarian123';
GRANT ALL PRIVILEGES ON library_db.* TO 'librarian_user'@'localhost';
FLUSH PRIVILEGES;

-- 🧩 3. Revoking Privileges (Example)
REVOKE DELETE ON library_db.* FROM 'librarian_user'@'localhost';
SHOW GRANTS FOR 'librarian_user'@'localhost';


-- 🧩 4. Viewing All Existing Users
SELECT user, host FROM mysql.user;

-- 🧩 5. Backup Command (to be run in Command Prompt / Terminal)
-- Note: Run this outside MySQL, not inside the console
-- Replace 'root' and 'library_db' with your actual username and database name

-- Backup command (export database to .sql file)
-- mysqldump -u root -p library_db > backup_library_db.sql

-- 🧩 6. Restore Command (to import backup)
-- mysql -u root -p library_db < backup_library_db.sql


-- 🧩 7. Create a Security Log Table (Optional)
CREATE TABLE Security_Logs (
    Log_ID INT PRIMARY KEY AUTO_INCREMENT,
    Action VARCHAR(255),
    User_Name VARCHAR(100),
    Log_Time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert example log (manual test)
INSERT INTO Security_Logs (Action, User_Name)
VALUES ('Backup executed successfully', 'admin');
