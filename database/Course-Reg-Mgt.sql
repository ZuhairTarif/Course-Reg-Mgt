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

--PL/SQL PART 


--Creating Functions
-- 1. Write a function to calculate total credit fee
CREATE OR REPLACE FUNCTION calculate_credit_fee(p_credit_per_course IN NUMBER, p_num_courses IN NUMBER)
RETURN NUMBER IS
    v_total_fee NUMBER;
BEGIN
    v_total_fee := p_credit_per_course * p_num_courses * 5500; -- AIUB per credit fee is 5500
    RETURN v_total_fee;
END;
/
-- 2. Write a function to get student email
CREATE OR REPLACE FUNCTION get_student_email(p_student_id IN NUMBER)
RETURN VARCHAR2 IS
    v_email VARCHAR2(50);
BEGIN
    SELECT Email INTO v_email FROM Student WHERE S_INFO = p_student_id;
    RETURN v_email;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;
/
-- 3. Write a function to check course availability
CREATE OR REPLACE FUNCTION check_course_availability(p_course_info IN VARCHAR2)
RETURN BOOLEAN IS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM Course WHERE Course_info = p_course_info;
    RETURN v_count > 0;
END;
/


--Creating Procedures
-- 1. Write a procedure for update course
create or replace PROCEDURE update_course(
    p_course_info IN VARCHAR2,
    p_new_course_time IN VARCHAR2,
    p_new_section IN VARCHAR2
)
IS
BEGIN
    UPDATE Course
    SET Course_time = p_new_course_time,
        Section = p_new_section
    WHERE Course_info = p_course_info;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Course not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
        ROLLBACK;
END;
/
-- 2. Write a procedure to update student password
CREATE OR REPLACE PROCEDURE update_student_password(
    p_s_info IN VARCHAR2,
    p_new_password IN VARCHAR2
)
IS
BEGIN
    UPDATE Student SET Password = p_new_password WHERE S_info = p_s_info;
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Password updated successfully.');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Student not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
-- 3. Write a procedure to assign faculty to course.
CREATE OR REPLACE PROCEDURE assign_faculty_to_course(p_faculty_id IN NUMBER, p_course_info IN VARCHAR2)
IS
BEGIN
    UPDATE Faculty SET Courses = p_course_info WHERE Faculty_id = p_faculty_id;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;
/
 

--Creating Records
-- 1. Write a record to store faculty information
DECLARE
    TYPE FacultyRecord IS RECORD (
        faculty_id Faculty.Faculty_id%TYPE,
        faculty_name Faculty.Name%TYPE,
        faculty_courses Faculty.Courses%TYPE
    );
    v_faculty FacultyRecord;
BEGIN
    SELECT Faculty_id, Name, Courses INTO v_faculty FROM Faculty WHERE Faculty_id = 1003;
    DBMS_OUTPUT.PUT_LINE('Faculty ID: ' || v_faculty.faculty_id || ', Name: ' || v_faculty.faculty_name || ', Courses: ' || v_faculty.faculty_courses);
END;
/
-- 2. Write a record to store course information
DECLARE
    TYPE CourseRecord IS RECORD (
        course_code Course.Course_info%TYPE,
        course_time Course.Course_time%TYPE,
        course_section Course.Section%TYPE
    );
    v_course CourseRecord;
BEGIN
    SELECT Course_info, Course_time, Section INTO v_course FROM Course WHERE Course_info = 'CSC101';
    DBMS_OUTPUT.PUT_LINE('Course Code: ' || v_course.course_code || ', Time: ' || v_course.course_time || ', Section: ' || v_course.course_section);
END;
/
-- 3. Write a record to store student information
DECLARE
    TYPE StudentRecord IS RECORD (
        student_id Student.s_info%TYPE,
        student_name Student.Name%TYPE,
        student_email Student.Email%TYPE
    );
    v_student StudentRecord;
BEGIN
    SELECT s_info, Name, Email INTO v_student FROM Student WHERE s_info = 0001;
    DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student.student_id || ', Name: ' || v_student.student_name || ', Email: ' || v_student.student_email);
END;
/
 

--Creating Cursors
-- 1. Write a cursor to list students in a course
DECLARE
    CURSOR student_cursor IS
        SELECT S_info, Name FROM Student WHERE S_info IN (SELECT S_info FROM Stdsid WHERE Course_info = 'CSC101');
    v_student_id Student.S_info%TYPE;
    v_student_name Student.Name%TYPE;
BEGIN
    OPEN student_cursor;
    LOOP
        FETCH student_cursor INTO v_student_id, v_student_name;
        EXIT WHEN student_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_student_id || ', Name: ' || v_student_name);
    END LOOP;
    CLOSE student_cursor;
END;
/
-- 2. Write a cursor to calculate total credit fees
DECLARE
    CURSOR course_cursor IS
        SELECT Course_D, Credit_per_course FROM DetailsCourse;
    v_course_info DetailsCourse.Course_d%TYPE;
    v_credit_per_course detailscourse.course_credit_fee%TYPE;
    v_total_fee NUMBER := 0;
