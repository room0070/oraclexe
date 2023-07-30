/*
파일명: ex02-select-where.sql

선택을 사용하여 행 제한
    WHERE 절을 사용하여 반환되는 행을 제한합니다.
    
WHERE
    조건을 충족하는 행으로 query를 제한합니다.
    
    세가지 요소
    - 열 이름
    - 비교 조건
    - 열 이름, 상수 또는 값 리스트
*/
-- WHERE 절 사용
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90;   --값이 90인 것만 select-from 절에서 조회해달라.(from -> where -> select 순서)

/*
문자열 및 날짜
    문자열 및 날짜 값은 작은 따옴표로 묶습니다.
    문자 값은 대소문자를 구분하고 날짜 값은 형식을 구분합니다.
    
    기본 날짜 표시 형식은 DD-MON-RR(일-월-년)
    (도구-환경설정-데이터베이스-NLS)
*/

SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'Whalen';

SELECT last_name, hire_date
FROM employees
WHERE hire_date = '03/06/17';

/*
비교 연산자
    특정 표현식을 다른 값이나 표현식과 비교하는 조건에서 사용됩니다.
    
    =   같음
    >   보다 큼
    >=  보다 크거나 같음
    <   보다 작음
    <=  보다 작거나 같음
    <>  같지 않음
    BETWEEN ... AND ... 두 값 사이(경계값 포함)
    IN(set)             값 리스트 중 일치하는 값 검색
    LIKE                일치하는 문자 패턴 검색
    IS NULL             NULL 값인지 여부
    
*/
--비교 연산자 사용
select last_name, salary
from employees
where salary <= 3000;

-- BETWEEN  연산자를 사용하는 범위 조건
select last_name, salary
from employees
where salary BETWEEN 2500 AND 3500;

select last_name, salary
from employees
where salary >= 2500 
AND salary <= 3500;

-- IN 연산자를 사용하는 멤버 조건
select employee_id, last_name, salary, manager_id
from employees
where manager_id IN (100, 101, 201);

select employee_id, last_name, salary, manager_id
from employees
where manager_id = 100
OR manager_id = 101         -- AND: 두 조건이 모두 참일 때 참
OR manager_id = 201;        -- OR : 둘 중 하나만 참이어도 참

/*
LIKE 연산자를 사용하여 패턴 일치
    LIKE 연산자를 사용하여 유효한 검색 문자열 값의 대체 문자 검색을 수행합니다.
    검색 조건에는 리터럴 문자나 숫자가 포함될 수 있습니다.
        - % : 0개 이상의 문자를 나타냅니다.
        - _ : 한 문자를 나타냅니다.
        
*/
select first_name
from employees
where first_name LIKE 'A%';     -- A로 시작하고 뒤에 문자가 몇 개이든 이어지는 것들 조회

select first_name
from employees
where first_name LIKE '%a%';     -- 가운데 어디든 a가 들어가는 것들 조회

--대체 문자 결합
select last_name
from employees
where last_name LIKE '_o%';     -- 두번째 글자가 o인 것들 조회

 -- ESCAPE 식별자
select employee_id, last_name, job_id
from employees
where job_id LIKE '%SA\_%' ESCAPE '\';  -- LIKE에서 한 글자_가 아니라 언더바_ 문자를 조회하고 싶을 때 식별자 필요한데, 식별자를 \로 설정한 것  --결과값: SA_MAN , SA_REP

/*
NULL 조건 사용
    IS NULL 연산자로 NULL을 테스트 합니다.
*/
select last_name, manager_id, salary
from employees
where manager_id IS NULL;   -- NULL 데이터 조회 시 = NULL 하면 안 된다.

/*
논리 연산자를 사용하여 조건 정의
    AND : 구성 요소 조건이 모두 참인 경우 TRUE 반환
    OR  : 구성 요소 조건 중 하나가 참인 경우 TRUE 반환
    NOT : 조건이 거짓인 경우 TRUE 반환
    
*/
-- AND 연산자 사용
select employee_id, last_name, job_id, salary
from employees
where salary >= 10000
AND job_id LIKE '%MAN%';

-- OR 연산자 사용
select employee_id, last_name, job_id, salary, 10000*12*1200 as test
from employees
where salary >= 10000
OR job_id LIKE '%MAN%';

-- NOT 연산자 사용
select last_name, job_id
from employees
where job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');      --IN(set) 에 하나도 해당되지 않는 조건 조회(반전)





