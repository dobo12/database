-- SQL 
-- 1. 데이터 정의 언어(DDL : Data Define Language)
-- 2. 데이터 조작 언어(DML : Data Manipulation Language) : SELECT(조회), INSERT(입력), UPDATE(수정), DELETE(삭제) => CRUD
-- 3. 데이터 제어 언어(DCL : Data Control Language)


-- sql 구문은 대소문자를 구별하지 않는다
-- 단, 비밀번호는 구별함 

-- 조회(select)
-- select 컬럼명 -- ⑤
-- from 테이블명 -- ①
-- where 조건절  -- ②
-- group by -- ③
-- having -- ④
-- order by 컬럼명 desc or asc -- ⑥

-- emp(사원) 테이블
-- empno(사번) : number(4,0) => 숫자, 4자리, 소수점 아래 자릿수는 0
-- ename(이름) : varchar2(10) => 문자
-- job(직무) 
-- mgr(매니저-상사 사원번호)
-- hiredate(입사일)
-- sal(급여) : number(7,2) 
-- comm(수당)
-- deptno(부서번호)

-- dept(부서) 테이블
-- deptno(부서번호)
-- dname(부서명)
-- loc(부서위치)

-- 조회 기본 구문
-- SELECT 보고싶은열이름.... FROM 테이블명;
-- SELECT 보고싶은열이름.... FROM 테이블명 WHERE 조건 나열;

-- 1) 전체 사원 조회 시 사원 모든 정보 추출
SELECT * FROM EMP e; 

-- 2) 전체 사원 조회 시 사원 이름만 추출
SELECT ename FROM EMP e; 

-- 3) 전체 사원 조회 시 사번,사원명,부서번호만 추출
SELECT e.empno,ename,deptno FROM EMP e;

-- 4) 전체 사원 조회 시 부서번호만 추출
SELECT deptno FROM EMP e;

-- 5) 전체 사원 조회 시 부서번호만 추출 + 중복된 데이터 제거(DISTINCT) 후
SELECT DISTINCT deptno FROM EMP e;

-- 6) alais(별칭)
SELECT ename "사원명" FROM EMP e;
SELECT ename 사원명 FROM EMP e;
SELECT ename AS "사원명" FROM EMP e;

-- 연봉구하기 (sal * 12 + comm)
SELECT empno, sal * 12 + comm AS 연봉 FROM EMP e;

-- ORA-00923: FROM 키워드가 필요한 위치에 없습니다.
-- SELECT ename AS 사원 이름 FROM EMP e;

SELECT ename AS "사원 이름" FROM EMP e;

-- 오름차순(기본값), 내림차순 정렬 : ORDER BY 정렬기준 열이름.... ASC(오름) OR DESC(내림)
-- 급여의 오름차순 정렬
SELECT * FROM emp ORDER BY sal ASC;
SELECT * FROM emp ORDER BY sal;
-- 급여의 내림차순 
SELECT * FROM emp ORDER BY sal desc;
-- 급여의 내림차순, 이름의 오름차순
SELECT * FROM emp ORDER BY sal DESC,ename asc;

-- [실습]
-- empno : employee_no,
-- ename : employee_name
-- mgr : manager
-- sal : salary
-- comm : commission
-- deptno : department_no
-- 별칭 지정, 부서번호를 기준으로 내림차순 정렬, 단 부서번호가 같다면 이름 오름차순


SELECT
	e.EMPNO AS employee_no,
	e.ENAME employee_name,
	e.MGR manager,
	e.SAL salary,
	e.COMM commission,
	e.DEPTNO department_no
FROM
	EMP e
ORDER BY
	e.DEPTNO DESC,
	e.ENAME ASC;

-- 부서번호가 30번인 사원정보 조회
-- = (같다) / 문자 '' / and / or
SELECT * FROM emp WHERE deptno = 30;
-- 사번이 7698 인 사원정보 조회
SELECT * FROM emp WHERE empno = 7698;
-- 부서번호가 30번이고 사원직책이 salesman 인 사원정보 조회
SELECT * FROM emp WHERE deptno=30 AND job='SALESMAN';
-- 부서번호가 30번이거나 사원직책이 analyst 인 사원정보 조회
SELECT * FROM emp WHERE deptno=30 OR job='ANALYST';

-- 연산자
-- +, -, *, /, =, >, <, >=, <=, and, or, 같지않다 => !=, <>, ^=
-- in, between A and B (~ 이상 ~ 이하)
-- like 

-- 연봉이 36000 인 사원 조회
SELECT * FROM EMP e WHERE sal*12 = 36000;

-- 급여가 3000 초과인 사원 조회
SELECT * FROM EMP e WHERE sal > 3000;

-- 이름이 'F' 이후의 문자로 시작하는 사원 조회
SELECT * FROM EMP e WHERE e.ENAME >= 'F';

-- 직무가 manager, salesman, clerk 인 사원 조회
SELECT * FROM EMP e WHERE e.JOB = 'SALESMAN' OR e.JOB = 'SALESMAN' OR e.JOB ='CLERK';

-- sal 이 3000 이 아닌 사원 조회
SELECT * FROM EMP e WHERE e.SAL != 3000;
SELECT * FROM EMP e WHERE e.SAL <> 3000;
SELECT * FROM EMP e WHERE e.SAL ^= 3000;

-- 직무가 manager, salesman, clerk 인 사원 조회 + IN
SELECT * FROM EMP e WHERE e.JOB IN ('SALESMAN','SALESMAN','CLERK');

-- 직무가 manager, salesman, clerk 가 아닌 사원 조회 + NOT IN
SELECT * FROM EMP e WHERE e.JOB NOT IN ('SALESMAN','SALESMAN','CLERK');

-- 부서번호가 10,20 번인 사원 조회(OR, IN)
SELECT * FROM EMP e WHERE e.DEPTNO = 10 OR e.DEPTNO = 20;
SELECT * FROM EMP e WHERE e.DEPTNO IN (10,20);

-- between a and b
-- 급여가 2000 이상 3000 이하인 사원 조회
SELECT * FROM EMP e WHERE e.SAL >= 2000 AND e.sal <= 3000;

SELECT * FROM EMP e WHERE e.SAL BETWEEN 2000 AND 3000;

-- 급여가 2000 이상 3000 이하가 아닌 사원 조회
SELECT * FROM EMP e WHERE e.SAL NOT BETWEEN 2000 AND 3000;


-- LIKE + 와일드카드(%, _)
-- % : 길이와 상관없이(문자 없는 경우도 포함) 모든 문자 데이터를 의미
-- _ : 한개의 문자 데이터를 의미

-- 사원명이 S로 시작하는 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE 'S%';

-- 사원명의 두번째 글자가 L인 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '_L%';

-- 사원이름의 AM이 포함된 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '%AM%';

-- 사원이름의 AM이 포함되지 않은 사원들의 정보 조회
SELECT * FROM EMP e WHERE e.ENAME NOT LIKE '%AM%';


-- null 값
-- null값은 비교 시 = or != 사용하지 않음
-- SELECT * FROM emp WHERE comm = NULL; (X)

SELECT * FROM emp WHERE comm is NULL;
SELECT * FROM emp WHERE comm is NOT NULL;


-- 집합연산자
-- 합집합(UNION, UNION ALL), 교집합(INTERSECT), 차집합(MINUS)

-- 합집합 : 출력하려는 열 개수와 자료형이 일치
-- UNION : 중복 제거
-- DEPTNO=10 UNION DEPTNO=20
SELECT
	EMPNO, ENAME, SAL
FROM
	EMP
WHERE
	DEPTNO = 10
UNION 
SELECT
	*
FROM
	EMP
WHERE
	DEPTNO = 20;


-- UNION ALL
SELECT
	EMPNO, ENAME, SAL
FROM
	EMP
WHERE
	DEPTNO = 10
UNION ALL
SELECT
	EMPNO, ENAME, SAL
FROM
	EMP
WHERE
	DEPTNO = 10;


-- MINUS
SELECT
	EMPNO, ENAME, SAL
FROM
	EMP
