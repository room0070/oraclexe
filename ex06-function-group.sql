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
/*
--why? select���� ���� �������� �ʾ� ȭ�鿡 1�� ǥ���� ��, 50�� �� ������ ����.
select *
from employees;

select 1
from employees; 
*/
-- null ���� �� �� ����.
select COUNT(commission_pct) AS non_null_commission_count
from employees
where department_id = 50;

-- null ���� 0���� �ٲ� �� ��� : COUNT(*or4) ������ �������..
select COUNT(NVL(commission_pct,0)) AS non_null_commission_count
from employees
where department_id = 50;

-- COUNT(DISTINCT expr)�� Ư�� ǥ������ �������� �ߺ��� ������ ���� ������ ��ȯ�մϴ�.(null�� ���� X)
select COUNT(DISTINCT department_id) AS distinct_department_count
from employees;
-- ��
select DISTINCT department_id
from employees;

-- NVL �Լ��� Ȱ���Ͽ� NULL ���� �ٸ� ������ ��ü�� �� AVG() �Լ� ���
select AVG(NVL(commission_pct, 0)) AS avg_commission
from employees;

/*
.GROUP BY
    ���� ���� ������ �÷� �������� �׷�ȭ�Ͽ� ���� �Լ��� �����ϱ� ���� ����
    
HAVING 
    GROUP BY �� �Բ� ���Ǹ�, �׷�ȭ �� ����� ������ ������ �� ���˴ϴ�.
    
    WEHRE - �������� ����
    HAVING - �׷��� ����
*/

-- �μ��� ��� �޿��� ���մϴ�.
select department_id, AVG(salary) AS avg_salary
from employees
GROUP BY department_id;     -- �ߺ� �� �����Ͽ� �׷�ȭ

-- GROUP BY ������ ���� ���� �������� �׷�ȭ �մϴ�.
select department_id, job_id, SUM(salary) AS total_salary   
from employees
WHERE department_id > 40
GROUP BY department_id, job_id
ORDER BY department_id;             --fromt > where(�����࿡ ���� ����) > GROUP BY(department_id �ȿ��� job_id�� �׷�ȭ) > select > order by ASC(�������� ����) 

-- HAVING �� ���

-- �μ��� �ִ� �޿��� 10000���� ū �μ��� ã���ϴ�.
select department_id, MAX(salary) AS max_salary
from employees
GROUP BY department_id
HAVING MAX(salary) > 10000;     -- group�� ���� �����̴ϱ� having ���

-- ������ �� �޿��� 13000���� ū ������ ã���ϴ�.
select job_id, SUM(salary) AS total_salary
from employees
WHERE job_id NOT LIKE '%REP%'       -- ���� �࿡ ���� ���� where ���
GROUP BY job_id
HAVING SUM(salary) > 13000
ORDER BY total_salary;     

-- �׷��Լ� �Լ���ø ����
select MAX(AVG(salary)) AS max_avg_salary
from employees
GROUP BY department_id;
