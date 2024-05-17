/*
제목: 데이터 기본 조회(2)
작성: 이장래
내용: 기본적인 데이터 조회 방법 학습
*/

USE hrdb2024;
SELECT DATABASE();

/*
7. 범위 조건과 리스트 조건
*/

-- 급여가 5,000~8,000 사이인 직원 정보 조회(5000과 8000도 포함)
SELECT emp_name, emp_id, dept_id, hire_date, phone, salary
	FROM employee
	WHERE salary BETWEEN 5000 AND 8000;

-- 위 쿼리의 반대(NOT 사용)    
SELECT emp_name, emp_id, dept_id, hire_date, phone, salary
	FROM employee
	WHERE salary NOT BETWEEN 5000 AND 8000;

-- SYS, MKT, GEN 부서 직원 정보 조회
SELECT emp_name, emp_id, dept_id, hire_date, phone
	FROM employee
	WHERE dept_id IN ('SYS', 'MKT', 'GEN');

-- 위 쿼리의 반대(NOT IN)    
SELECT emp_name, emp_id, dept_id, hire_date, phone
	FROM employee
	WHERE dept_id NOT IN ('SYS', 'MKT', 'GEN');
    
-- 2020년에 입사한 직원 정보 조회
SELECT emp_name, emp_id, dept_id, hire_date, phone
	FROM employee
	WHERE hire_date BETWEEN '2020-01-01' AND '2020-12-31';


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
-- Q) 2019년도에 입사한 정보시스템, 영업팀 직원 정보 조회



-- Q) 2019년도에 입사한 연봉이 6,000 이상인 근무중인 직원 정보 조회



-- Q) 홍길동(S0001), 강우동(S0003), 오삼식(S0005)의 2019년 휴가 정보 조회



-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
 
/*
8. NULL 값 비교
*/

-- 근무 중인 직원 정보 조회 (?) -> 에러발생: NULL이 날짜로 변환이 불가능한 문자열이기 때문
SELECT emp_name, emp_id, gender, dept_id, hire_date, retire_date, phone
	FROM employee
	WHERE retire_date = 'NULL';

-- 근무 중인 직원 정보 조회 (?) -> 문자열 형태('')로 쓰지 않으면 됨
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date = NULL;

-- 근무 중인 직원 정보 조회 (!)
SELECT emp_name, emp_id, gender, dept_id, hire_date, retire_date, phone
	FROM employee
	WHERE retire_date IS NULL;
    
-- 퇴사한 직원 정보 조회
-- Python: ISNA(), ISNULL()
SELECT emp_name, emp_id, gender, dept_id, hire_date, retire_date, phone
	FROM employee
	WHERE retire_date IS NOT NULL;


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
-- Q) 본부에 속하지 않은 부서 정보 조회



-- Q) 영어 이름이 없는 근무 중인 직원 정보 조회



-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --


/*
9. IFNULL() 함수
*/

-- IFNULL 함수 사용 전
SELECT emp_name, emp_id, eng_name, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL;

-- IFNULL 함수 사용: eng_name 열 값이 NULL이면 공백 표시
SELECT emp_name, emp_id, IFNULL(eng_name, ''), gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL;
-- 참고: ORACLE에서는 ''문자, 즉 빈 문자열을 NULL 값으로 취급 -> NULL = ''

-- Python dropna(): eng_name이 null이 아닌 것만 가져옴
SELECT emp_name, emp_id, IFNULL(eng_name, ''), gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL AND eng_name IS NOT NULL;

-- IFNULL 함수 결과에 별칭 사용
SELECT emp_name, emp_id, IFNULL(eng_name, '') AS eng_name, gender, dept_id, hire_date
	FROM employee
	WHERE retire_date IS NULL;
-- 참고: NULL값 처리 함수
-- MySQL: IFNULL()
-- ORACLE: NVL()
-- MSSQL: ISNULL() -> MySQL에서는 NULL이면 1, 아니면 0을 반환하는 함수

-- COALESCE() 함수 사용: 첫 번째로 NULL이 아닌 값을 반환
-- EX) COACLESCE(NULL, NULL, NULL, 10, 20) -> 10
-- IFNULL과의 차이점: IFNULL은 두 개 값만 적용 가능하고 COALESCE는 여러 개 나열 가능 
-- -> IFNULL(NULL, 10), COACLESCE(NULL, NULL, NULL, 10, 20) : 둘 다 10을 반환
SELECT emp_name, emp_id, COALESCE(eng_name, '') AS eng_name, gender, dept_id, hire_date
	FROM employee
	WHERE retire_date IS NULL;


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --

-- Q) retire_date 열 값이 NULL이면 9999-12-31로 표시해서 직원 정보 조회



-- Q) salary열 값이 NULL이면 0으로 표시해서 근무 중인 여직원 정보 조회


    
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --


/*
9. 자동 형 변환
*/

-- 자동 형 변환
SELECT '10' + '20'; -- 30 | MSSQL: '1020' / ORACLE: 30
SELECT 10 + '20'; -- 30
SELECT 10 + '20AX'; -- 30 | MSSQL: ERROR / ORACLE: 10(20AX을 0으로 취급)
SELECT 10 + 'LX20'; -- 10(10 + 0)

-- 문자열 데이터 결합
SELECT CONCAT('10', '20'); -- 1020
SELECT CONCAT(10, '20'); -- 1020
SELECT CONCAT(10, 20); -- 1020
SELECT CONCAT(10, NULL); -- NULL | ORACLE: 10

