/*
파일명 : ex08-select-subquery.sql

Subquery 구문
    SELECT 문에 SELECT문 입니다.
*/

-- 단일 행 Subquery 실행
select last_name, salary
from employees
WHERE salary > (SELECT salary from employees WHERE last_name = 'Abel');     -- (~) = 11000

-- Subquery에서 그룹 함수 사용
select last_name, job_id, salary
from employees
WHERE salary = (SELECT MIN(salary) from employees);

/*
여러 행 Subquery
     IN
        리스트의 임의 멤버와 같음
    ANY
        =, <>, >, <, <=, >= 연산자가 앞에 있어야 합니다.
        < ANY 는 최대값보다 작음을 의미합니다.
        > ANY 는 최소값보다 큼을 의미합니다.
        = ANY 는 IN 과 같습니다.
    ALL
        > ALL 은 최대값보다 큼을 의미합니다.
        < ALL 은 최소값보다 작음을 의미합니다.
        
*/
select employee_id, last_name, job_id, salary
from employees
WHERE salary < ANY(select salary from employees where job_id = 'IT_PROG')   -- salary < job_id = 'IT_PROG' 인 emp 의 salary 최대값 = 9000 : 9000 제외하고 보다 작은 값들
AND job_id <> 'IT_PROG';   

select employee_id, last_name, job_id, salary
from employees
WHERE salary > ALL(select salary from employees where job_id = 'IT_PROG')   -- salary > job_id = 'IT_PROG' 인 emp 의 salary 최대값 = 9000 : 9000 제외하고 보다 큰 값들
AND job_id <> 'IT_PROG';
--(비교)
select employee_id, last_name, job_id, salary
from employees
WHERE salary IN(select salary from employees where job_id = 'IT_PROG')   -- ()에 하나라도 해당하는 값 조회
AND job_id <> 'IT_PROG';


/*
EXISTS 연산자
     Subquery에서 최소한 한 개의 행을 반환하면 TRUE로 평가됩니다.
*/

select * from departments --1
where not EXISTS    --3 : 사원이 있으면 true > 없는 false 값 표시
        (select * from employees
        where employees.department_id = departments.department_id); --2
        
select * from employees
where department_id = 120;  -- 빈 값 : 위 exists 에서 false 값이므로 표시됨
--다른 방법
select * from departments 
where department_id NOT IN
        (select department_id from employees
        where employees.department_id = departments.department_id); 
        
/*
Subquery 의 null 값
    반환된 값 중 하나가 null 값이면 전체 query가 행을 반환하지 않습니다.
    null 값을 비교하는 모든 조건은 결과가 null이기 때문입니다.
*/
select emp.last_name
from employees emp
WHERE emp.employee_id NOT IN
                        (select mgr.manager_id
                        from employees mgr);
                        
select emp.last_name
from employees emp
where emp.employee_id NOT IN(null, 100, 102, 103);

select emp.last_name
from employees emp
where emp.employee_id 
AND emp.imployee_id = null
AND emp.imployee_id = 100
AND emp.imployee_id = 102
AND emp.imployee_id = 103;

--or , and 의 결과에서 null 값이 어떻게 처리되는지 확인!

--★☆숙제☆★