MINUS
SELECT
	EMPNO, ENAME, SAL
FROM
	EMP
WHERE
	DEPTNO = 10;



-- INTERSECT
SELECT
	EMPNO, ENAME, SAL
FROM
	EMP
INTERSECT 
SELECT
	EMPNO, ENAME, SAL
FROM
	EMP
WHERE
	DEPTNO = 10;

-- [실습]
-- 1. 사원 이름이 S로 끝나는 사원 데이터 조회
SELECT * FROM EMP e WHERE e.ENAME LIKE '%S';

-- 2. 30번 부서에 근무하고 있는 사원 중에 JOB 이 SALESMAN 인 사원의 사원번호, 이름, 직책, 급여, 부서번호 조회
SELECT e.EMPNO,e.JOB,e.SAL,e.DEPTNO  FROM EMP e WHERE e.DEPTNO = 30 AND e.JOB = 'SALESMAN';

-- 3. 20번, 30번 부서에 근무하고 있는 사원 중 급여가 2000 초과인 사원을 다음 두 방식의 SELECT 문을 사용하여
-- 사원번호, 이름, 직책, 급여, 부서 번호를 출력
-- 집합 연산자를 사용하는 방식

SELECT e.EMPNO,e.ENAME, e.JOB,e.SAL,e.DEPTNO  FROM EMP e WHERE e.DEPTNO = 20 AND e.SAL > 2000
UNION 
SELECT e.EMPNO,e.ENAME, e.JOB,e.SAL,e.DEPTNO  FROM EMP e WHERE e.DEPTNO = 30 AND e.SAL > 2000;


SELECT e.EMPNO,e.ENAME, e.JOB,e.SAL,e.DEPTNO  FROM EMP e WHERE e.SAL > 2000
MINUS 
SELECT e.EMPNO,e.ENAME, e.JOB,e.SAL,e.DEPTNO  FROM EMP e WHERE e.DEPTNO = 10;


-- 집합 연산자를 사용하지 않는 방식

SELECT e.EMPNO,e.ENAME, e.JOB,e.SAL,e.DEPTNO  FROM EMP e WHERE (e.DEPTNO = 20 OR e.DEPTNO = 30) AND e.SAL > 2000;

SELECT e.EMPNO,e.ENAME, e.JOB,e.SAL,e.DEPTNO  FROM EMP e WHERE e.DEPTNO IN (20,30) AND e.SAL > 2000;


-- 4. NOT BETWEEN A AND B 연산자를 사용하지 않고 급여열이 2000 이상 3000이하 범위 이외의 값을 가진 데이터 조회
-- SELECT * FROM EMP e WHERE e.SAL NOT BETWEEN 2000 AND 3000;
SELECT * FROM EMP e WHERE e.SAL < 2000 OR e.sal > 3000;

-- 5. 사원 이름에 E 가 포함된 30번 부서의 사원 중 급여가 1000 ~ 2000 사이가 아닌 사원명,사번,급여,부서번호 조회

SELECT
	e.EMPNO,
	e.ENAME,
	e.SAL,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.ENAME LIKE '%E%'
	AND e.DEPTNO = 30
	AND e.SAL NOT BETWEEN 1000 AND 2000;


-- 6. 추가 수당이 없고 상급자가 있고 직책이 MANAGER, CLERK 인 사원 중에서 사원이름의 두번째 글자가 L이 아닌
-- 사원의 정보를 조회

SELECT
	*
FROM
	EMP e
WHERE
	e.COMM IS NULL
	AND e.MGR IS NOT NULL
	AND e.JOB IN ('MANAGER', 'CLERK')
	AND e.ENAME NOT LIKE '_L%';

-- 함수
-- 1. 문자함수 
-- UPPER(문자열) : 대문자 변환
-- LOWER(문자열) : 소문자 변환
-- INITCAP(문자열) : 첫글자는 대문자, 나머지 문자는 소문자
-- LENGTH(문자열) : 문자열 길이
-- LENGTHB(문자열) : 문자열의 바이트 길이
-- SUBSTR(문자열데이터,시작위치,추출길이) : 문자열 부분추출
-- INSTR(대상문자열, 위치를 찾으려는 문자, 위치찾기시작위치, 찾으려는 문자가 몇 번째인지) : 문자열데이터 안에서 특정 문자 위치 찾기
-- REPLACE(문자열, 찾는문자, 바꿀문자)
-- CONCAT(문자열1, 문자열2) : 두 문자열 데이터 합치기
-- TRIM(삭제옵션(선택),삭제할문자(선택) FROM 원본문자열)
--   1) 삭제옵션 : LEADING OR TRAILING OR BOTH
-- LTRIM(원본문자열,삭제할 문자열)
-- RTRIM(원본문자열,삭제할 문자열)


SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP e; 


SELECT ENAME, LENGTH(ENAME), LENGTHB(ENAME)
FROM EMP e; 

-- DUAL(SYS 소유의 테이블, 더미 테이블)
-- 임시연산이나 함수의 결과값 확인 용도
-- xe21 (한글 한자당 3Byte 사용)
SELECT LENGTH('한글'), LENGTHB('한글') FROM DUAL; 

-- 사원명 길이가 5이상인 사원 조회
SELECT * FROM EMP e WHERE LENGTH(e.ENAME) >= 5;

-- 직책명이 6자 이상인 사원 조회
SELECT * FROM EMP e WHERE LENGTH(e.JOB) >= 6;

SELECT job, SUBSTR(e.job,1,2), SUBSTR(e.job,3,2), SUBSTR(e.job,5)
FROM EMP e; 

-- emp 테이블에서 사원명을 세번째 글자부터 끝까지 출력
SELECT e.ENAME, SUBSTR(e.ENAME,3)
FROM EMP e;

-- -8    -1
-- SALESMAN

SELECT job, SUBSTR(e.job,-LENGTH(E.JOB)), SUBSTR(e.job,-LENGTH(E.JOB),2), SUBSTR(e.job,-3)
FROM EMP e; 

SELECT INSTR('HELLO, ORACLE!','L') AS 첫번째, INSTR('HELLO, ORACLE!','L',5) AS 두번째,INSTR('HELLO, ORACLE!','L',2,2) AS 세번째
FROM DUAL;

-- 사원명에 문자S가 포함된 사원 조회
-- 1) LIKE  2) INSTR()
SELECT * FROM EMP e WHERE INSTR(E.ENAME,'S') > 0;

-- 010-4526-7858 => 010 4526 7858 OR 01045267858
SELECT '010-4526-7858' AS BEFORE, REPLACE('010-4526-7858','-',' ') AS REPLACE1, REPLACE('010-4526-7858','-') AS REPLACE2
FROM DUAL;

-- concat() or ||
-- EMPNO, ENAME 합치기
SELECT CONCAT(e.EMPNO, e.ENAME), CONCAT(e.EMPNO, CONCAT(':', e.ENAME)), e.EMPNO || e.ENAME, e.EMPNO || ':' || e.ENAME  
FROM EMP e; 


-- TRIM()
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS TRIM_LEADING,
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS TRIM_TRAILING,
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS TRIM_BOTH
FROM
	DUAL;


SELECT
	'[' || TRIM(' _Oracle_ ') || ']' AS trim,
	'[' || LTRIM(' _Oracle_ ') || ']' AS LTRIM,
	'[' || LTRIM('<_Oracle_>','_<') || ']' AS LTRIM2,
	'[' || RTRIM(' _Oracle_ ') || ']' AS RTRIM,	
	'[' || RTRIM('<_Oracle_>','>_') || ']' AS RTRIM2	
FROM
	DUAL;


-- 숫자함수
-- ROUND(숫자, 반올림위치) : 반올림
-- TRUNC(숫자, 버림위치) : 버림
-- CEIL(숫자) : 지정된 숫자보다 큰 정수 중 가장 작은 정수 반환
-- FLOOR(숫자) : 지정된 숫자보다 작은 정수 중 가장 큰 정수 반환
-- MOD(숫자, 나눌숫자) : 지정된 숫자를 나눈 나머지 반환

--   -1 
-- 1234.5678 

SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND0,
	ROUND(1234.5678, 1) AS ROUND1,
	ROUND(1234.5678, 2) AS ROUND2,
	ROUND(1234.5678,-1) AS ROUND_MINUS1,
	ROUND(1234.5678,-2) AS ROUND_MINUS2
FROM
	DUAL;


SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC0,
	TRUNC(1234.5678, 1) AS TRUNC1,
	TRUNC(1234.5678, 2) AS TRUNC2,
	TRUNC(1234.5678,-1) AS TRUNC_MINUS1,
	TRUNC(1234.5678,-2) AS TRUNC_MINUS2
FROM
	DUAL;

SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL;

SELECT MOD(15,6), MOD(10,2), MOD(11,2)
FROM DUAL;


-- 날짜함수
-- 날짜 데이터 + 숫자 : 이후 날짜 반환
-- 날짜 데이터 - 숫자 : 이전 날짜 반환
-- 날짜 데이터 - 날짜데이터 : 두 날짜 데이터 간의 일수 차이 반환
-- 날짜 데이터 + 날짜데이터 : 연산불가
-- ADD_MONTHS(날짜데이터, 더할개월 수)
-- MONTHS_BETWEEN(날짜데이터1, 날짜데이터2)
-- NEXT_DAY(날짜데이터1, 요일문자)
-- LAST_DAY(날짜데이터)

-- 오라클에서 시스템 날짜 출력 : SYSDATE(주로 사용)
-- CURRENT_DATE
SELECT SYSDATE, SYSDATE + 1, SYSDATE - 1, CURRENT_DATE, CURRENT_TIMESTAMP
FROM DUAL;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3)
FROM DUAL;

-- 입사 50주년이 되는 날짜 구하기
SELECT E.HIREDATE, ADD_MONTHS(E.HIREDATE, 600) 
FROM EMP e 

-- 입사한지 40 년이 넘은 사원 조회
SELECT E.HIREDATE
FROM EMP e 
WHERE ADD_MONTHS(E.HIREDATE, 480) < SYSDATE;

SELECT
	EMPNO,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE) AS MONTH1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTH2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTH3
FROM
	EMP e; 

SELECT SYSDATE, LAST_DAY(SYSDATE), NEXT_DAY(SYSDATE, '월요일')
FROM DUAL;

-- 형변환 함수 
-- TO_CHAR() : 날짜,숫자 데이터를 문자로 변환(★)
-- TO_NUMBER() : 문자 데이터를 숫자로 변환
-- TO_DATE() : 문자 데이터를 날짜 데이터로 변환

SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY/MM/DD')
FROM DUAL;

SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'MM'),
	TO_CHAR(SYSDATE, 'MON'),
	TO_CHAR(SYSDATE, 'MONTH'),
	TO_CHAR(SYSDATE, 'DD'), 
	TO_CHAR(SYSDATE, 'DY'),	
	TO_CHAR(SYSDATE, 'DAY')	
FROM
	DUAL;


-- JAVA : YYYY:mm:dd hh:MM:ss

-- 오전,오후 표시 : AM, PM, A.M., P.M.
SELECT
	SYSDATE,
	TO_CHAR(SYSDATE, 'HH24:MI:SS'),
	TO_CHAR(SYSDATE, 'HH12:MI:SS AM'),	
	TO_CHAR(SYSDATE, 'HH:MI:SS P.M.')	
FROM
	DUAL;


-- 자동형변환
SELECT E.EMPNO, E.ENAME, e.EMPNO + '500'  
FROM EMP e
WHERE e.ENAME = 'SMITH'; 


-- SELECT E.EMPNO, E.ENAME, e.EMPNO + 'ABCD'  
-- FROM EMP e
-- WHERE e.ENAME = 'SMITH'; 

-- L : 지역화폐단위
SELECT e.SAL, to_char(e.sal, '$999,999'), to_char(e.sal, 'L999,999')
FROM EMP e; 

-- 자동형변환
SELECT 1300 - '1500', '1300' + 1500
FROM dual;

SELECT '1300' - '1500', '1300' + 1500
FROM dual;

-- 수치가 부적합합니다
SELECT '1,300' - '1500', '1300' + 1500
FROM dual;


SELECT TO_NUMBER('1,300','999,999') - TO_NUMBER('1,500','999,999'), '1300' + 1500
FROM dual;


SELECT TO_DATE('20251027','YYYY-MM-DD'),TO_DATE('20251027','YYYY/MM/DD')
FROM dual;

SELECT TO_DATE('2025-10-27') - TO_DATE('2025-09-23')
FROM DUAL;

-- null 처리 함수
-- 1. NVL(널에 해당하는 열,반환할 데이터) : 널인 경우만 반환할 데이터로 돌아옴
-- 2. NVL2(널에 해당하는 열,널이 아닐때 반환할 데이터,반환할 데이터)
-- NULL + NULL = NULL
-- 숫자 + NULL = NULL

SELECT EMPNO, ENAME, SAL,COMM, COMM + SAL FROM EMP;
SELECT EMPNO, ENAME, SAL,COMM, NVL(COMM,0) + SAL FROM EMP;

SELECT EMPNO, ENAME, SAL,COMM, NVL2(COMM,'O','X'), NVL2(COMM, SAL * 12 + COMM, SAL*12) FROM EMP;

-- DECODE, CASE 함수 : 상황에 따라 다른 데이터를 반환 
-- 직책이 MANAGER 인 사원은 급여의 10%, SALESMAN 인 사원은 급여의 5%, ANALYST 인 사원은 그대로, 나머지는 3% 만큼 인상된 급여 구하기

-- DECODE(검사 대상이 될 열 또는 데이터, 
--   [조건1], [조건1과 일치할 때 반환할 결과],
--   [조건2], [조건2와 일치할 때 반환할 결과],
--   ....
--   [위에 나열한 조건과 일치하지 않는 경우 반환할 결과]
-- )

-- CASE : 각 조건에 사용하는 데이터가 서로 상관없어도 됨
--        동등(=) 외에 다양한 조건 사용 가능
-- CASE 검사 대상이 될 열 또는 데이터
--  WHEN [조건1] THEN [조건1과 일치할 때 반환할 결과]
--  WHEN [조건2] THEN [조건2과 일치할 때 반환할 결과]
--  WHEN [조건3] THEN [조건3과 일치할 때 반환할 결과]
--  ELSE [위에 나열한 조건과 일치하지 않는 경우 반환할 결과]
-- END


SELECT
	E.EMPNO,
	E.ENAME,
	E.JOB,
	E.SAL,
	DECODE(E.JOB,
	'MANAGER', E.SAL * 1.1, 
	'SALESMAN', E.SAL * 1.05,
	'ANALYST', E.SAL,
	E.SAL * 1.03) AS 급여
FROM
	EMP e; 


SELECT
	E.EMPNO,
	E.ENAME,
	E.JOB,
	E.SAL,
	CASE E.JOB
		WHEN 'MANAGER' THEN E.SAL * 1.1
		WHEN 'SALESMAN' THEN E.SAL * 1.05
		WHEN 'ANALYST' THEN E.SAL
		ELSE E.SAL * 1.03
	END AS 급여
FROM
	EMP e;

-- COMM 이 NULL 인 경우에는 해당없음, 0 인 경우에는 수당없음, 0보다 큰 경우에는 수당 : 800

SELECT
	E.EMPNO,
	E.ENAME,
	E.COMM,
	CASE 
		WHEN E.COMM IS NULL THEN '해당없음'
		WHEN E.COMM = 0 THEN '수당없음'
		WHEN E.COMM > 0 THEN '수당 : ' || E.COMM 
	END	AS COMM_TEXT
FROM
	EMP e;


-- EMP 테이블에서 사원의 월 평균 근무일수는 21.5 일이다.
-- 하루 근무시간을 8시간으로 보았을 때 사원의 하루급여(DAY_PAY), 시급(TIME_PAY)를 계산하여 결과를 출력
-- 하루 급여는 소수 셋째 자리에서 버리고, 시급은 소수 둘째 자리에서 반올림
SELECT
	e.EMPNO,
	E.ENAME,
	E.SAL,
	TRUNC(E.SAL / 21.5, 2) AS DAY_PAY,
	ROUND(E.SAL / 21.5 / 8, 1) AS TIME_PAY
