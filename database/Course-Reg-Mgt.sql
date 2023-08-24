-- Enable Oracle SQL Plus Compatibility Mode
--ALTER SESSION SET "_oracle_script" = true;
--DROP USER ADMS CASCADE;
--CREATE USER ADMS IDENTIFIED BY "tiger";
--GRANT CREATE VIEW, CONNECT, RESOURCE, CREATE SESSION, CREATE SYNONYM, UNLIMITED TABLESPACE TO ADMS;


-- Table Transaction
CREATE TABLE TRANSACTION (
    S_transaction NUMBER(10) CONSTRAINT pk_trns PRIMARY KEY,
    Student_pay NUMBER(10),
    Student_due NUMBER(10)
);

CREATE SEQUENCE Transaction_seq
    START WITH 1200
    INCREMENT BY 1
    MAXVALUE 4000
    NOCYCLE
    NOCACHE;

CREATE INDEX Transaction_indx ON TRANSACTION(S_transaction, Student_pay, Student_due);

-- Table Course
CREATE TABLE Course (
    Course_info VARCHAR2(20) CONSTRAINT pk_Crs PRIMARY KEY,
    Course_time VARCHAR2(20),
    SECTION VARCHAR2(8)
);

CREATE SEQUENCE Course_seq
    START WITH 1100
    INCREMENT BY 1
    MAXVALUE 3000
    NOCYCLE
    NOCACHE;

CREATE INDEX Course_indx ON Course(Course_info, Course_time, SECTION);

-- Table Student
CREATE TABLE Student (
    S_info VARCHAR2(20) CONSTRAINT pk_std PRIMARY KEY,
    Details VARCHAR2(25),
    Name VARCHAR2(20),
    Username VARCHAR2(20),
    Password VARCHAR2(20),
    Email VARCHAR2(50)
);

CREATE SEQUENCE Student_seq
    START WITH 1000
    INCREMENT BY 1
    MAXVALUE 2000
    NOCYCLE
    NOCACHE;

CREATE INDEX Student_indx ON Student(S_info, Details, Name);

-- Table Class
CREATE TABLE Class (
    Class_info VARCHAR2(20) CONSTRAINT pk_Cls PRIMARY KEY,
    Room_number NUMBER(4),
    Sections VARCHAR2(8)
);

CREATE SEQUENCE Class_seq
    START WITH 1000
    INCREMENT BY 1
    MAXVALUE 3000
    NOCYCLE
    NOCACHE;

CREATE INDEX Class_indx ON Class(Class_info, Room_number, Sections);

-- Table DetailsCourse
CREATE TABLE DetailsCourse (
    Course_d VARCHAR2(20) CONSTRAINT pk_crsdtls PRIMARY KEY,
    Credit_per_course NUMBER(4),
    Course_credit_fee NUMBER(8)
);

CREATE SEQUENCE CourseDetails_seq
    START WITH 1300
    INCREMENT BY 1
    MAXVALUE 2000
    NOCYCLE
    NOCACHE;

CREATE INDEX CourseDetails_indx ON DetailsCourse(Course_d, Credit_per_course, Course_credit_fee);

-- Table Faculty
CREATE TABLE Faculty (
    Faculty_id NUMBER(8) CONSTRAINT pk_Flt PRIMARY KEY,
    Courses VARCHAR2(30),
    TIME VARCHAR2(8),
    Assigned_students NUMBER(30),
    Name VARCHAR2(10),
    Username VARCHAR2(20),
    Password VARCHAR2(20),
    Email VARCHAR2(50)
);

CREATE SEQUENCE Faculty_seq
    START WITH 1000
    INCREMENT BY 1
    MAXVALUE 3000
    NOCYCLE
    NOCACHE;

CREATE INDEX Faculty_indx ON Faculty(Faculty_id, Courses, TIME, Assigned_students, Name);

-- Table Accountant
CREATE TABLE Accountant (
    Accountant_id NUMBER(5) CONSTRAINT pk_acc PRIMARY KEY,
    Student_Information VARCHAR2(30),
    S_transaction NUMBER(8),
    Students_id NUMBER(7),
    Course_info VARCHAR2(20)
);

