-- =============================
-- CLASS
-- =============================
CREATE TABLE harshit_class (
    class_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    class_name VARCHAR2(50) NOT NULL
);

-- =============================
-- SUBJECT
-- =============================
CREATE TABLE harshit_subject (
    subject_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    subject_name VARCHAR2(50),
    class_id NUMBER,
    CONSTRAINT cl_fk_ref FOREIGN KEY (class_id)
    REFERENCES harshit_class(class_id)
);

-- =============================
-- STUDENT
-- =============================
CREATE TABLE harshit_student (
    student_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_name VARCHAR2(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR2(10),
    mobile_number VARCHAR2(20),
    roll_number VARCHAR2(50),
    address VARCHAR2(200),
    class_id NUMBER,
    CONSTRAINT clstu_fk_ref FOREIGN KEY (class_id)
    REFERENCES harshit_class(class_id)
);

-- =============================
-- TEACHER
-- =============================
CREATE TABLE harshit_teacher (
    teacher_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    teacher_name VARCHAR2(50) NOT NULL,
    date_of_birth DATE,
    gender VARCHAR2(10),
    mobile_number VARCHAR2(20),
    email VARCHAR2(50),
    address VARCHAR2(200),
    password VARCHAR2(100),
    CONSTRAINT pass_format_chk
    CHECK (
        LENGTH(password) >= 6
        AND REGEXP_LIKE(password,'[A-Z]')
        AND REGEXP_LIKE(password,'[a-z]')
        AND REGEXP_LIKE(password,'[0-9]')
        AND REGEXP_LIKE(password,'[!@#$%' || CHR(38) || '^]')
    )
);

-- =============================
-- TEACHER SUBJECT
-- =============================
CREATE TABLE harshit_teacher_subject (
    teacher_subject_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    class_id NUMBER,
    subject_id NUMBER,
    CONSTRAINT teachcl_fk_ref FOREIGN KEY (class_id)
    REFERENCES harshit_class(class_id),
    CONSTRAINT teachsub_fk_ref FOREIGN KEY (subject_id)
    REFERENCES harshit_subject(subject_id)
);

-- =============================
-- STUDENT ATTENDANCE
-- =============================
CREATE TABLE harshit_student_attendance (
    student_attendance_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    student_id NUMBER,
    subject_id NUMBER,
    roll_number VARCHAR2(50),
    status VARCHAR2(1) NOT NULL,
    dates DATE DEFAULT TRUNC(SYSDATE),
    CONSTRAINT fk_student_attendance_stuid FOREIGN KEY (student_id)
    REFERENCES harshit_student(student_id),
    CONSTRAINT fk_student_attendance_subid FOREIGN KEY (subject_id)
    REFERENCES harshit_subject(subject_id),
    CONSTRAINT chk_stu_attendance_status
    CHECK (status IN ('P','A','L','H'))
);

-- =============================
-- FEES
-- =============================
CREATE TABLE harshit_fees (
    fees_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    class_id NUMBER,
    fees_amount NUMBER,
    CONSTRAINT fees_fk_ref FOREIGN KEY (class_id)
    REFERENCES harshit_class(class_id)
);

-- =============================
-- EXAM
-- =============================
CREATE TABLE harshit_exam (
    exam_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    class_id NUMBER,
    subject_id NUMBER,
    roll_number VARCHAR2(50),
    total_marks NUMBER,
    out_of_marks NUMBER,
    CONSTRAINT exam_fk_ref FOREIGN KEY (class_id)
    REFERENCES harshit_class(class_id),
    CONSTRAINT fk_student_exam_subid FOREIGN KEY (subject_id)
    REFERENCES harshit_subject(subject_id)
);

-- =============================
-- EXPENSE
-- =============================
CREATE TABLE harshit_expense (
    expense_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    charge_amount NUMBER,
    class_id NUMBER,
    subject_id NUMBER,
    CONSTRAINT expense_fk_ref FOREIGN KEY (class_id)
    REFERENCES harshit_class(class_id),
    CONSTRAINT fk_student_expense_subid FOREIGN KEY (subject_id)
    REFERENCES harshit_subject(subject_id)
);