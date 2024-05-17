/*
제목: 다중 테이블 조회
작성: 이장래
내용: JOIN문과 하위 쿼리 작성 방법 학습
*/


-- 데이터베이스 연결
USE hrdb2024;


/*
1. 조인 작성 과정
*/

-- 직원 정보 조회
SELECT emp_id, emp_name, dept_id, phone, email
	FROM employee 
	WHERE retire_date IS NULL;

-- 조인 1단계
SELECT emp_id, emp_name, employee.dept_id, dept_name, phone, email
	FROM employee 
    INNER JOIN department ON employee.dept_id = department.dept_id
	WHERE retire_date IS NULL;


-- 조인 2단계
SELECT emp_id, emp_name, e.dept_id, dept_name, phone, email
	FROM employee AS e
    INNER JOIN department AS d ON e.dept_id = d.dept_id
	WHERE retire_date IS NULL;


-- 조인 3단계
SELECT e.emp_id, e.emp_name, e.dept_id, d.dept_name, e.phone, e.email
	FROM employee AS e
    INNER JOIN department AS d ON e.dept_id = d.dept_id
	WHERE e.retire_date IS NULL;

SELECT v.emp_id, e.emp_name, e.gender, e.hire_date, v.begin_date, 
		v.reason, v.duration
	FROM vacation AS v
    JOIN employee AS e ON v.emp_id = e.emp_id
    WHERE e.retire_date IS NULL
    ORDER BY v.emp_id ASC, v.begin_date DESC;
    
-- INNER JOIN: 매핑 되는 행만 출력    
SELECT d.dept_id, d.dept_name, u.unit_name
	FROM department AS d
    INNER JOIN unit AS u ON d.unit_id = u.unit_id;

-- OUTER JOIN  
SELECT d.dept_id, d.dept_name, u.unit_name
	FROM department AS d
    LEFT OUTER JOIN unit AS u ON d.unit_id = u.unit_id;

-- INNER JOIN = JOIN
-- LEFT OUTER JOIN = LEFT JOIN
-- RIGHT OUTER JOIN = RIGHT JOIN
-- FULL OUTER JOIN = FULL JOIN(MySQL만 불가능)
-- CROSS JOIN

-- 마지막 조인
-- (부모는 자식의 행의 수만큼 찾아가므로 행의 수가 많아짐)
-- 근무 중이 모든 직원들의 휴가 근황
SELECT e.emp_id, e.emp_name, e.dept_id, e.hire_date,
		v.begin_date, v.reason, v.duration
	FROM employee AS e
    LEFT OUTER JOIN vacation AS v ON e.emp_id = v.emp_id
    WHERE retire_date IS NULL;

/*
2. INNER JOIN
*/

-- 직원 정보 조회
SELECT e.emp_id, e.emp_name, e.dept_id, d.dept_name, e.phone
	FROM employee AS e
	INNER JOIN department AS d ON e.dept_id = d.dept_id
	WHERE e.retire_date IS NULL;

-- 휴가 정보 조회
SELECT e.emp_id, e.emp_name, v.begin_date, v.end_date, v.reason, v.duration
	FROM employee AS e
	INNER JOIN vacation AS v ON e.emp_id = v.emp_id
	WHERE retire_date IS NULL
	ORDER BY e.emp_id ASC;

-- 부서 정보 조회
SELECT d.dept_id, d.dept_name, d.unit_id, u.unit_name, d.start_date
	FROM department AS d
	INNER JOIN unit AS u ON d.unit_id = u.unit_id;

-- 휴가 정보 조회
SELECT v.emp_id, e.emp_name, e.dept_id, e.phone, SUM(v.duration) AS Tot_duration
	FROM vacation AS v
	INNER JOIN employee AS e ON v.emp_id = e.emp_id
	WHERE v.begin_date BETWEEN '2020-01-01' AND '2020-06-30'
	GROUP BY v.emp_id, e.emp_name, e.dept_id, e.phone
	ORDER BY SUM(v.duration) DESC;


/*
3. OUTER JOIN
*/

-- 휴가 정보 조회
SELECT e.emp_id, e.emp_name, v.begin_date, v.end_date, v.reason, v.duration
	FROM employee AS e 
	LEFT OUTER JOIN vacation AS v ON e.emp_id = v.emp_id
	WHERE retire_date IS NULL
	ORDER BY e.emp_id ASC;