ALTER TABLE Accountant ADD CONSTRAINT fk_acc_trns FOREIGN KEY (S_transaction) REFERENCES TRANSACTION(S_transaction);
ALTER TABLE Accountant ADD CONSTRAINT fk_acc_crs_info FOREIGN KEY (Course_info) REFERENCES Course(Course_info);

CREATE SEQUENCE Accountant_seq
    START WITH 1200
    INCREMENT BY 1
    MAXVALUE 4000
    NOCYCLE
    NOCACHE;

CREATE INDEX Accountant_indx ON Accountant(Accountant_id, Student_Information, S_transaction, Students_id, Course_info);

-- Table Stdsid
CREATE TABLE Stdsid (
    Students_id NUMBER(7) CONSTRAINT pk_Stds_id PRIMARY KEY,
    Assigned_Course VARCHAR2(20),
    Credit_per_course VARCHAR2(4),
    Total_credit_fee NUMBER(8),
    Course_info VARCHAR2(20),
    Department_id NUMBER(5),
    S_info VARCHAR2(30),
    Course_id NUMBER(5),
    Class_info VARCHAR2(20)
);

ALTER TABLE Accountant ADD CONSTRAINT fk_acc_std_id FOREIGN KEY (Students_id) REFERENCES Stdsid(Students_id);
ALTER TABLE Stdsid ADD CONSTRAINT fk_std_crs FOREIGN KEY (Course_info) REFERENCES Course(Course_info);
ALTER TABLE Stdsid ADD CONSTRAINT fk_std_S FOREIGN KEY (S_info) REFERENCES Student(S_info);
ALTER TABLE Stdsid ADD CONSTRAINT fk_std_cls FOREIGN KEY (Class_info) REFERENCES Class(Class_info);

CREATE SEQUENCE Stdsid_seq
    START WITH 1200
    INCREMENT BY 1
    MAXVALUE 4000
    NOCYCLE
    NOCACHE;

CREATE INDEX Stdsid_indx ON Stdsid(Students_id, Assigned_Course, Credit_per_course, Total_credit_fee, Course_info, Department_id, S_info, Course_id, Class_info);

-- Table Dept
CREATE TABLE Dept (
    Department_id NUMBER(5) CONSTRAINT pk_dept_id PRIMARY KEY,
    Assigned_faculty VARCHAR2(10),
    Assigned_course VARCHAR2(20),
    S_info VARCHAR2(30),
    Course_id NUMBER(5),
    Class_info VARCHAR2(20),
    Faculty_id NUMBER(8),
    Course_d VARCHAR2(20)
);

ALTER TABLE Stdsid ADD CONSTRAINT fk_std_dept FOREIGN KEY (Department_id) REFERENCES Dept(Department_id);
ALTER TABLE Dept ADD CONSTRAINT fk_dept_std FOREIGN KEY (S_info) REFERENCES Student(S_info);
ALTER TABLE Dept ADD CONSTRAINT fk_dept_cls FOREIGN KEY (Class_info) REFERENCES Class(Class_info);
ALTER TABLE Dept ADD CONSTRAINT fk_dept_fclt FOREIGN KEY (Faculty_id) REFERENCES Faculty(Faculty_id);
ALTER TABLE Dept ADD CONSTRAINT fk_dept_crsd FOREIGN KEY (Course_d) REFERENCES DetailsCourse(Course_d);

CREATE SEQUENCE Dept_seq
    START WITH 1200
    INCREMENT BY 1
    MAXVALUE 4000
    NOCYCLE
    NOCACHE;

CREATE INDEX Dept_indx ON Dept(Department_id, Assigned_faculty, Assigned_course, S_info, Course_id, Class_info, Faculty_id, Course_d);

-- Table Course_id
CREATE TABLE Course_id (
    Course_id NUMBER(5) CONSTRAINT pk_crsid PRIMARY KEY,
    TIME VARCHAR(8),
    Number_of_student VARCHAR2(20),
    Assign_student_detail VARCHAR2(30),
    Name VARCHAR2(20),
    Class_info VARCHAR2(20),
    Faculty_id NUMBER(8),
    Course_d VARCHAR2(20)
);

