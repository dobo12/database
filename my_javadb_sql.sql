-- student(학생)
-- 학번(student_id),이름(name),키(height),학과코드(학과 테이블 참조)
-- '20250001','홍길동','163.5'
CREATE TABLE student(
student_id char(8) PRIMARY KEY,
name varchar(20) NOT NULL,
height decimal(5,2),
dept_id varchar(4),
CONSTRAINT fk_student_department foreign key(dept_id) references department(dept_id)
);
-- department(학과)
-- 학과코드(dept_id), 학과명(detp_name) null 허용 안함
-- 'a001','데이터사이언스'
use exam;

CREATE TABLE department(
dept_id varchar(4) PRIMARY KEY,
dept_name varchar(50) NOT null
);
-- professor(교수)
-- 교수코드(prof_id),교수명(prof_name),학과코드(학과 테이블 참조)
-- 'p001','김유진',
CREATE TABLE professor(
	prof_id varchar(4) PRIMARY KEY,
	prof_name varchar(50) NOT NULL,
	dept_id varchar(4),
CONSTRAINT fk_professor_department foreign key(dept_id) refertment(dept_id)
	);
-- subject(과목)
-- 과목코드(subj_id),교수코드(교수 테이블 참조),시작일(start_date),종료일(end_date),과목명(subj_name)
-- 's001', '2025-03-01','2025-06-30','파이썬'
CREATE TABLE subject(
	subj_id char(8) PRIMARY KEY,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	subj_name varchar(100) NOT NULL,
	prof_id varchar(4) 
	CONSTRAINT fk_subject_professor foreign key(prof_id) references professor(prof_id)
);
-- enrollment(수강)
-- 수강코드(enroll_id), 학생코드(학생 테이블 참조), 과목코드(과목 테이블 참조), 수강일자(enroll_date)
-- 1(자동증가), '2025-06-30'
CREATE TABLE enrollment(
enroll_id int auto_increment PRIMARY KEY,
enroll_date date not null,
student_id char(8),
subj_id char(8),
CONSTRAINT fk_enrollment_student foreign key(student_id) REFERENCES student(student_id),
CONSTRAINT fk_enrollment_subject foreign key(subj_id) REFERENCES subject(subj_id)
);



INSERT INTO department VALUES('a001','데이터사이언스');
INSERT INTO department values('a002','경영학과');

INSERT INTO student(student_id,name,height,dept_id) values('20250001','홍길동',163.5,'a002');
INSERT INTO student(student_id,name,dept_id) values('20250002','성춘향','a001');

INSERT INTO professor(prof_id,prof_name,dept_id) values('p001','김유진','a001');

INSERT INTO subject values('s001','2025-03-01','2025-06-30','파이썬','p001');

INSERT INTO enrollment(enroll_date,student_id,subj_id) values(curdate(), '20250001','s001');

select curdate();

select lower('do it sql'), upper('do it sql');

