# Task2-Insertion-Deletion-and-Null-Handling
A practical SQL exercise demonstrating how to design a relational schema and correctly **insert, update, delete, and handle NULL values** using a realistic library management system.

Check For- [Code](https://www.db-fiddle.com/f/uMZUrVdYg1sQXZkaWdoneY/0#&togetherjs=dw9fzlG0Hu/)

## 📋 Table Overview

The schema models a real library where some fields are optional by nature — not every member has a phone number on file, not every book has a description, and not every issued book has been returned yet.

```sql
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
```

| Table        | Nullable Columns                | Why                                                        |
| ------------ | -------------------------------- | ----------------------------------------------------------- |
| `Members`    | `Phone`, `Email`                | Not every member provides contact details               |
| `Authors`    | `Country`, `BirthYear`          | Historical or incomplete author data                     |
| `Books`      | `PublishedYear`, `Description`  | Not always known or provided at entry time                |
| `BookIssues` | `ReturnDate`                    | `NULL` until the member returns the book                  |

## 🛠️ What This Project Covers

1. Inserting records — both complete rows and rows with Null Values
2. Handling NULL values correctly while querying
3. Updating records, including resolving NULLs into meaningful values
4. Deleting records safely using condition-based filtering

## 1️⃣ INSERT — Creating Records

```sql
INSERT INTO Authors (AuthorName, Country, BirthYear) VALUES
('J.K. Rowling', 'United Kingdom', 1965),
('George Orwell', 'United Kingdom', 1903);

INSERT INTO Members (FullName, Phone, Email, MembershipDate, Status) VALUES
('Aarav Sharma', '9876543210', 'aarav@gmail.com', '2025-01-10', 'Active'),
('Priya Singh', NULL, 'priya@gmail.com', '2025-02-12', 'Active');
```

**Key takeaway:** any optional column left as `NULL` in an `INSERT` represents data that genuinely isn't available yet — this is how most real-world NULLs are created.

## 2️⃣ Handling NULL Values

NULL means **"unknown / not applicable"**, not zero or an empty string, and it behaves differently from every other value in SQL.

### ❌ The common mistake

```sql
SELECT * FROM Members WHERE Phone = NULL; 
```

NULL can never equal anything — not a value, not even another NULL.

### ✅ Correct way to check for NULL

```sql
SELECT * FROM Members WHERE Phone IS NULL;
SELECT * FROM Members WHERE Email IS NOT NULL;
```

### 📌 Quick Reference

| Task                  | ❌ Wrong        | ✅ Right           |
| --------------------- | -------------- | ------------------ |
| Find NULLs            | `col = NULL`   | `col IS NULL`       |
| Exclude NULLs         | `col != NULL`  | `col IS NOT NULL`   |
| Filter on multiple conditions with NULL | ignoring it | combine `IS NULL`/`IS NOT NULL` with `AND`/`OR` |

## 3️⃣ UPDATE — Modifying Records & Resolving NULLs

`UPDATE` is used for general data manipulation — changing a single field, updating based on a condition, or resolving a `NULL` into an actual value once it's known.

```sql
UPDATE Members SET Phone = '9871073168' WHERE MemberID = 5;
UPDATE Members SET Email = 'unknown@example.com' WHERE Email IS NULL AND MemberID = 3;
```

## 4️⃣ DELETE — Removing Records

`DELETE` removes records that match a specified condition, including conditions that check for `NULL` or non-`NULL` values.

```sql
DELETE FROM BookIssues WHERE Fine = 0 AND ReturnDate IS NOT NULL;
```

## ✅ Summary

| Concept                              | Demonstrated By          |
| ------------------------------------- | ------------------------- |
| Inserting data (with optional NULLs) | Section 1                |
| Detecting NULLs correctly             | `IS NULL` / `IS NOT NULL` |
| Updating records / resolving NULLs    | Section 3                 |
| Deleting records with conditions      | Section 4                 |
