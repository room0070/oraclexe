/*
파일명: ex07-select-join.sql

JOIN
    SQL에서 두 개 이상의 테이블에서 관련된 행들을 결합하기 위한 연산입니다.
*/

--Natural JOIN : 두 테이블에서 데이터 유형과 이름이 일치하는 열을 기반으로 자동으로 테이블을 조인할 수 있습니다.
select department_id, department_name, 
        location_id, city
from departments
NATURAL JOIN locations; 
--lacation_id : locations 에서는 PK값 = 중복 x, null x
--            : departments 에서는 FK = 참조키 > locations 테이블을 바라보고 있음
-- >> location_id를 기반으로 두 테이블 자동 결합.

-- USING 절로 조인 : .명시적으로 결합을 수행하고자 하는 열을 정해줍니다.
select employee_id, last_name,
        location_id, department_id
from employees JOIN departments
USING (department_id);

-- ON 절로 조인 : ON 절을 사용하여 조인 조건을 지정합니다.(가장 많이 사용하는 방법)
select e.employee_id, last_name, e.department_id,
        d.department_id, location_id    -- 중복값인 department_id를 제외한 employee_id, last_name, location_id를 별칭 명시 안해도 된다.
from employees e JOIN departments d     --e, d 는 별칭         --JOIN = INNER JOIN
ON (e.department_id = d.department_id); -- 두 개가 같다고 지정하여 결합 조건 만듬

--1. ANSI 표준
select e.employee_id, e.last_name,
        e.department_id, d.location_id
from employees e JOIN departments d
ON e.department_id = d.department_id;

--2.(oracle에서만 가능)
select e.employee_id, e.last_name,
        e.department_id, d.location_id
from employees e, departments d     -- 사이에 JOIN 넣으면 오류 난다
WHERE e.department_id = d.department_id;

-- ON 절 사용하여 3-Way 조인 생성
--me
select employee_id, e.department_id 
        city, l.location_id, 
        d.department_id, department_name, d.location_id
from employees e JOIN locations l JOIN departments d
ON(e.department_id = d.department_id AND d.location_id = l.location_id);

--T1
select e.employee_id, l.city, d.department_name
from employees e
JOIN departments d
ON e.department_id = d.department_id
JOIN locations l
ON d.location_id = l.location_id;

-- 조인에 추가 조건 적용
select e.employee_id, e.last_name,e.manager_id, e.department_id,
        d.department_id, d.location_id
from employees e JOIN departments d
ON e.department_id = d.department_id
AND e.manager_id = 149;

select e.employee_id, e.last_name,e.manager_id, e.department_id,
        d.department_id, d.location_id
from employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.manager_id = 149;       -- and 써도 ok

/*
테이블 자체 조인
    ON 절을 사용하는 Self Join
*/
select worker.last_name emp, manager.last_name mgr
from employees worker JOIN employees manager
ON worker.manager_id = manager.employee_id;
--emp_id 의 관리자 번호 = mgr_id : emp_name 의 mrg_name 알 수 있다. ex)emp_id = 101 의 mgr_id = 100 > Kochhar 의 관리자는 King

-- 테이블 하나로 만들기 시도

/*
NonequiJoin
    등호 연산자 외의 다른 연산자를 포함하는 조인 조건입니다.
*/
/*
CREATE TABLE job_grades (
grade_level CHAR(1),
lowest_sal NUMBER(8,2) NOT NULL,
highest_sal NUMBER(8,2) NOT NULL
);

ALTER TABLE job_grades
ADD CONSTRAINT job_grades_grade_pk PRIMARY KEY (grade_level);    --제약조건 걸기. pk값 정하기

INSERT INTO job_grades VALUES ('A', 1000, 2999);
INSERT INTO job_grades VALUES ('B', 3000, 5999);
INSERT INTO job_grades VALUES ('C', 6000, 9999);
INSERT INTO job_grades VALUES ('D', 10000, 14999);
INSERT INTO job_grades VALUES ('E', 15000, 24999);
INSERT INTO job_grades VALUES ('F', 25000, 40000);

-- table 전체 삭제 : drop table job_grades;

COMMIT;

SELECT * FROM  job_grades;
*/

select e.last_name, e.salary, j.grade_level
from employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

/*
INNER JOIN 과 OUTER JOIN

    (INNER) JOIN
        일치하지 않는 행은 출력에 표시되지 않습니다. (교집합 해당 행 출력)
        
    OUTER JOIN
        한 테이블의 행을 기반으로 다른 테이블과의 연결이 없는 행까지 포함하여 반환합니다.
*/
--(비교)INNER JOIN : department_id = null 인 사람은 조회되지 않음 
select e.last_name, e.department_id, d.department_name
from employees e
JOIN departments d       
ON e.department_id = d.department_id;

/*
LEFT OUTER JOIN 
    departments 테이블에 대응되는 행이 없어도 왼쪽 테이블인 employees 테이블의 모든 행을 검색합니다.
*/
--1.ANSI 표준
select e.last_name, e.department_id, d.department_name      -- e.department_id
from employees e
LEFT OUTER JOIN departments d       -- join을 기준으로 왼쪽 테이블 e 를 모두 표시하고 d를 기준으로 매칭 > 매칭 안되는 값은 null로 표시
ON e.department_id = d.department_id;
--2. 해당 방법에서 LEFT OUTER JOIN 하고 싶으면 WHERE절 오른쪽에 (+) 붙이면 된다.
select e.last_name, e.department_id, d.department_name
from employees e, departments d      
WHERE e.department_id = d.department_id(+);

/*   
RIGHT OUTER JOIN
    EMPLOYEES 테이블에 대응되는 행이 없어도 오른쪽 테이블인 DEPARTMENTS 테이블의 모든 행을 검색합니다.
*/
select e.last_name, d.department_id, d.department_name      -- d.department_id ( e.department_id 사용하면 null값 있음)
from employees e
RIGHT OUTER JOIN departments d     
ON e.department_id = d.department_id;

/*
FULL OUTER JOIN
     DEPARTMENTS, EMPLOYEES 대응되는 행이 없어도 테이블의 모든 행을 검색합니다.
*/
select e.last_name, d.department_id, d.department_name    
from employees e
FULL OUTER JOIN departments d     
ON e.department_id = d.department_id;

/*
Cartesian Product
    조인 조건이 잘못되거나 완전히 생략된 경우 결과가 모든 행의 조합이 표시되는 Cartesian Product로 나타냅니다.
    경우의 수로 다 나온다.
*/

/*
CROSS JOIN
    두 테이블의 교차 곱을 생성합니다.
*/
select last_name, department_name
from employees
CROSS JOIN departments;

