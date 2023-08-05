/*
���ϸ�: ex06-function-group.sql
*/

-- ���� ��(�׷�) �Լ�

-- AVG() - ���
-- MAX() - �ִ밪
-- MIN() - �ּҰ�
-- SUM() - �հ�

select AVG(salary) AS avg_salary,
        MAX(salary) AS max_salary,
        MIN(salary) AS min_salary,
        SUM(salary) AS total_salary
from employees
where job_id LIKE '%REP%';

-- COUNT() �Լ� - null ���� �ƴ� ��� ���� ������ ��ȯ�մϴ�.
select COUNT(*) AS total_employees      
from employees
where department_id = 50;

select COUNT(1) AS total_employees      -- * ��� ���ͷ� ����� �ƹ��ų� �־ ��� ����
from employees
where department_id = 50;

--why? 50�� �� ������ ������, select���� ���� �������� �ʾ� ȭ�鿡 1�� ǥ���� ��.
select *
from employees;

select 1
from employees;

-- null ���� �� �� ����.
select COUNT(commission_pct) AS non_null_commission_count
from employees
where department_id = 50;

-- null ���� 0���� �ٲ� �� ���
select COUNT(NVA(commission_pct,0)) AS non_null_commission_count
from employees
where department_id = 50;