FROM
	EMP e; 


-- EMP 테이블에서 사원은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다. 사원이 정직원이 되는 날짜(R_JOB)을
-- YYYY-MM-DD 형식으로 출력. 단, 추가수당이 없는 사원의 추가 수당은 N/A 로 출력
-- EMPNO, ENAME, HIREDATE, R_JOB, COMM 출력

SELECT
	e.EMPNO,
	E.ENAME,
	E.HIREDATE,	
	TO_CHAR(NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	NVL(TO_CHAR(E.COMM), 'N/A') AS COMM
FROM
	EMP e;

-- COMM 타입이 NUMBER 이기 때문에 0 이나 '0' 은 상관없음
SELECT NVL(TO_CHAR(E.COMM), 'N/A')
FROM EMP e;

SELECT NVL(E.COMM, 'N/A')
FROM EMP e;

SELECT
	e.EMPNO,
	E.ENAME,
	E.HIREDATE,	
	TO_CHAR(NEXT_DAY(ADD_MONTHS(E.HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	CASE 
		WHEN E.COMM IS NULL THEN 'N/A'
		WHEN E.COMM IS NOT NULL THEN TO_CHAR(E.COMM)		
	END AS COMM	
FROM
	EMP e;


-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원번호(MGR)을 아래의 조건을 기준으로 변환해서 CHG_MGR 열에 출력
-- 조건
-- 직속 상관의 번호가 없는 경우 0000
-- 직속 상관의 사원번호 앞 두자리가 75 일때 5555
-- 직속 상관의 사원번호 앞 두자리가 76 일때 6666
-- 직속 상관의 사원번호 앞 두자리가 77 일때 7777
-- 직속 상관의 사원번호 앞 두자리가 78 일때 8888
-- 그 외 직속상관 사원 번호일 때 : 본래 직속상관의 사원번호 그대로 출력

SELECT e.EMPNO,
	E.ENAME,
	E.HIREDATE,	
	e.mgr,
	CASE SUBSTR(to_char(NVL(e.mgr, 0)), 1, 2)
		WHEN '0' THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE to_char(e.mgr)
	END AS CHG_MGR	
FROM EMP e;


SELECT e.EMPNO,
	E.ENAME,
	E.HIREDATE,	
	e.mgr,
	CASE 
		WHEN MGR IS NULL THEN '0000'
		WHEN MGR LIKE '75%' THEN '5555'
		WHEN MGR LIKE '76%' THEN '6666'
		WHEN MGR LIKE '77%' THEN '7777'
		WHEN MGR LIKE '78%' THEN '8888'
		ELSE to_char(e.mgr)
	END AS CHG_MGR	
FROM EMP e;


SELECT e.EMPNO,
	E.ENAME,
	E.HIREDATE,	
	e.mgr,
	decode( SUBSTR(to_char(e.mgr), 1, 2),
		NULL, '0000',
	 	'75', '5555',
	 	'76', '6666',
	 	'77', '7777',
	 	'78', '8888',
		SUBSTR(to_char(e.mgr), 1)
	) AS CHG_MGR	
FROM EMP e;


-- 다중행 함수 : null 제외
-- SUM(), AVG(), COUNT(), MAX(), MIN()

SELECT SUM(E.SAL), AVG(E.SAL), MAX(E.SAL), MIN(E.SAL), COUNT(E.SAL)
FROM EMP e ;


SELECT SUM(DISTINCT E.SAL), AVG(E.SAL), MAX(E.SAL), MIN(E.SAL), COUNT(*)
FROM EMP e ;

-- 단일 그룹의 그룹 함수가 아닙니다
-- SELECT SUM(E.SAL), e.ENAME 
-- FROM EMP e ;


-- 10번 부서의 급여총계, 평균 구하기
SELECT SUM(E.SAL), AVG(E.SAL)
FROM EMP e
WHERE E.DEPTNO = 10;


-- 20번 부서의 제일 오래된 입사일 구하기
SELECT MIN(E.HIREDATE) 
FROM EMP e
WHERE E.DEPTNO = 20;

-- 20번 부서의 제일 최신 입사일 구하기
SELECT MAX(E.HIREDATE) 
FROM EMP e
WHERE E.DEPTNO = 20;


-- GROUP BY : 결괏값을 원하는 열로 묶어 출력
-- 부서별 급여평균 조회
-- 다중행 함수 옆에 올 수 있는 컬럼은 GROUP BY 에 사용한 컬럼만 가능
SELECT E.DEPTNO, AVG(E.SAL)
FROM EMP e
GROUP BY E.DEPTNO; 

-- 부서별, 직무별 급여 평균 조회
SELECT
	E.DEPTNO,
	e.JOB,
	AVG(E.SAL)
FROM
	EMP e
GROUP BY
	E.DEPTNO,
	e.JOB
ORDER BY e.DEPTNO, e.JOB; 

-- 부서별 추가수당 평균 조회
SELECT E.DEPTNO, AVG(NVL(E.COMM,0))
FROM EMP e
GROUP BY E.DEPTNO;

-- GROUP BY 열이름 HAVING 출력그룹제한
-- 부서별, 직무별 급여 평균 조회(단, 평균이 2000 이상 그룹 조회)
--SELECT
--	E.DEPTNO,
--	e.JOB,
--	AVG(E.SAL)
--FROM
--	EMP e
--WHERE AVG(E.SAL) >= 2000 그룹 함수는 허가되지 않습니다
--GROUP BY
--	E.DEPTNO,
--	e.JOB
--ORDER BY e.DEPTNO, e.JOB; 


SELECT
	E.DEPTNO,
	e.JOB,
	AVG(E.SAL)
FROM
	EMP e
GROUP BY
	E.DEPTNO,
	e.JOB
HAVING
	AVG(E.SAL) >= 2000
ORDER BY
	e.DEPTNO,
	e.JOB; 

-- WHERE 절과 HAVING 절 비교

SELECT
	E.DEPTNO,
	e.JOB,
	AVG(E.SAL)
FROM
	EMP e
WHERE
	e.SAL <= 3000
GROUP BY
	E.DEPTNO,
	e.JOB
HAVING
	AVG(E.SAL) >= 2000
ORDER BY
	e.DEPTNO,
	e.JOB; 

-- emp 테이블을 이용하여 부서번호, 평균급여(avg_sal), 최고급여(max_sal), 최저급여(min_sal), 사원수(cnt) 조회
-- 단, 평균급여 출력 시 소수점을 제외하고 각 부서번호별로 출력

SELECT
	E.DEPTNO,
	FLOOR(AVG(e.SAL)) AS avg_sal,
	MAX(e.SAL) AS MAX_SAL,
	MIN(e.SAL) AS MIN_SAL,
	COUNT(*) AS CNT
FROM
	EMP e
GROUP BY
	E.DEPTNO
ORDER BY E.DEPTNO; 

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력

SELECT
	E.JOB,
	COUNT(E.EMPNO) AS CNT
FROM
	EMP e
GROUP BY
	E.JOB
HAVING COUNT(E.EMPNO) >= 3;
	
-- 사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력
-- to_char(1981-09-28,'YYYY') 

SELECT
	e.deptno, TO_CHAR(E.HIREDATE,'YYYY'), COUNT(*) AS cnt
FROM
	EMP e
GROUP BY
	TO_CHAR(E.HIREDATE,'YYYY'), e.DEPTNO;  

-- 조회 : join / subquery
-- join : 여러 테이블을 하나의 테이블처럼 사용
-- 1. 내부조인(INNER JOIN)
-- 2. 외부조인(OUTER JOIN)
--    (1) LEFT OUTER JOIN
--    (2) RIGHT OUTER JOIN
--    (3) FULL OUTER JOIN : left join union right join

-- 사원정보 + 부서정보 조회
-- 내부조인 + 등가조인
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO,
	d.DNAME
FROM
	EMP e
INNER JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO; 

-- 열의 정의가 애매합니다
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	DEPTNO,
	d.DNAME
FROM
	EMP e
INNER JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO;


SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	e.DEPTNO,
	d.DNAME
FROM
	EMP e,
	DEPT d
WHERE
	e.DEPTNO = d.DEPTNO
	AND e.SAL >= 2000;
 
-- 비등가 조인 + 내부조인

SELECT *
FROM EMP e JOIN SALGRADE s ON e.sal BETWEEN s.LOSAL AND s.HISAL; 


-- 셀프조인

SELECT
	e1.EMPNO,
	e1.ename,
	e1.mgr,
	e2.ENAME AS 매니저명
FROM
	EMP e1
JOIN EMP e2 ON
	e1.MGR = e2.EMPNO; 

-- 외부조인
SELECT
	e1.EMPNO,
	e1.ename,
	e1.mgr,
	e2.ENAME AS 매니저명
FROM
	EMP e1
LEFT JOIN EMP e2 ON
	e1.MGR = e2.EMPNO;


SELECT
	e1.EMPNO,
	e1.ename,
	e1.mgr,
	e2.ENAME AS 매니저명
FROM
	EMP e1
RIGHT JOIN EMP e2 ON
	e1.MGR = e2.EMPNO;

-- + 부서명 조회
-- GROUP BY 표현식이 아닙니다.
SELECT
	E.DEPTNO,
	d.DNAME, 
	FLOOR(AVG(e.SAL)) AS avg_sal,
	MAX(e.SAL) AS MAX_SAL,
	MIN(e.SAL) AS MIN_SAL,
	COUNT(*) AS CNT
FROM
	EMP e
JOIN DEPT d ON
	e.deptno = d.DEPTNO
GROUP BY
	E.DEPTNO, d.DNAME 
ORDER BY
	E.DEPTNO; 

-- table 3개 연동
-- 부서번호,부서명, 사번, 사원명, 매니저번호, 급여, 급여등급
-- 부서명 : dept
-- 사번, 사원명, 매니저번호, 급여, 부서번호 : emp
-- 급여등급 : salgrade


SELECT
	e.DEPTNO,
	d.DNAME,
	e.EMPNO,
	e.ENAME,
	e.MGR,
	e.SAL,
	s.GRADE
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
JOIN SALGRADE s ON
	e.sal BETWEEN s.LOSAL AND s.HISAL; 

-- 서브쿼리 : 메인쿼리 외에 select 구문이 여러개 존재
--            괄호안에 작성
-- 1) 단일행 서브쿼리 : 서브쿼리 실행 결과가 행 하나
--      ㄴ 연산자 종류 : >, <, >=, <=, <>, !=, ^=, =
-- 2) 다중행 서브쿼리 : 서브쿼리 실행 결과가 여러 행
--      ㄴ 연산자 종류 : IN, ANY(= SOME), ALL, EXIST
--    in : 서브쿼리 결과 중 하나라도 일치한 데이터가 있다면 true 반환
--    any, some : 서브쿼리 결과가 하나 이상이면 true 반환
--    all : 서브쿼리 결과가 모두 만족하면 true 반환
--    exists : 서브쿼리 결과가 있으면 true 반환

--SELECT e.ENAME, (SELECT * FROM EMP e2) 
--FROM EMP e JOIN (SELECT ) 
--WHERE e.DEPTNO = (SELECT )

-- JONES 의 급여보다 높은 급여를 받는 사원 데이터 조회

SELECT
	*
FROM
	EMP e
WHERE
	E.SAL > (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.ENAME = 'JONES');

-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다.
SELECT
	*
FROM
	EMP e
WHERE
	E.SAL > (
	SELECT
		e2.SAL
	FROM
		EMP e2
	WHERE
		e2.JOB = 'MANAGER');

-- WARD 사원보다 빨리 입사한 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	E.HIREDATE < (
	SELECT
		e2.HIREDATE 
	FROM
		EMP e2
	WHERE
		e2.ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원 조회
-- 부서정보 추가로 조회
SELECT
	E.EMPNO,
	E.ENAME,
	E.JOB,
	D.DEPTNO,
	D.DNAME,
	D.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = D.DEPTNO
WHERE e.DEPTNO = 20 AND E.SAL > (SELECT AVG(e2.SAL) FROM EMP e2); 


SELECT * FROM EMP e WHERE e.SAL IN (SELECT max(e2.sal) FROM EMP e2 GROUP BY e2.DEPTNO);

-- = any(some) => in 사용 
SELECT * FROM EMP e WHERE e.SAL = any (SELECT max(e2.sal) FROM EMP e2 GROUP BY e2.DEPTNO);
SELECT * FROM EMP e WHERE e.SAL = some (SELECT max(e2.sal) FROM EMP e2 GROUP BY e2.DEPTNO);

-- 30번 부서의 최대 급여보다 작은 급여를 받는 사원 조회
-- < any
SELECT * FROM EMP e WHERE e.SAL < any (SELECT sal FROM EMP e2 WHERE e2.DEPTNO = 30);

-- 30번 부서의 최소 급여보다 많은 급여를 받는 사원 조회
SELECT * FROM EMP e WHERE e.SAL > any (SELECT sal FROM EMP e2 WHERE e2.DEPTNO = 30);

-- 30번 부서의 최소 급여보다 더 적은 급여를 받는 사원 조회
SELECT * FROM EMP e WHERE e.SAL < all (SELECT sal FROM EMP e2 WHERE e2.DEPTNO = 30);

-- 30번 부서의 최대 급여보다 더 많은 급여를 받는 사원 조회
SELECT * FROM EMP e WHERE e.SAL > all (SELECT sal FROM EMP e2 WHERE e2.DEPTNO = 30);

-- 서브쿼리 결과가 하나이상 나오면 true 반환
SELECT * FROM EMP e WHERE EXISTS (SELECT dname FROM DEPT d WHERE d.DEPTNO = 70);

-- 다중열 서브쿼리
SELECT
	*
FROM
	EMP e
WHERE
	(e.DEPTNO,
	e.SAL) IN (
	SELECT
		e2.DEPTNO,
		max(e2.sal)
	FROM
		EMP e2
	GROUP BY
		e2.DEPTNO);


-- from 절 서브쿼리(= 인라인 뷰)
SELECT
	e10.*,
	d.*
FROM
	(
	SELECT
		*
	FROM
		EMP e
	WHERE
		e.DEPTNO = 10) e10,
	(
	SELECT
		*
	FROM
		DEPT) d
WHERE
	e10.DEPTNO = d.DEPTNO; 

-- select 절 서브쿼리(= 스칼라 서브쿼리)
SELECT
	e.EMPNO,
	e.ENAME,
	e.JOB,
	(
	SELECT
		s.GRADE
	FROM
		SALGRADE s
	WHERE
		e.sal BETWEEN s.LOSAL AND s.HISAL) AS salgrade,
	e.DEPTNO,
	(SELECT d.DNAME FROM DEPT d WHERE e.DEPTNO = d.DEPTNO) AS dname
FROM
	EMP e;


-- 전체 사원 중 ALLEN 과 같은 직책인 사원들의 사원정보, 부서정보 조회
-- 정보 : 사번,이름,직무,급여,부서번호,부서명
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME      
FROM EMP e JOIN DEPT d ON E.DEPTNO = D.DEPTNO 
WHERE e.JOB = (SELECT e2.JOB FROM EMP e2 WHERE e2.ENAME = 'ALLEN')

-- 자신의 부서 내에서 최고 연봉과 동일한 급여를 받는 사원 조회
SELECT * FROM EMP e WHERE (e.DEPTNO, e.SAL) IN (SELECT e2.DEPTNO,max(e2.sal) FROM EMP e2 GROUP BY e2.DEPTNO);

-- 10번 부서에 근무하는 사원 중 30번 부서에 없는 직책인 사원의 사번,이름,직무,부서번호,부서명,부서위치 조회
SELECT
	E.EMPNO,
	E.ENAME,
	E.JOB,
	D.DEPTNO,
	D.DNAME,
	D.LOC
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
WHERE
	E.DEPTNO = 10
	AND E.JOB NOT IN (
	SELECT
		E2.JOB
	FROM
		EMP e2
	WHERE
		E2.DEPTNO = 30);


-- insert : 테이블에 데이터 추가
-- INSERT INTO 테이블명(열이름1, 열이름2) VALUES(값1, 값2...) 
-- 열이름 생략 가능한데 단, 모든 열의 값이 지정되어야 함


-- 연습용 테이블 생성
CREATE TABLE dept_temp AS SELECT * FROM dept; -- 구조 + 데이터 복사
CREATE TABLE EMP_temp AS SELECT * FROM EMP WHERE 1<>1; -- 구조만 복사

SELECT * FROM dept_temp;
SELECT * FROM EMP_TEMP; 

-- 50, DATABASE, SEOUL 삽입
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES (50, 'DATABASE', 'SEOUL'); 

INSERT INTO DEPT_TEMP VALUES (60, 'NETWORK', 'BUSAN'); 

-- 값의 수가 충분하지 않습니다
-- INSERT INTO DEPT_TEMP VALUES (60, 'NETWORK'); 

-- 값으로 NULL 명시적으로 삽입이 가능
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES (70, 'WEB', NULL);
INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC) VALUES (80, 'MOBILE', '');
-- NULL 암시적 처리
INSERT INTO DEPT_TEMP(DEPTNO, DNAME) VALUES (90, 'OS');


SELECT * FROM EMP_TEMP; 
INSERT INTO emp_temp(empno, ENAME, JOB,MGR, HIREDATE,SAL,COMM,DEPTNO) 
VALUES(1111,'성춘향','MANAGER',9999,'2010/10/25',4000,NULL,20); 

INSERT INTO emp_temp(empno, ENAME, JOB,MGR, HIREDATE,SAL,COMM,DEPTNO) 
VALUES(9999,'홍길동','PRESIDENT',NULL,'2000-01-25',8000,1000,10);

INSERT INTO emp_temp(empno, ENAME, JOB,MGR, HIREDATE,SAL,COMM,DEPTNO) 
VALUES(2222,'김수호','MANAGER',9999,SYSDATE,4000,NULL,30);

-- EMP 테이블에서 SALGRADE 가 1인 사원만 EMP_TEMP 삽입

INSERT
	INTO
	emp_temp(empno, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT
	e.empno,
	e.ENAME,
	e.job,
	e.MGR,
	e.HIREDATE,
	e.SAL,
	e.COMM,
	e.DEPTNO
FROM
	EMP e
JOIN SALGRADE s ON
	e.sal BETWEEN s.LOSAL AND s.HISAL
	AND s.GRADE = 1; 


-- update
-- UPDATE 테이블명
-- SET 열이름 = 수정할값, 열이름2 = 수정할값
-- WHERE 수정할조건
SELECT * FROM DEPT_TEMP dt;
SELECT * FROM EMP_TEMP et; 

-- 10번 부서의 위치 SEOUL 변경
UPDATE DEPT_TEMP dt 
SET dt.LOC = 'SEOUL'
WHERE dt.DEPTNO = 10;


-- emp_temp 테이블의 사원 중에서 sal 이 2500 이하인 사원만 추가수당을 50 으로 수정
UPDATE EMP_TEMP et  
SET et.comm = 50
WHERE et.sal <= 2500;

-- dept 테이블의 40번 부서의 dname,loc 정보를 가져와서 dept_temp 40번부서의 내용으로 변경

UPDATE DEPT_TEMP dt 
SET (dt.dname, dt.LOC) = (SELECT d.DNAME, d.LOC FROM DEPT d WHERE d.DEPTNO = 40)
WHERE dt.DEPTNO = 40;


UPDATE DEPT_TEMP dt 
SET LOC = 'BUSAN';

-- DELETE : 데이터 삭제
-- DELETE FROM 테이블명 WHERE 삭제할조건
-- DELETE 테이블명 WHERE 삭제할조건

CREATE TABLE EMP_temp2 AS SELECT * FROM EMP;

SELECT * FROM EMP_TEMP2 et;

-- 7902 사원 삭제
DELETE FROM EMP_TEMP2 WHERE EMPNO = 7902;

DELETE EMP_TEMP2 WHERE EMPNO = 7844;

-- 데이터 전체 삭제
DELETE FROM EMP_TEMP2; 

-- EMP 테이블을 복사하여 EXAM_EMP 테이블 생성
-- DEPT 테이블을 복사하여 EXAM_DEPT 테이블 생성
-- SALGRADE 테이블을 복사하여 EXAM_SALGRADE 테이블 생성

CREATE TABLE EXAM_EMP AS SELECT * FROM EMP;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE;

-- EXAM_DEPT 테이블에 50,60,70,80번 부서를 등록하는 SQL 구문 작성
-- 50, ORACLE, BUSAN
-- 60, SQL, ILSAN
-- 70, SELECT, INCHEON
-- 80, DML, BUNDANG
INSERT INTO EXAM_DEPT VALUES(50, 'ORACLE', 'BUSAN'); 
INSERT INTO EXAM_DEPT VALUES(60, 'SQL', 'ILSAN'); 
INSERT INTO EXAM_DEPT VALUES(70, 'SELECT', 'INCHEON'); 
INSERT INTO EXAM_DEPT VALUES(80, 'DML', 'BUNDANG'); 


-- EXAM_EMP 테이블에 8명의 사원정보를 등록하는 SQL 구문 작성
-- 8명은 임의의 값(부서번호는 50~80번 사이로 지정) 
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,50);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7202,'TEST_USER2','CLERK',7201,'2016-02-21',1800,NULL,50);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7203,'TEST_USER3','ANALYST',7201,'2016-04-11',3400,NULL,60);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7204,'TEST_USER4','SALESMAN',7201,'2016-05-31',2700,300,60);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7205,'TEST_USER5','CLERK',7201,'2016-07-20',2600,NULL,70);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7206,'TEST_USER6','CLERK',7201,'2016-09-08',2600,NULL,70);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7207,'TEST_USER7','LECTURER',7201,'2016-10-28',2300,NULL,80);
INSERT INTO EXAM_EMP(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7208,'TEST_USER8','STUDENT',7201,'2018-03-09',1200,NULL,80);