ALTER TABLE Dept ADD CONSTRAINT fk_dept_crs FOREIGN KEY (Course_id) REFERENCES Course_id(Course_id);
ALTER TABLE Course_id ADD CONSTRAINT fk_crsii_info FOREIGN KEY (Class_info) REFERENCES Class(Class_info);
ALTER TABLE Course_id ADD CONSTRAINT fk_crsii_Faculty FOREIGN KEY (Faculty_id) REFERENCES Faculty(Faculty_id);
ALTER TABLE Course_id ADD CONSTRAINT fk_crsii_Course FOREIGN KEY (Course_d) REFERENCES DetailsCourse(Course_d);

CREATE SEQUENCE Courseid_seq
    START WITH 1200
    INCREMENT BY 1
    MAXVALUE 4000
    NOCYCLE
    NOCACHE;

CREATE INDEX Courseid_indx ON Course_id(Course_id, TIME, Assign_student_detail, Name, Class_info, Faculty_id, Course_d);
ALTER TABLE Stdsid ADD CONSTRAINT fk_std_crsid FOREIGN KEY (Course_id) REFERENCES Course_id(Course_id);

-- Insert data into the Faculty table
INSERT INTO Faculty (Faculty_id, Courses, Time, Assigned_students, Name, Username, Password, Email)
VALUES (1001, 'Computer Science', '13:00', 30, 'Jane', 'jane123', 'password123', 'jane@example.com');

INSERT INTO Faculty (Faculty_id, Courses, Time, Assigned_students, Name, Username, Password, Email)
VALUES (1002, 'Physics', '11:00', 20, 'Michael', 'michael567', 'pass4321', 'michael@example.com');

INSERT INTO Faculty (Faculty_id, Courses, Time, Assigned_students, Name, Username, Password, Email)
VALUES (1003, 'History', '09:00', 15, 'Sarah', 'sarah321', 'abc@123', 'sarah@example.com');

INSERT INTO Faculty (Faculty_id, Courses, Time, Assigned_students, Name, Username, Password, Email)
VALUES (1004, 'Mathematics', '10:00', 25, 'John', 'john_m', 'john456', 'john@example.com');

INSERT INTO Faculty (Faculty_id, Courses, Time, Assigned_students, Name, Username, Password, Email)
VALUES (1005, 'English', '14:00', 18, 'David', 'david_english', 'david789', 'david@example.com');

-- Insert data into the Class table
INSERT INTO Class (Class_info, room_number, Sections)
VALUES ('Class100', 106, 'C');

INSERT INTO Class (Class_info, room_number, Sections)
VALUES ('Class101', 106, 'C');

INSERT INTO Class (Class_info, room_number, Sections)
VALUES ('Class102', 105, 'A');

INSERT INTO Class (Class_info, room_number, Sections)
VALUES ('Class103', 106, 'B');

INSERT INTO Class (Class_info, room_number, Sections)
VALUES ('Class104', 106, 'B');

-- Insert data into the DetailsCourse table
INSERT INTO DetailsCourse (Course_d, Credit_per_course, Course_credit_fee)
VALUES ('CSC101', 3, 1500);

INSERT INTO DetailsCourse (Course_d, Credit_per_course, Course_credit_fee)
VALUES ('CSC102', 3, 1500);

INSERT INTO DetailsCourse (Course_d, Credit_per_course, Course_credit_fee)
VALUES ('CSC103', 3, 1500);

INSERT INTO DetailsCourse (Course_d, Credit_per_course, Course_credit_fee)
VALUES ('CSC104', 3, 1500);

INSERT INTO DetailsCourse (Course_d, Credit_per_course, Course_credit_fee)
VALUES ('CSC105', 3, 1500);

-- Insert data into the Student table
INSERT INTO Student (S_info, Details, Name, Username, Password, Email)
VALUES ('0001', 'CSE', 'Noboni', 'noboni123', 'pass1234', 'noboni@example.com');

