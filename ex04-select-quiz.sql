/*
파일명: ex04-select-quiz.sql
*/

-- Q1. "employees" 테이블에서 모든 직원들은 성(last_name), 이름(first_name) 및 급여(salary)를 조회하세요.

select last_name, first_name, salary
from employees;

-- Q2. "jobs" 테이블에서 모든 직무든의 직무 ID(job_id)와 직무명(job_title)을 조회하세요.

select job_id, job_title
from jobs;

--Q3. "departments" 테이블에서 모든 부서들의 부서 ID(department_id) 와 부서명(department_name)을 조회하세요.

select department_id, department_name
from departments;

--Q4. "locations" 테이블에서 모든 지역들의 지역 ID(lacation_id) 와 도시(city)를 조회하세요.

select location_id, city
from locations;

--Q5."employees" 테이블에서 급여(salary)가 5000 이상인 직원들의 이름(first_name)과 급여(salary)를 조회하세요.

select first_name, salary
from employees
WHERE salary >= 5000;

--Q6. "employees" 테이블에서 근무 시작일(hire_date)이 2005년 이후인 직원들의 이름(first_name)과 근무 시작일(hire_date)을 조회하세요.

select first_name, hire_date
from employees
WHERE hire_date > '05/01/01';
--ORDER BY hire_date ASC;

DESC employees
--했을 때 hire_date 유형이 DATE로 되어있음.
select first_name, hire_date
from employees
WHERE hire_date > TO_DATE('2005-01-01', 'YYYY-MM-DD');
--바꾸고 싶은 형식(문자열, 내가 지정한 문자열 형식)
--'2005-01-01' 을 나는 'YYYY-MM-DD' 형식으로 썼다. > DATE 형식으로 바꿔라