-- 부서 정보 조회
SELECT d.dept_id, d.dept_name, d.unit_id, u.unit_name
   FROM department AS d
   LEFT OUTER JOIN unit AS u ON d.unit_id = u.unit_id;


/*
4. CROSS JOIN
*/

-- 직원과 부서간 CROSS JOIN
SELECT emp_name, dept_name
    FROM employee AS e
    CROSS JOIN department AS d;


-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --

-- Q) 부서 이름 다음에 본부 이름을 표시하도록 다음 쿼리문 수정

SELECT e.emp_id, e.emp_name, e.dept_id, d.dept_name, e.phone, e.email
	FROM employee AS e
	INNER JOIN department AS d ON e.dept_id = d.dept_id
	WHERE e.hire_date BETWEEN '2020-01-01' AND '2020-12-31' 
		AND e.retire_date IS NULL;


-- Q) 직원 이름 다음에 부서 이름을 표시하도록 다음 쿼리문 수정

SELECT e.emp_id, e.emp_name, v.begin_date, v.end_date, v.reason, v.duration
	FROM employee AS e
	INNER JOIN vacation AS v ON e.emp_id = v.emp_id
	WHERE e.hire_date BETWEEN '2020-01-01' AND '2020-12-31' 
		AND e.retire_date IS NULL
	ORDER BY e.emp_id ASC;


-- Q) 직원 이름 다음에 본부 이름을 표시하도록 다음 쿼리문 수정

SELECT e.emp_id, e.emp_name, v.begin_date, v.end_date, v.reason, v.duration
	FROM employee AS e
	INNER JOIN vacation AS v ON e.emp_id = v.emp_id
	WHERE e.hire_date BETWEEN '20120-01-01' AND '2020-12-31' 
		AND e.retire_date IS NULL
	ORDER BY e.emp_id ASC;

    
-- Q) 본부에 포함되지 않은 부서 정보를 조회하도록 다음 쿼리문 수정

SELECT d.dept_id, d.dept_name, d.unit_id, u.unit_name
   FROM department AS d
   LEFT OUTER JOIN unit AS u ON d.unit_id = u.unit_id;

-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --


/*
5. 하위 쿼리
- 쿼리 안에 쿼리가 있는 형태
*/

-- 가장 급여를 많이 받는 직원
SELECT emp_id, emp_name, dept_id, phone, email, salary
	FROM employee
	WHERE salary = (SELECT MAX(salary) FROM employee);

-- 홍길동과 같은 부서에 근무하는 직원 정보
SELECT emp_id, emp_name, dept_id, phone, email, salary
	FROM employee
	WHERE dept_id = (SELECT dept_id FROM employee WHERE emp_id = 'S0001');
    
-- 가장 먼저 입사한 직원
SELECT emp_id, emp_name, dept_id, phone, email, salary
	FROM employee
	WHERE hire_date = (SELECT MIN(hire_date) FROM employee);

-- 휴가를 간 적이 있는 정보시스템 직원 #1
-- DISTINCT: 중복 생략
SELECT emp_id, emp_name, dept_id, phone, email
	FROM employee
	WHERE dept_id = 'SYS'
	AND emp_id IN (SELECT DISTINCT emp_id FROM vacation);

-- 휴가를 간 적이 있는 정보시스템 직원 #2(중요)
-- 상관하위 쿼리: 괄호 밖과 안 쿼리가 상관이 있어 단일로 실행이 안 되는 쿼리
-- -> 괄호 밖 쿼리가 먼저 실행되고, 괄호 안 쿼리가 실행됨
SELECT emp_id, emp_name, dept_id, phone, email
	FROM employee AS e
	WHERE dept_id = 'SYS'
	AND EXISTS (SELECT * 
                    FROM vacation
                    WHERE emp_id = e.emp_id);
                    
-- NOT BETWEEN
-- NOT IN
-- NOT LIKE
-- IS NOT NULL
-- NOT EXISTS

-- JOIN 없이 dept_name 가져오기
SELECT emp_id, emp_name, dept_id,
	(SELECT dept_name FROM department WHERE dept_id = e.dept_id)dept_name,
    hire_date,
    (SELECT SUM(duration) FROM vacation WHERE emp_id = e.emp_id) AS tot_duration
	FROM employee AS e
    WHERE retire_date IS NULL;
    
