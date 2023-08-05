/*
파일명: ex06-function-group.sql
*/

-- 여러 행(그룹) 함수

-- AVG() - 평균
-- MAX() - 최대값
-- MIN() - 최소값
-- SUM() - 합계

select AVG(salary) AS avg_salary,
        MAX(salary) AS max_salary,
        MIN(salary) AS min_salary,
        SUM(salary) AS total_salary
from employees
where job_id LIKE '%REP%';

-- COUNT() 함수 - null 값이 아닌 모든 행의 개수를 반환합니다.
select COUNT(*) AS total_employees      
from employees
where department_id = 50;

select COUNT(1) AS total_employees      -- * 대신 리터럴 상수값 아무거나 넣어도 결과 같음
from employees
where department_id = 50;

--why? 50개 행 인출은 같으나, select값을 따로 설정하지 않아 화면에 1로 표시할 뿐.
select *
from employees;

select 1
from employees;

-- null 값은 셀 수 없다.
select COUNT(commission_pct) AS non_null_commission_count
from employees
where department_id = 50;

-- null 값을 0으로 바꾼 후 계산
select COUNT(NVA(commission_pct,0)) AS non_null_commission_count
from employees
where department_id = 50;