INSERT INTO Student (S_info, Details, Name, Username, Password, Email)
VALUES ('0002', 'CSE', 'Succho', 'succho123', 'succho4321', 'succho@example.com');

INSERT INTO Student (S_info, Details, Name, Username, Password, Email)
VALUES ('0003', 'SE', 'Fahim', 'fahim99', 'abcxyz', 'fahim@example.com');

INSERT INTO Student (S_info, Details, Name, Username, Password, Email)
VALUES ('0004', 'CSE', 'Sakib', 'sakib456', 'pass456', 'sakib@example.com');

INSERT INTO Student (S_info, Details, Name, Username, Password, Email)
VALUES ('0005', 'SE', 'Ashesh', 'ashesh_m', 'ash123', 'ashesh@example.com');

-- Insert data into the Course table
INSERT INTO Course (Course_info, Course_time, Section)
VALUES ('CSC101', '10.30-12.30', 'A');

INSERT INTO Course (Course_info, Course_time, Section)
VALUES ('CSC102', '8.30-11.00', 'F');

INSERT INTO Course (Course_info, Course_time, Section)
VALUES ('CSC103', '10.30-12.00', 'B');

INSERT INTO Course (Course_info, Course_time, Section)
VALUES ('CSC104', '2.30-5.00', 'A');

INSERT INTO Course (Course_info, Course_time, Section)
VALUES ('CSC105', '11.30-2.00', 'C');

-- Insert data into the Transaction table
INSERT INTO Transaction (S_transaction, Student_pay, Student_due)
VALUES (Transaction_seq.NEXTVAL, 1000, 500);

INSERT INTO Transaction (S_transaction, Student_pay, Student_due)
VALUES (Transaction_seq.NEXTVAL, 2000, 1500);

INSERT INTO Transaction (S_transaction, Student_pay, Student_due)
VALUES (Transaction_seq.NEXTVAL, 1000, 500);

INSERT INTO Transaction (S_transaction, Student_pay, Student_due)
VALUES (Transaction_seq.NEXTVAL, 1030, 700);

INSERT INTO Transaction (S_transaction, Student_pay, Student_due)
VALUES (Transaction_seq.NEXTVAL, 1200, 500);

-- Insert data into the Course_id table
INSERT INTO Course_id (Course_id, Time, Number_of_student, Assign_student_detail, Name, Class_info, Faculty_id, Course_d)
VALUES(Courseid_seq.NEXTVAL, '10:00 AM', '20', 'Assigned students', 'Database Systems', 'Class101', 1001, 'CSC101');

INSERT INTO Course_id (Course_id, Time, Number_of_student, Assign_student_detail, Name, Class_info, Faculty_id, Course_d)
VALUES(Courseid_seq.NEXTVAL, '11:30 AM', '30', 'Assigned students', 'Database Systems', 'Class100', 1002, 'CSC102');

INSERT INTO Course_id (Course_id, Time, Number_of_student, Assign_student_detail, Name, Class_info, Faculty_id, Course_d)
VALUES(Courseid_seq.NEXTVAL, '8:30 AM', '24', 'Assigned students', 'Database Systems', 'Class102', 1003, 'CSC103');

INSERT INTO Course_id (Course_id, Time, Number_of_student, Assign_student_detail, Name, Class_info, Faculty_id, Course_d)
VALUES(Courseid_seq.NEXTVAL, '9:40 AM', '28', 'Assigned students', 'Database Systems', 'Class103', 1004, 'CSC104');

INSERT INTO Course_id (Course_id, Time, Number_of_student, Assign_student_detail, Name, Class_info, Faculty_id, Course_d)
VALUES(Courseid_seq.NEXTVAL, '2:30 AM', '32', 'Assigned students', 'Database Systems', 'Class104', 1005, 'CSC105');

-- Insert data into the Dept table
INSERT INTO Dept (Department_id, Assigned_faculty, Assigned_course, S_info, Course_id, class_info, Faculty_id, Course_d)
VALUES (101, 'FST', 'Biology', '0005', 1203, 'Class103', 1002, 'CSC101');