-- EXAM_EMP 에서 50번 부서에 근무하는 사원의 평균 급여보다 많이 받는 사원을 70번 부서로 옮기는 SQL 구문 작성

UPDATE EXAM_EMP ee 
SET EE.DEPTNO = 70
WHERE ee.SAL > (SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO = 50);

-- EXAM_EMP 에 속한 사원 중 입사일이 가장 빠른 60번 부서 사원보다 늦게 입사한 사원의 급여를 10% 인상하고
-- 80번 부서로 옮기는 SQL 구분 작성

UPDATE EXAM_EMP ee 
SET EE.SAL = EE.SAL * 1.1, EE.DEPTNO = 80
WHERE ee.HIREDATE > (SELECT MIN(EE2.HIREDATE) FROM EXAM_EMP ee2 WHERE ee2.DEPTNO = 60);

-- EXAM_EMP 에 속한 사원 중 급여 등급이 5인 사원을 삭제하는 SQL 구문 작성
-- 조인 시 EXAM_SALGRADE 테이블 사용

DELETE
FROM
	EXAM_EMP
WHERE
	EMPNO IN (
	SELECT
		ee.EMPNO
	FROM
		EXAM_EMP ee
	JOIN EXAM_SALGRADE es ON
		EE.SAL BETWEEN ES.LOSAL AND ES.HISAL
		AND ES.GRADE = 5);