BEGIN
    OPEN course_cursor;
    LOOP
        FETCH course_cursor INTO v_course_info, v_credit_per_course;
        EXIT WHEN course_cursor%NOTFOUND;
        v_total_fee := v_total_fee + (v_credit_per_course * 5500); -- AIUB per credit 5500
    END LOOP;
    CLOSE course_cursor;
    DBMS_OUTPUT.PUT_LINE('Total Credit Fees: ' || v_total_fee);
END;
/
-- 3. Write a cursor to update students’ email domain
DECLARE
    CURSOR student_cursor IS
        SELECT s_info, Email FROM Student WHERE Email LIKE '%@example.com';
    v_student_id student.s_info%TYPE;
    v_student_email Student.Email%TYPE;
BEGIN
    OPEN student_cursor;
    LOOP
        FETCH student_cursor INTO v_student_id, v_student_email;
        EXIT WHEN student_cursor%NOTFOUND;
        UPDATE Student SET Email = REPLACE(v_student_email, '@example.com', '@aiub.edu') WHERE s_info = v_student_id;
        COMMIT;
    END LOOP;
    CLOSE student_cursor;
END;
/

--Creating Triggers
-- 1. Write a trigger to update course credit fee.
CREATE OR REPLACE TRIGGER update_credit_fee
BEFORE INSERT ON DetailsCourse
FOR EACH ROW
BEGIN
    :NEW.Course_credit_fee := :NEW.Credit_per_course * 5500; -- AIUB per credit fee 5500
END;
/
-- 2. Write a trigger to enforce maximum students in a class.
CREATE OR REPLACE TRIGGER enforce_max_students
BEFORE INSERT ON Stdsid
FOR EACH ROW
DECLARE
    v_max_students NUMBER := 30;
    v_current_students NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_current_students FROM Stdsid WHERE Class_info = :NEW.Class_info;
    IF v_current_students >= v_max_students THEN
        RAISE_APPLICATION_ERROR(-20001, 'Class is full. Cannot enroll more students.');
    END IF;
END;
/
-- 3. Write a trigger to change faculty email domain.
CREATE OR REPLACE TRIGGER change_faculty_email_domain
BEFORE UPDATE ON Faculty
FOR EACH ROW
BEGIN
    IF UPDATING('Email') THEN
        -- Replace old domain with new domain
        :NEW.Email := REPLACE(:NEW.Email, '@example.com', '@aiub.edu');
    END IF;
END;
/

--Creating Packages 
-- 1. Create a package to insert course
CREATE OR REPLACE PACKAGE Course_Package AS
    PROCEDURE Insert_Course(
        p_Course_Info VARCHAR2,
        p_Course_Time VARCHAR2,
        p_Section VARCHAR2
    );
END Course_Package;
/
CREATE OR REPLACE PACKAGE BODY Course_Package AS
    PROCEDURE Insert_Course(
        p_Course_Info VARCHAR2,
        p_Course_Time VARCHAR2,
        p_Section VARCHAR2
    ) IS
    BEGIN
        INSERT INTO Course (Course_Info, Course_Time, Section)
        VALUES (p_Course_Info, p_Course_Time, p_Section);
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END Insert_Course;
END Course_Package;
/ 
-- 2. Create a package to retrieve only Computer Science Faculties
CREATE OR REPLACE PACKAGE Faculty_Package AS
    TYPE Faculty_Record IS RECORD (
        Faculty_ID Faculty.Faculty_ID%TYPE,
        Courses Faculty.Courses%TYPE,
        Time Faculty.Time%TYPE,
        Assigned_Students Faculty.Assigned_Students%TYPE,
        Name Faculty.Name%TYPE,
        Username Faculty.Username%TYPE,
        Password Faculty.Password%TYPE,
        Email Faculty.Email%TYPE
    );
    TYPE Faculty_Cursor IS REF CURSOR RETURN Faculty_Record;
    FUNCTION Get_CSE_Faculties RETURN Faculty_Cursor;
END Faculty_Package;
/
CREATE OR REPLACE PACKAGE BODY Faculty_Package AS
    FUNCTION Get_CSE_Faculties RETURN Faculty_Cursor IS
        cse_faculties Faculty_Cursor;
    BEGIN
        OPEN cse_faculties FOR
            SELECT Faculty_ID, Courses, Time, Assigned_Students, Name, Username, Password, Email
            FROM Faculty
            WHERE Courses = 'Computer Science';
        
        RETURN cse_faculties;
    END Get_CSE_Faculties;
END Faculty_Package;
/ 
-- 3. Create a package to retrieve assigned course by student name.
CREATE OR REPLACE PACKAGE Student_Course_Package AS
    FUNCTION Get_Assigned_Course(
        p_Student_Name Student.Name%TYPE
    ) RETURN VARCHAR2;
END Student_Course_Package;
/
CREATE OR REPLACE PACKAGE BODY Student_Course_Package AS
    FUNCTION Get_Assigned_Course(
        p_Student_Name Student.Name%TYPE
    ) RETURN VARCHAR2 IS
        v_Assigned_Course VARCHAR2(20);
    BEGIN
        SELECT DISTINCT ci.Course_d INTO v_Assigned_Course
        FROM Stdsid s
        JOIN Course_id ci ON s.Course_id = ci.Course_id
        JOIN Student stu ON s.S_info = stu.S_info
        WHERE stu.Name = p_Student_Name;

        RETURN v_Assigned_Course;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END Get_Assigned_Course;
END Student_Course_Package;
/


