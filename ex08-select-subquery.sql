/*
���ϸ� : ex08-select-subquery.sql

Subquery ����
    SELECT ���� SELECT�� �Դϴ�.
*/

-- ���� �� Subquery ����
select last_name, salary
from employees
WHERE salary > (SELECT salary from employees WHERE last_name = 'Abel');     -- (~) = 11000

-- Subquery���� �׷� �Լ� ���
select last_name, job_id, salary
from employees
WHERE salary = (SELECT MIN(salary) from employees);

/*
���� �� Subquery
     IN
        ����Ʈ�� ���� ����� ����
    ANY
        =, <>, >, <, <=, >= �����ڰ� �տ� �־�� �մϴ�.
        < ANY �� �ִ밪���� ������ �ǹ��մϴ�.
        > ANY �� �ּҰ����� ŭ�� �ǹ��մϴ�.
        = ANY �� IN �� �����ϴ�.
    ALL
        > ALL �� �ִ밪���� ŭ�� �ǹ��մϴ�.
        < ALL �� �ּҰ����� ������ �ǹ��մϴ�.
        
*/
select employee_id, last_name, job_id, salary
from employees
WHERE salary < ANY(select salary from employees where job_id = 'IT_PROG')   -- salary < job_id = 'IT_PROG' �� emp �� salary �ִ밪 = 9000 : 9000 �����ϰ� ���� ���� ����
AND job_id <> 'IT_PROG';   

select employee_id, last_name, job_id, salary
from employees
WHERE salary > ALL(select salary from employees where job_id = 'IT_PROG')   -- salary > job_id = 'IT_PROG' �� emp �� salary �ִ밪 = 9000 : 9000 �����ϰ� ���� ū ����
AND job_id <> 'IT_PROG';
--(��)
select employee_id, last_name, job_id, salary
from employees
WHERE salary IN(select salary from employees where job_id = 'IT_PROG')   -- ()�� �ϳ��� �ش��ϴ� �� ��ȸ
AND job_id <> 'IT_PROG';


/*
EXISTS ������
     Subquery���� �ּ��� �� ���� ���� ��ȯ�ϸ� TRUE�� �򰡵˴ϴ�.
*/

select * from departments --1
where not EXISTS    --3 : ����� ������ true > ���� false �� ǥ��
        (select * from employees
        where employees.department_id = departments.department_id); --2
        
select * from employees
where department_id = 120;  -- �� �� : �� exists ���� false ���̹Ƿ� ǥ�õ�
--�ٸ� ���
select * from departments 
where department_id NOT IN
        (select department_id from employees
        where employees.department_id = departments.department_id); 
        
/*
Subquery �� null ��
    ��ȯ�� �� �� �ϳ��� null ���̸� ��ü query�� ���� ��ȯ���� �ʽ��ϴ�.
    null ���� ���ϴ� ��� ������ ����� null�̱� �����Դϴ�.
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

--or , and �� ������� null ���� ��� ó���Ǵ��� Ȯ��!

--�ڡټ����١