-- DML : INSERT, UPDATE, DELETE => 데이터 변경이 일어나는 작업 
-- 트랜잭션 : 하나의 단위로 데이터 처리
-- ROLLBACK; 되돌리기
-- COMMIT; 데이터베이스 반영

CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
SELECT * FROM DEPT_TCL;

-- 트랜잭션 시작
INSERT INTO DEPT_TCL VALUES(50,'DATABASE','SEOUL');

UPDATE DEPT_TCL dt SET LOC = 'BUSAN' WHERE DEPTNO = 40;

DELETE FROM DEPT_TCL WHERE DNAME = 'RESEARCH';
-- 트랜잭션 종료

SELECT * FROM DEPT_TCL;

ROLLBACK;

COMMIT; 

-- 트랜잭션시작


-- 세션 : 데이터베이스 접속을 시작으로 작업을 수행한 후 접속을 종료하기까지 전체 기간을 의미

SELECT * FROM DEPT_TCL;

DELETE
FROM
	DEPT_TCL
WHERE
	deptno = 50;

COMMIT;


-- 트랜잭션 시작
UPDATE
	DEPT_TCL dt
SET
	LOC = 'SEOUL'
WHERE
	DEPTNO = 30;

SELECT * FROM DEPT_TCL;

COMMIT;