-- 휴가를 간 적이 없는 정보시스템 직원 #1
SELECT emp_id, emp_name, dept_id, phone, email
	FROM employee
	WHERE dept_id = 'SYS'
	AND emp_id NOT IN (SELECT emp_id FROM vacation);

-- 휴가를 간 적이 없는 정보시스템 직원 #2
SELECT emp_id, emp_name, dept_id, phone, email
	FROM employee AS e
	WHERE dept_id = 'SYS'
	AND NOT EXISTS (SELECT * 
                        FROM vacation
                        WHERE emp_id = e.emp_id);
                        
                        
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --

-- Q) 가장 최근에 퇴사한 직원 정보 조회

   
    
-- Q) 강우동(S0003)보다 급여를 많이 받는 직원 정보 조회


    
-- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * -- * --


/*
6. 하위 쿼리 활용
*/


-- 1) 활용 #1

-- 남녀별 근무 중인 직원 급여 정보
SELECT emp_name, emp_id, gender, dept_id, hire_date, salary
    FROM employee
    WHERE retire_date IS NULL AND salary IS NOT NULL;
    
-- 1단계: 남녀별 근무 중인 직원 급여 순위
SELECT emp_name, emp_id, gender, dept_id, hire_date, salary,
       RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rnk
    FROM employee
    WHERE retire_date IS NULL AND salary IS NOT NULL;
    
-- 2단계: 남녀별 급여를 가장 많이 받는 근무 중인 직원 조회
SELECT emp_name, emp_id, gender, dept_id, hire_date, salary
	FROM (
		SELECT emp_name, emp_id, gender, dept_id, hire_date, salary,
			RANK() OVER(PARTITION BY gender ORDER BY salary DESC) AS rnk
			FROM employee
			WHERE retire_date IS NULL AND salary IS NOT NULL
	) AS emp
    WHERE rnk = 1;


-- 2) 활용 #2

-- 근무 중인 직원
SELECT emp_name, emp_id, gender, dept_id, hire_date, salary
    FROM employee
    WHERE retire_date IS NULL;
    
-- 1딘계: 남녀별 근무 중인 직원 번호 붙이기
SELECT ROW_NUMBER() OVER(PARTITION BY gender ORDER BY emp_name ASC) AS num,
	   emp_name, emp_id, gender, dept_id, hire_date, salary
    FROM employee
    WHERE retire_date IS NULL;
    
-- 2단계: 남녀별 3명씩 조회
SELECT emp_name, emp_id, gender, dept_id, hire_date, salary
	FROM (
		SELECT ROW_NUMBER() OVER(PARTITION BY gender ORDER BY emp_name ASC) AS num,
			   emp_name, emp_id, gender, dept_id, hire_date, salary
			FROM employee
			WHERE retire_date IS NULL
	) AS emp
    WHERE num BETWEEN 1 AND 3;

    
-- 3) 활용 #3

-- 남녀별 근무 중인 직원
SELECT d.dept_name, e.emp_name, e.emp_id, e.dept_id, e.gender, e.hire_date, e.salary
    FROM employee AS e
    INNER JOIN department AS d ON e.dept_id = d.dept_id
    WHERE e.retire_date IS NULL
    ORDER BY d.dept_name ASC;

-- 1단계: 부서별 번호 부여
SELECT ROW_NUMBER() OVER(PARTITION BY e.dept_id ORDER BY e.emp_name ASC) AS num,
	   d.dept_name, e.emp_name, e.emp_id, e.dept_id, e.gender, e.hire_date, e.salary
    FROM employee AS e
    INNER JOIN department AS d ON e.dept_id = d.dept_id
    WHERE e.retire_date IS NULL
    ORDER BY dept_name ASC;
    
-- 2딘계: 부서 이름 처음에 한 번만 표시
SELECT IF(num = 1, dept_name, '') AS dept_name, emp_name, emp_id, dept_id, gender, hire_date, salary
	FROM (
		SELECT ROW_NUMBER() OVER(PARTITION BY e.dept_id ORDER BY e.emp_name) AS num,
			   d.dept_name, e.emp_name, e.emp_id, e.dept_id, e.gender, e.hire_date, e.salary
			FROM employee AS e
			INNER JOIN department AS d ON e.dept_id = d.dept_id
			WHERE e.retire_date IS NULL
	) AS emp
    ORDER BY emp.dept_name ASC;