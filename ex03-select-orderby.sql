/*
파일명: ex03-select-orderby.sql

ORDER By 절
    ORDER BY 절을 사용하여 검색된 행을 정렬합니다.
        ASC  : 오름차순, 기본값
        DESC : 내림차순
    SELECT 문의 맨 마지막에 옵니다.
    
[SELECT 문 기본형식]                        인식 순서            --[]는 써도 되고 안 써도 되는 애들.
SELECT [DISTICT] | 컬럼명1, 컬럼명2 ...        .5
FROM 테이블명                                 .1
WHERE 조건절                                  .2
GROUP BY 컬럼명                               .3
HAVING 조건절                                 .4
ORDER BY 컬럼명 [ASC|DESC]                    .6
*/
select last_name, job_id, department_id, hire_date
from employees
ORDER BY hire_date;     -- hire_date 기준으로 기본(오름차순) 정렬

-- 내림차순 정렬
select last_name, job_id, department_id, hire_date
from employees
ORDER BY hire_date DESC;    --큰 값부터 정렬

-- 열 alias(별칭)를 기준으로 정렬
select employee_id, last_name, salary*12 annsal
from employees
ORDER BY annsal;
--where절은 별칭 사용 안 되고 ORDER BY절만 가능(인식 순서 때문)


-- 열 숫자 위치를 사용하여 정렬
select last_name, job_id, department_id, hire_date      --last_name : 1 / job_id : 2 / hire_date : 4번
from employees
ORDER BY 3;     --컬럼명 대신 숫자 사용하면 select에 사용된 컬럼 순서대로 번호가 매겨져 있어 3번(=department_id) 기준으로 정렬된다.

-- 여러 열을 기준으로 정렬
select last_name, job_id, department_id, salary
from employees
ORDER BY department_id, salary DESC;    --department_id 로 먼저 정렬 후 그 안에서 department_id 가 같은 경우 salary 기준으로 내림차순 정렬 