-- 데이터 정의어(DDL)
-- 객체를 생성(CREATE), 변경(ALTER), 삭제(DROP)하는 명령어

-- 1) 테이블 생성

-- CREATE TABLE 테이블명(
--	열이름1 타입(20),
--	열이름2 타입(20),
-- )

-- 타입
-- 문자 :  CHAR / NCHAR / VARCHAR2 / NVARCHAR2
--         CHAR (고정크기) / VARCHAR (가변크기)
--         char(10) : abc => 10 자리를 그대로 사용
--         varchar2(10) : abc => 3 자리를 사용
--         varchar2(10) : 안녕하세요 입력불가
--         nvarchar2(10) : 안녕하세요 입력 가능
-- 숫자 : number(7,2) : 소수 둘째 자리를 포함해서 총 7자리 숫자 지정 가능
-- 날짜 : date

-- 테이블명 : 문자로 시작, 특수문자(_, $, #), 숫자 가능 / 예약어(select, order, from...) 는 사용안됨
-- 열명 : 문자로 시작, 특수문자(_, $, #), 숫자 가능 / 예약어(select, order, from...) 는 사용안됨


-- 테이블 생성
-- 1. 기존 테이블 구조 이용
-- CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT;
-- CREATE TABLE DEPT_TCL AS SELECT * FROM DEPT WHERE 1<>1;

-- 2. 자료형을 정의하여 새 테이블 생성
CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2)
);

-- 테이블 변경 : ALTER
-- 1. 열 추가 : ADD
-- 2. 열 이름 변경 : RENAME COLUMN
-- 3. 열 자료형 변경 : MODIFY
-- 4. 열 삭제 : DROP COLUMN

-- 테이블 이름 변경 : RENAME 변경전테이블명 TO 변경후테이블명

-- HP 열 추가
ALTER TABLE EMP_DDL ADD HP VARCHAR2(20);

-- HP => TEL 이름변경
ALTER TABLE EMP_DDL RENAME COLUMN HP TO TEL;

-- EMPNO(4) => 5 변경
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

-- TEL 컬럼 제거
ALTER TABLE EMP_DDL DROP COLUMN TEL;

SELECT * FROM EMP_DDL ed; 

-- 테이블이름 변경
RENAME EMP_DDL TO EMP_RENAME;

-- 테이블 삭제
-- DROP
DROP TABLE EMP_RENAME;


-- MEMBER 테이블 생성
-- ID 가변형문자열 15
-- PASSWORD 가변형문자열 20
-- NAME 가변형문자열 10
-- TEL 가변형문자열 15
-- EMAIL 가변형문자열 20
-- AGE 숫자 4
CREATE TABLE MEMBER(
	ID VARCHAR2(15),
	PASSWORD VARCHAR2(20),
	NAME VARCHAR2(10),
	TEL VARCHAR2(15),
	EMAIL VARCHAR2(20),
	AGE NUMBER(4)
);

-- BIGO 열 추가(가변형 문자열 10)
ALTER TABLE MEMBER ADD BIGO VARCHAR2(10);

-- BIGO 열 크기 변경 30
ALTER TABLE MEMBER MODIFY BIGO VARCHAR2(30);

-- BIGO 열 이름을 REMARK 로 변경
ALTER TABLE MEMBER RENAME COLUMN BIGO TO REMARK;

-- 인덱스 : 테이블 검색 성능 향상
-- SQL 튜닝 관련된 개념
-- 인덱스 사용 여부
-- 1) 테이블 풀 스캔 : 처음부터 끝까지 검색
-- 2) 인덱스 스캔 : 인덱스 사용한 검색
SELECT * FROM EMP WHERE EMPNO = 7844;

-- 인덱스 생성
-- CREATE INDEX 인덱스명 ON 테이블명(컬럼명)
CREATE INDEX IDX_EMP_SAL ON EMP(SAL);

-- 인덱스 삭제
-- DROP INDEX 인덱스명;
DROP INDEX IDX_EMP_SAL;

-- 뷰 : 가상테이블
--      하나 이상의 테이블을 조회하는 SELECT문을 저장한 객체
-- 1. 보안성
-- 2. 편리성 : SQL 구문의 복잡도 완화

-- CREATE VIEW 뷰이름(열이름1, 열이름2....) AS (저장할 SELECT문) WITH CHECK OPTION 제약조건 WITH READ ONLY 제약조건
CREATE VIEW VW_EMP20 AS (SELECT EMPNO, ENAME,JOB, DEPTNO FROM EMP WHERE DEPTNO = 20);
CREATE VIEW VW_EMP_READ AS SELECT EMPNO, ENAME,JOB, DEPTNO FROM EMP WITH READ ONLY;

-- DROP VIEW 뷰이름;

INSERT INTO VW_EMP20 VALUES(7777,'홍길동','SALESMAN',10);
SELECT * FROM VW_EMP20 ve;
SELECT * FROM EMP;

-- USER_ : 현재 데이터베이스에 접속한 사용자가 소유한 객체 정보
SELECT TABLE_NAME FROM USER_TABLES;

SELECT * FROM USER_UPDATABLE_COLUMNS WHERE TABLE_NAME='VM_EMP20';

-- 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
INSERT INTO VW_EMP_READ VALUES(7777,'홍길동','SALESMAN',10);

DROP VIEW VW_EMP20;
DROP VIEW VW_EMP_READ; 


-- 시퀀스 (MySQL limit)
-- 오라클데이터베이스에서 특정 규칙에 따른 연속 숫자를 생성하는 객체

-- CREATE SEQUENCE 시퀀스명;

-- CREATE SEQUENCE 시퀀스명
-- INCREMENT BY N (기본값은 1)
-- START WITH N (기본값은 1)
-- MAXVALUE N | NOMAXVALUE 
-- MINVALUE N | NOMINVALUE
-- CYCLE | NOCYCLE
-- CACHE N | NOCACHE

CREATE SEQUENCE SEQ_DEPT_SEQUENCE;

CREATE SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 10
START WITH 10
MAXVALUE 90
MINVALUE 0
NOCYCLE
CACHE 2;


DROP SEQUENCE SEQ_DEPT_SEQUENCE;

ALTER SEQUENCE SEQ_DEPT_SEQUENCE 
INCREMENT BY 3
MAXVALUE 99
CYCLE;

CREATE TABLE DEPT_SEQUENCE AS SELECT * FROM DEPT WHERE 1 <> 1;

INSERT INTO DEPT_SEQUENCE VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
INSERT INTO DEPT_SEQUENCE VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL, 'NETWORK', 'BUSAN');
DELETE FROM DEPT_SEQUENCE;

SELECT * FROM DEPT_SEQUENCE;

-- SEQ_DEPT_SEQUENCE.CURRVAL : 현재 시퀀스 값 조회

SELECT SEQ_DEPT_SEQUENCE.CURRVAL FROM dual;

-- 동의어 : synonym (별칭)
-- 테이블, 뷰, 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름 부여

-- EMP 테이블 별칭 E 로 지정
CREATE synonym e FOR emp;

SELECT * FROM E;

DROP SYNONYM E;