INSERT INTO Dept (Department_id, Assigned_faculty, Assigned_course, S_info, Course_id, class_info, Faculty_id, Course_d)
VALUES (102, 'BBA', 'Communications', '0003', 1202, 'Class104', 1003, 'CSC103');

INSERT INTO Dept (Department_id, Assigned_faculty, Assigned_course, S_info, Course_id, class_info, Faculty_id, Course_d)
VALUES (103, 'FST', 'Microprocessor', '0001', 1201, 'Class100', 1001, 'CSC102');

INSERT INTO Dept (Department_id, Assigned_faculty, Assigned_course, S_info, Course_id, class_info, Faculty_id, Course_d)
VALUES (104, 'ENG', 'English', '0004', 1204, 'Class103', 1003, 'CSC104');

INSERT INTO Dept (Department_id, Assigned_faculty, Assigned_course, S_info, Course_id, Class_info, Faculty_id, Course_d)
VALUES (105, 'ART', 'Theme', '0002', 1200, 'Class101', 1005, 'CSC105');

-- Insert data into the Stdsid table
INSERT INTO Stdsid (Students_id, Assigned_Course, Credit_per_course, Total_credit_fee, Course_info, Department_id, S_info, Course_id, Class_info)
VALUES (Stdsid_seq.NEXTVAL, 'Computer Science', '3', 15, 'CSC103', 104, '0002', 1204, 'Class103');

INSERT INTO Stdsid (Students_id, Assigned_Course, Credit_per_course, Total_credit_fee, Course_info, Department_id, S_info, Course_id, Class_info)
VALUES (Stdsid_seq.NEXTVAL, 'OOP2', '3', 18, 'CSC102', 103, '0003', 1201, 'Class100');

INSERT INTO Stdsid (Students_id, Assigned_Course, Credit_per_course, Total_credit_fee, Course_info, Department_id, S_info, Course_id, Class_info)
VALUES (Stdsid_seq.NEXTVAL, 'Compiler', '3', 12, 'CSC105', 102, '0001', 1202, 'Class104');

INSERT INTO Stdsid (Students_id, Assigned_Course, Credit_per_course, Total_credit_fee, Course_info, Department_id, S_info, Course_id, Class_info)
VALUES (Stdsid_seq.NEXTVAL, 'Database', '3', 9, 'CSC101', 105, '0005', 1203, 'Class101');

INSERT INTO Stdsid (Students_id, Assigned_Course, Credit_per_course, Total_credit_fee, Course_info, Department_id, S_info, Course_id, Class_info)
VALUES (Stdsid_seq.NEXTVAL, 'Computer network', '3', 12, 'CSC104', 101, '0004', 1200, 'Class102');

-- Insert data into the Accountant table
INSERT INTO Accountant (Accountant_id, Student_Information, S_transaction, Students_id, Course_info)
VALUES (4450, 'payment', '1200', '1202', 'CSC104');

INSERT INTO Accountant (Accountant_id, Student_Information, S_transaction, Students_id, Course_info)
VALUES (4451, 'payment', '1202', '1200', 'CSC102');

INSERT INTO Accountant (Accountant_id, Student_Information, S_transaction, Students_id, Course_info)
VALUES (4452, 'payment', '1200', '1203', 'CSC101');

INSERT INTO Accountant (Accountant_id, Student_Information, S_transaction, Students_id, Course_info)
VALUES (4453, 'payment', '1203', '1203', 'CSC103');

INSERT INTO Accountant (Accountant_id, Student_Information, S_transaction, Students_id, Course_info)
VALUES (4454, 'payment', '1202', '1201', 'CSC105');

--Creating Views
CREATE VIEW total_sections AS
SELECT Course_info, COUNT(*) as num_sections
FROM Course
GROUP BY Course_info;
CREATE VIEW faculty_names_view AS
SELECT Name FROM Faculty;
CREATE VIEW student_names AS
SELECT NAME FROM Student;

--Creating Synonyms
CREATE SYNONYM Details FOR DetailsCourse;
CREATE SYNONYM Stdsid_syn
FOR Stdsid;
CREATE SYNONYM Syn_Dept FOR Dept;