-- 참고: 문자열 결합 연산자
-- ORACLE: 'ABC || 'DEF' || 'GHI' -> 'ABCDEFGHI' 
-- * CONCAT('A', 'B', 'C') -> ERROR(두 개만 결합 가능)
-- MSSQL: 'ABC + 'DEF' + 'GHI' -> 'ABCDEFGHI'
-- * CONCAT('A', 'B', 'C') -> ABC

/*
10. 데이터 결합
*/

SELECT CONCAT(emp_name, '(', emp_id, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- 문자와 숫자 결합
SELECT CONCAT(emp_name, '(', salary, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- 문자와 날짜 결합
SELECT CONCAT(emp_name, '(', hire_date, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- NULL과 결합하면?
SELECT CONCAT(emp_name, '(', eng_name, ')') AS emp_name, dept_id, gender, hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- NULL 값 처리 #1
SELECT CONCAT(emp_name, '(', IFNULL(eng_name, ''), ')') AS emp_name, dept_id, gender, 
       hire_date, email
	FROM employee
	WHERE retire_date IS NULL;

-- NULL 값 처리 #2
SELECT CONCAT(emp_name, IFNULL(CONCAT('(', eng_name, ')'), '')) AS emp_name, dept_id, gender, 
       hire_date, email
	FROM employee
	WHERE retire_date IS NULL;
    

-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
-- Q) 사원번호와 부서코드를 묶어서(예: S0001(SYS)) 근무 중인 직원 정보 조회


 
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
  
    
/*
11. 데이터 정렬
*/

-- 오름차순: 1, 2, 3, 4 (ASC)
-- 내림차순: 4, 3, 2, 1 (DESC)

-- 이름을 기준으로 오름차순 정렬
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY emp_name ASC; 
    
-- 이름을 기준으로 내림차순 정렬
SELECT emp_name, emp_id, gender, dept_id, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY emp_name ASC;-- 기본값이 ASC이므로 생략 가능

-- 부서코드를 기준으로 오름차순, 이름을 기준으로 내림차순 정렬(복합 정렬)
SELECT dept_id, emp_name, emp_id, gender, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY dept_id ASC, emp_name DESC;
    
SELECT dept_id, emp_name, emp_id, gender, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY dept_id, emp_name DESC; -- dept_id는 ASC, emp_name은 DESC

-- 참고: 숫자로 정렬 기준 열 지정    
SELECT dept_id, emp_name, emp_id, gender, hire_date, phone
	FROM employee
	WHERE retire_date IS NULL
	ORDER BY 1 ASC, 3 DESC; -- dept_id로 ASC, emp_id는 DESC

-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
-- Q) 연봉이 높은 순으로 정렬해서 근무 중인 직원 정보 조회



-- Q) 최근 입사자가 먼저 조회되도록 정렬해서 근무 중인 직원 정보 조회


    
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
 
  
/*
12. CASE 문
ORACLE, MSSQL에서 똑같이 사용 가능
*/

-- 직원 정보 조회
SELECT emp_name, emp_id, gender, hire_date, salary
	FROM employee;

-- 성별: M, F --> 남자, 여자로 표시
SELECT emp_name, emp_id, 
       CASE WHEN gender = 'M' THEN '남자'
            WHEN gender = 'F' THEN '여자'
            ELSE '' END AS gender, 
	   hire_date, retire_date, salary
	FROM employee;

-- 다른 방법(추천하지 않음): 단 하나의 열만 가지고 조건을 줄 때 사용 가능
SELECT emp_name, emp_id, 
       CASE gender WHEN 'M' THEN '남자'
                   WHEN 'F' THEN '여자'
                   ELSE '' END AS gender, 
	   hire_date, retire_date, salary
	FROM employee;
    
-- 근무 상태를 근무, 퇴사로 표시
SELECT emp_name, emp_id, gender, hire_date, salary,
       CASE WHEN retire_date IS NULL THEN '근무'
            ELSE '퇴사' END AS status
	FROM employee;


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --

-- Q) 부서 코드가 SYS이면 전화번호를 공백으로 해서 근무 중인 직원 조회


    
-- Q) 급여 크기를 상, 중, 하로 구분해서 근무 중인 직원 조회


    
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --
     
     
/*
13. IF 함수
MySQL에서만 사용 가능(ORACLE, MSSQL 불가능)
*/

-- 성별: M, F --> 남자, 여자 (단, gender 열에 M, F 만 입력 된다고 가정함)
SELECT emp_name, emp_id, 
       IF(gender = 'M', '남자', '여자') AS gender, 
	   hire_date, retire_date, salary
	FROM employee;

-- 성별: M, F --> 남자, 여자 (IF 함수 중첩해서 사용)
SELECT emp_name, emp_id, 
       IF(gender = 'M', '남자', IF(gender = 'F', '여자', '')) AS gender, 
	   hire_date, retire_date, salary
	FROM employee;
    
-- 근무 상태를 근무, 퇴사로 표시
SELECT emp_name, emp_id, gender, hire_date, salary,
       IF(retire_date IS NULL,  '근무', '퇴사') AS status
	FROM employee;

-- 영어 이름이 NULL이면 공백 표시
SELECT emp_name, emp_id, 
       IF(eng_name IS NULL, '', eng_name) AS eng_name,
       gender, hire_date, salary
	FROM employee;

-- 참고: 뷰 만들기
CREATE VIEW emp_info
AS    
SELECT emp_name, emp_id, 
       IFNULL(eng_name, '') AS eng_name,
       gender, hire_date, salary
	FROM employee;

-- 뷰 사용
SELECT * FROM emp_info;

-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --

-- Q) 부서 코드가 SYS이면 전화번호를 공백으로 해서 근무 중인 직원 조회

    
    
-- Q) 급여 크기를 상, 중, 하로 구분해서 근무 중인 직원 조회


    
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --   