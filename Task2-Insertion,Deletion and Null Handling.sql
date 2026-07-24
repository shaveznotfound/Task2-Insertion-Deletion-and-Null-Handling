use practice;
CREATE TABLE Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) UNIQUE NULL,
    Email VARCHAR(100) UNIQUE NULL,
    MembershipDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    Status VARCHAR(20) NOT NULL DEFAULT 'Active'
);

CREATE TABLE Authors (
    AuthorID INT AUTO_INCREMENT PRIMARY KEY,
    AuthorName VARCHAR(100) NOT NULL UNIQUE,
    Country VARCHAR(50),
    BirthYear INT
);

CREATE TABLE Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(150) NOT NULL,
    AuthorID INT NOT NULL,
    ISBN VARCHAR(20) NOT NULL UNIQUE,
    Category VARCHAR(50) NOT NULL,
    PublishedYear INT,
    CopiesAvailable INT NOT NULL DEFAULT 1,
    Description VARCHAR(255) NULL,
    FOREIGN KEY (AuthorID) REFERENCES Authors(AuthorID) 
);

CREATE TABLE BookIssues (
    IssueID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    IssueDate DATE NOT NULL DEFAULT (CURRENT_DATE),
    DueDate DATE NOT NULL,
    ReturnDate DATE NULL,
    Fine DECIMAL(8,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID) ON DELETE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
);

-- Insert Statements
INSERT INTO Authors (AuthorName,Country,BirthYear) VALUES
('J.K. Rowling','United Kingdom',1965),
('George Orwell','United Kingdom',1903),
('Chetan Bhagat','India',1974),
('R.K. Narayan','India',1906),
('Paulo Coelho','Brazil',1947),
('Dan Brown','United States',1964),
('Jane Austen','United Kingdom',1775),
('Yuval Noah Harari','Israel',1976);

INSERT INTO Members(FullName,Phone,Email,MembershipDate,Status) VALUES
('Aarav Sharma','9876543210','aarav@gmail.com','2025-01-10','Active'),
('Priya Singh',NULL,'priya@gmail.com','2025-02-12','Active'),
('Rahul Verma','9876543211',NULL,'2025-03-01','Inactive'),
('Neha Gupta','9876543212','neha@gmail.com','2025-03-05','Active'),
('Rohan Mehta',NULL,NULL,'2025-03-20','Active'),
('Sneha Kapoor','9876543213','sneha@gmail.com','2025-04-01','Active'),
('Aditya Jain','9876543214','aditya@gmail.com','2025-04-15','Active'),
('Simran Kaur','9876543215',NULL,'2025-05-01','Inactive'),
('Karan Malhotra','9876543216','karan@gmail.com','2025-05-10','Active'),
('Ananya Das',NULL,'ananya@gmail.com','2025-05-15','Active');

INSERT INTO Books(Title,AuthorID,ISBN,Category,PublishedYear,CopiesAvailable,Description) VALUES
('Harry Potter',1,'ISBN001','Fantasy',1997,5,'Wizard story'),
('1984',2,'ISBN002','Dystopian',1949,3,'Classic novel'),
('Animal Farm',2,'ISBN003','Political',1945,2,NULL),
('Five Point Someone',3,'ISBN004','Fiction',2004,4,'College life'),
('Malgudi Days',4,'ISBN005','Classic',1943,2,NULL),
('The Alchemist',5,'ISBN006','Fiction',1988,6,'Inspirational'),
('Inferno',6,'ISBN007','Thriller',2013,3,'Mystery'),
('Pride and Prejudice',7,'ISBN008','Romance',1813,2,NULL),
('Sapiens',8,'ISBN009','History',2011,5,'Human evolution'),
('Digital Fortress',6,'ISBN010','Thriller',1998,3,NULL),
('Brida',5,'ISBN011','Fiction',1990,2,NULL),
('Emma',7,'ISBN012','Classic',1815,2,NULL),
('The Guide',4,'ISBN013','Classic',1958,1,NULL),
('Revolution 2020',3,'ISBN014','Fiction',2011,4,NULL),
('Homo Deus',8,'ISBN015','History',2015,5,'Future of mankind');

INSERT INTO BookIssues(MemberID,BookID,IssueDate,DueDate,ReturnDate,Fine) VALUES
(1,1,'2025-06-01','2025-06-15','2025-06-14',0),
(2,2,'2025-06-02','2025-06-16',NULL,0),
(3,3,'2025-06-03','2025-06-17','2025-06-20',50),
(4,4,'2025-06-04','2025-06-18',NULL,0),
(5,5,'2025-06-05','2025-06-19','2025-06-18',0),
(6,6,'2025-06-06','2025-06-20',NULL,0),
(7,7,'2025-06-07','2025-06-21','2025-06-22',20),
(8,8,'2025-06-08','2025-06-22',NULL,0),
(9,9,'2025-06-09','2025-06-23','2025-06-23',0),
(10,10,'2025-06-10','2025-06-24',NULL,0),
(1,11,'2025-06-11','2025-06-25',NULL,0),
(2,12,'2025-06-12','2025-06-26','2025-06-27',10);


SELECT * FROM Authors;
SELECT * FROM Members;
SELECT * FROM Books;
SELECT * FROM BookIssues;

-- Update Statements
UPDATE Members SET Phone='9999999999' WHERE MemberID=2;
SELECT * FROM Members;
UPDATE Members SET Email='unknown@example.com' WHERE Email IS NULL AND MemberID=3;
SELECT * FROM Members;
UPDATE Books SET CopiesAvailable=CopiesAvailable+1 WHERE Category='History';
SELECT * FROM Books;
UPDATE Members SET Status='Active' WHERE Status='Inactive' ;
SELECT * FROM Members;

-- Null Statements
SELECT * FROM Members WHERE Phone IS NULL;
UPDATE Members Set Phone='9871073168' WHERE MemberID=5;
UPDATE Members Set Phone='9871072315' WHERE MemberID=10;
SELECT * FROM Members;

-- -- Not Null Statement
SELECT * FROM Members WHERE Email IS NOT NULL;

-- -- Delete Statements
DELETE FROM BookIssues WHERE Fine=0 AND ReturnDate IS NOT NULL;
SELECT * FROM BookIssues;

DELETE FROM Members WHERE FullName='Simran Kaur';
SELECT * FROM Members;