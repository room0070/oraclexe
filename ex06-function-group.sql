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
/*
--why? select값을 따로 설정하지 않아 화면에 1로 표시할 뿐, 50개 행 인출은 같다.
select *
from employees;

select 1
from employees; 
*/
-- null 값은 셀 수 없다.
select COUNT(commission_pct) AS non_null_commission_count
from employees
where department_id = 50;

-- null 값을 0으로 바꾼 후 계산 : COUNT(*or4) 등으로 계산하자..
select COUNT(NVL(commission_pct,0)) AS non_null_commission_count
from employees
where department_id = 50;

-- COUNT(DISTINCT expr)은 특정 표현식을 기준으로 중복을 제거한 행의 개수를 반환합니다.(null값 포함 X)
select COUNT(DISTINCT department_id) AS distinct_department_count
from employees;
-- 비교
select DISTINCT department_id
from employees;

-- NVL 함수를 활용하여 NULL 값을 다른 값으로 대체한 후 AVG() 함수 사용
select AVG(NVL(commission_pct, 0)) AS avg_commission
from employees;

/*
.GROUP BY
    여러 행을 지정된 컬럼 기준으로 그룹화하여 집계 함수를 적용하기 위한 구문
    
HAVING 
    GROUP BY 와 함께 사용되며, 그룹화 된 결과에 조건을 적용할 때 사용됩니다.
    
    WEHRE - 개별행의 조건
    HAVING - 그룹의 조건
*/

-- 부서별 평균 급여를 구합니다.
select department_id, AVG(salary) AS avg_salary
from employees
GROUP BY department_id;     -- 중복 값 제거하여 그룹화

-- GROUP BY 절에서 여러 열을 기준으로 그룹화 합니다.
select department_id, job_id, SUM(salary) AS total_salary   
from employees
WHERE department_id > 40
GROUP BY department_id, job_id
ORDER BY department_id;             --fromt > where(개별행에 대한 조건) > GROUP BY(department_id 안에서 job_id로 그룹화) > select > order by ASC(오름차순 정렬) 

-- HAVING 절 사용

-- 부서별 최대 급여가 10000보다 큰 부서를 찾습니다.
select department_id, MAX(salary) AS max_salary
from employees
GROUP BY department_id
HAVING MAX(salary) > 10000;     -- group에 대한 조건이니까 having 사용

-- 직무별 총 급여가 13000보다 큰 직무를 찾습니다.
select job_id, SUM(salary) AS total_salary
from employees
WHERE job_id NOT LIKE '%REP%'       -- 단일 행에 대한 조건 where 사용
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY total_salary;     

-- 그룹함수 함수중첩 가능
select MAX(AVG(salary)) AS max_avg_salary
from employees
GROUP BY department_id;
