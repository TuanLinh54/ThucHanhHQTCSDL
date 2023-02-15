---Cau B:
create table Students(
    StudentID Nvarchar(12) primary key,
	StudentName Nvarchar(25) not null,
	DateofBirth Datetime NOT NULL,
	Email Nvarchar(40),
	Phone Nvarchar(12),
    Class Nvarchar(10)
)

create table Subjects(
    SubjectID Nvarchar(10) PRIMARY KEY,
    SubjectName Nvarchar(25) NOT NULL
)

create table Mark(
    StudentID Nvarchar(12) FOREIGN KEY (StudentID)REFERENCES Students (StudentID),
    SubjectID Nvarchar(10) FOREIGN KEY (SubjectID)REFERENCES Subjects (SubjectID),
    Date Datetime,
    Theory Tinyint,
    Practical Tinyint,
)

---Cau C:
INSERT INTO Students 
VALUES ('AV0807005', N'Mail Trung Hiếu', '11/10/1989', 'trunghieu@yahoo.com', '0904115116', 'AV1'),
('AV0807006', N'Nguyễn Quý Hùng', '2/12/1988', 'quyhung@yahoo.com', '0955667787', 'AV2'),
('AV0807007', N'Đỗ Đắc Huỳnh', '2/1/1990', 'dachuynh@yahoo.com', '0988574747', 'AV2'),
('AV0807009', N'An Đăng Khuê', '6/3/1986', 'dangkhue@yahoo.com', '0986757463', 'AV1'),
('AV0807010', N'Nguyễn T. Tuyết Lan', '12/7/1989', 'tuyetlan@gmail.com', '0983310342', 'AV2'),
('AV0807011', N'Đinh Phụng Long', '2/12/1990', 'phunglong@yahoo.com', NULL, 'AV1'),
('AV0807012', N'Nguyễn Tuấn Nam', '2/3/1990', 'tuannam@yahoo.com', NULL, 'AV1');

INSERT INTO Subjects 
VALUES ('S001', 'SQL'),
('S002', 'Java Simplefield'),
('S003', 'Active Server Page');

NSERT INTO Students 
VALUES ('AV0807005', 'Mail Trung Hiếu', '11/10/1989', 'trunghieu@yahoo.com', '0904115116', 'AV1'),
('AV0807006', 'Nguyễn Quý Hùng', '2/12/1988', 'quyhung@yahoo.com', '0955667787', 'AV2'),
('AV0807007', 'Đỗ Đắc Huỳnh', '2/1/1990', 'dachuynh@yahoo.com', '0988574747', 'AV2'),
('AV0807009', 'An Đăng Khuê', '6/3/1986', 'dangkhue@yahoo.com', '0986757463', 'AV1'),
('AV0807010', 'Nguyễn T. Tuyết Lan', '12/7/1989', 'tuyetlan@gmail.com', '0983310342', 'AV2'),
('AV0807011', 'Đinh Phụng Long', '2/12/1990', 'phunglong@yahoo.com', NULL, 'AV1'),
('AV0807012', 'Nguyễn Tuấn Nam', '2/3/1990', 'tuannam@yahoo.com', NULL, 'AV1');

INSERT INTO Subjects 
VALUES ('S001', 'SQL'),
('S002', 'Java Simplefield'),
('S003', 'Active Server Page');

INSERT INTO Mark 
VALUES ('AV0807005', 'S001','6/5/2008', 8, 25),
('AV0807006', 'S002','6/5/2008', 16, 30),
('AV0807007', 'S001','6/5/2008', 10, 25),
('AV0807009', 'S003', '6/5/2008', 7, 13),
('AV0807010', 'S003', '6/5/2008', 9, 16),
('AV0807011', 'S002', '6/5/2008', 8, 30),
('AV0807012', 'S001', '6/5/2008', 7, 31),
('AV0807005', 'S002', '6/6/2008', 12, 11),
('AV0807009', 'S003', '6/6/2008', 11, 20),
('AV0807010', 'S001', '6/6/2008', 7, 6);

---Cau D:
----1----
SELECT * FROM Students

----2----
SELECT Class, StudentID, StudentName, DateofBirth, Email, Phone
FROM Students
WHERE Class = 'AV1'

----3----
UPDATE Students
SET Class = 'AV2'
WHERE StudentID = 'AV0807012'

----4----
SELECT Class, COUNT(*) as 'Tổng số sinh viên'
FROM Students
GROUP BY Class

----5----
SELECT *
FROM Students
WHERE Class = 'AV2'
ORDER BY StudentName ASC

----6----
SELECT Students.StudentID, StudentName, Subjects.SubjectName, Mark.Theory
FROM Students, Mark, Subjects
WHERE Students.StudentID = Mark.StudentID AND Subjects.SubjectID = Mark.SubjectID
AND Date = '6/5/2008' AND Theory < 10 AND Subjects.SubjectID = 'S001'

----7----
SELECT COUNT(*) as 'Tổng số sinh viên không đạt'
FROM Students, Mark, Subjects
WHERE Students.StudentID = Mark.StudentID AND Subjects.SubjectID = Mark.SubjectID
AND Theory < 10 AND Subjects.SubjectID = 'S001'

----8----
SELECT *
FROM Students
WHERE Class = 'AV1' AND DateofBirth > '1/1/1980'

----9----
DELETE FROM Mark 
WHERE StudentID = 'AV0807011';
DELETE FROM Students
WHERE StudentID = 'AV0807011';

----10----
SELECT Students.StudentID, StudentName, SubjectName, Theory, Practical, Date
FROM Students, Mark, Subjects
WHERE Students.StudentID = Mark.StudentID AND Subjects.SubjectID = Mark.SubjectID AND Subjects.SubjectID = 'S001' AND Date = '6/5/2008'