-- 제약조건( 데이터 무결성 유지 )
-- 1. 빈 값을 허용하지 않는 NOT NULL
-- 2. 중복값을 허용하지 않는 UNIQUE
-- 3. 유일하게 하나만 존재하는 PRIMARY KEY
-- 4. 다른 테이블과 관계를 맺는 FOREIGN KEY
-- 5. 설정한 조건식을 만족하는 데이터 확인 CHECK 
-- 6. 기본값을 지정하는 DEFAULT

-- 데이터 무결성 : 데이터 정확성과 일관성 보장

-- NOT NULL
-- 1. 테이블 생성 시
CREATE TABLE TABLE_NOTNULL(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

-- INSERT
INSERT INTO TABLE_NOTNULL VALUES('test01','test01','010-1234-5678');

-- NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
INSERT INTO TABLE_NOTNULL VALUES('test01','test01',null);

-- NULL로 ("SCOTT"."TABLE_NOTNULL"."LOGIN_ID")을 업데이트할 수 없습니다
UPDATE TABLE_NOTNULL SET LOGIN_ID = NULL WHERE TEL = '010-1234-5678';

DELETE FROM TABLE_NOTNULL WHERE LOGIN_ID = 'test01';

DROP TABLE TABLE_NOTNULL; 

-- 제약조건 이름 지정
CREATE TABLE TABLE_NOTNULL(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBLNN_LGNID_NN  NOT NULL,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLNN_LGNPWD_NN NOT NULL,
	TEL VARCHAR2(20)
);

-- TEL 제약조건 추가
ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL);

-- TEL 제약조건 추가(이름 지정)
ALTER TABLE TABLE_NOTNULL MODIFY(TEL CONSTRAINT TBLNN_TEL_NN NOT NULL);

-- 제약조건 이름 변경
ALTER TABLE TABLE_NOTNULL RENAME CONSTRAINT SYS_C008390 TO TBLNN_TEL_NN;

-- 제약조건 삭제
ALTER TABLE TABLE_NOTNULL DROP CONSTRAINT TBLNN_TEL_NN;


-- 2. UNIQUE

CREATE TABLE TABLE_UNIQUE(
	LOGIN_ID VARCHAR2(20) UNIQUE,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_UNIQUE VALUES('test01','test01','010-1234-5678');
-- 무결성 제약 조건(SCOTT.SYS_C008392)에 위배됩니다
INSERT INTO TABLE_UNIQUE VALUES('test01','test02','010-1234-7869');

-- NULL 값은 중복의 의미를 부여하지 않음
INSERT INTO TABLE_UNIQUE VALUES(NULL,'test02','010-1234-7869');

INSERT INTO TABLE_UNIQUE VALUES('test02','test02','010-1234-7869');
-- 무결성 제약 조건(SCOTT.SYS_C008392)에 위배됩니다
UPDATE TABLE_UNIQUE tu SET TU.LOGIN_ID = 'test01';

DROP TABLE TABLE_UNIQUE;


-- UNIQUE 제약조건 이름 지정
CREATE TABLE TABLE_UNIQUE(
	LOGIN_ID VARCHAR2(20) CONSTRAINT TBL_LGNID_UNQ UNIQUE,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBL_LGNPWD_UNQ NOT NULL,
	TEL VARCHAR2(20)
);

-- TEL UNIQUE 제약조건 추가
ALTER TABLE TABLE_UNIQUE MODIFY(TEL CONSTRAINT TBL_TEL_UNQ UNIQUE);

-- 3. PRIMARY KEY(기본키)
-- UNIQUE + NOT NULL
CREATE TABLE TABLE_PK(
	LOGIN_ID VARCHAR2(20) PRIMARY KEY,
	LOGIN_PWD VARCHAR2(20) NOT NULL,
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_PK VALUES('test01','test01','010-1234-7869');

-- 무결성 제약 조건(SCOTT.SYS_C008397)에 위배됩니다
INSERT INTO TABLE_PK VALUES('test01','test01','010-1234-7869');

-- NULL을 ("SCOTT"."TABLE_PK"."LOGIN_ID") 안에 삽입할 수 없습니다
INSERT INTO TABLE_PK VALUES(NULL,'test01','010-1234-7869');

-- WHERE PK컬럼 = 1;

-- 4. FOREIGN KEY(외래키)
-- 다른 테이블과 관계를 맺을 때


CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);


CREATE TABLE EMP_FK(
	EMPNO NUMBER(4),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) REFERENCES DEPT_FK(DEPTNO)
);

-- 무결성 제약조건(SCOTT.SYS_C008399)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO EMP_FK(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,50);

-- 입력 시 부모 테이블 데이터 먼저 입력 후 자식 테이블 데이터 입력
INSERT INTO DEPT_FK VALUES(10, 'DATABASE', 'SEOUL');
INSERT INTO EMP_FK(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,10);

-- 수정 시
-- 무결성 제약조건(SCOTT.SYS_C008399)이 위배되었습니다- 부모 키가 없습니다
UPDATE EMP_FK
SET DEPTNO = 20
WHERE EMPNO = 7201;


-- 삭제 시
-- 자식 레코드 존재시 부모 삭제 불가
-- 1) 자식 레코드 먼저 삭제 2) 부모 레코드 삭제
-- 무결성 제약조건(SCOTT.SYS_C008399)이 위배되었습니다- 자식 레코드가 발견되었습니다
DELETE FROM DEPT_FK WHERE DEPTNO = 10;


DELETE FROM EMP_FK WHERE EMPNO = 7201;
DELETE FROM DEPT_FK WHERE DEPTNO = 10;


DROP TABLE DEPT_FK;
DROP TABLE EMP_FK;

-- 제약조건명 + 부모 데이터 삭제 시 자식 데이터 처리 방법 지정
-- 1) ON DELETE CASCADE : 부모 데이터 삭제 시 참조하는 데이터도 함께 삭제
-- 2) ON DELETE SET NULL : 부모 데이터 삭제 시 참조하는 데이터에 NULL 설정
CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);


CREATE TABLE EMP_FK(
	EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO) ON DELETE SET NULL
);

INSERT INTO DEPT_FK VALUES(10, 'DATABASE', 'SEOUL');
INSERT INTO EMP_FK(EMPNO,ENAME,JOB,MGR,HIREDATE,SAL,COMM,DEPTNO)
VALUES(7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,10);


DELETE FROM DEPT_FK WHERE DEPTNO = 10;


--------------------
-- 외래키 제약조건을 따로 지정
DROP TABLE DEPT_FK;
DROP TABLE EMP_FK; 

CREATE TABLE DEPT_FK(
	DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
	DNAME VARCHAR2(14),
	LOC VARCHAR2(13)
);


CREATE TABLE EMP_FK(
	EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2)
);

ALTER TABLE EMP_FK ADD FOREIGN KEY (DEPTNO) REFERENCES DEPT_FK(DEPTNO); 

-- 5. CHECK

CREATE TABLE TABLE_CHECK(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD) > 3),
	TEL VARCHAR2(20)
);

-- 체크 제약조건(SCOTT.TBLCK_LOGINPW_CK)이 위배되었습니다
INSERT INTO TABLE_CHECK VALUES('test01','tes','010-1234-7869');

DROP TABLE TABLE_CHECK; 

CREATE TABLE TABLE_CHECK(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) CONSTRAINT TBLCK_LOGINPW_CK CHECK (LENGTH(LOGIN_PWD) > 3),
	AGE NUMBER(3) CONSTRAINT TBLCK_AGE_CK CHECK (AGE BETWEEN 10 AND 18),
	TEL VARCHAR2(20)
);
INSERT INTO TABLE_CHECK VALUES('test01','test',12,'010-1234-7869');

-- 6. DEFAULT
-- 값을 지정하지 않은 특정한 열에 기본값을 지정
CREATE TABLE TABLE_DEFAULT(
	LOGIN_ID VARCHAR2(20) NOT NULL,
	LOGIN_PWD VARCHAR2(20) DEFAULT '1234',	
	TEL VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT(LOGIN_ID,TEL) VALUES('test01','010-1234-7869');
INSERT INTO TABLE_DEFAULT VALUES('test02',NULL,'010-1234-7869');

SELECT * FROM TABLE_DEFAULT;


-----
-- 사용자 생성













