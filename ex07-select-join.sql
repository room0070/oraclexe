/*
���ϸ�: ex07-select-join.sql

JOIN
    SQL���� �� �� �̻��� ���̺��� ���õ� ����� �����ϱ� ���� �����Դϴ�.
*/

--Natural JOIN : �� ���̺��� ������ ������ �̸��� ��ġ�ϴ� ���� ������� �ڵ����� ���̺��� ������ �� �ֽ��ϴ�.
select department_id, department_name, 
        location_id, city
from departments
NATURAL JOIN locations; 
--lacation_id : locations ������ PK�� = �ߺ� x, null x
--            : departments ������ FK = ����Ű > locations ���̺��� �ٶ󺸰� ����
-- >> location_id�� ������� �� ���̺� �ڵ� ����.

-- USING ���� ���� : .��������� ������ �����ϰ��� �ϴ� ���� �����ݴϴ�.
select employee_id, last_name,
        location_id, department_id
from employees JOIN departments
USING (department_id);

-- ON ���� ���� : ON ���� ����Ͽ� ���� ������ �����մϴ�.(���� ���� ����ϴ� ���)
select e.employee_id, last_name, e.department_id,
        d.department_id, location_id    -- �ߺ����� department_id�� ������ employee_id, last_name, location_id�� ��Ī ��� ���ص� �ȴ�.
from employees e JOIN departments d     --e, d �� ��Ī         --JOIN = INNER JOIN
ON (e.department_id = d.department_id); -- �� ���� ���ٰ� �����Ͽ� ���� ���� ����

--1. ANSI ǥ��
select e.employee_id, e.last_name,
        e.department_id, d.location_id
from employees e JOIN departments d
ON e.department_id = d.department_id;

--2.(oracle������ ����)
select e.employee_id, e.last_name,
        e.department_id, d.location_id
from employees e, departments d     -- ���̿� JOIN ������ ���� ����
WHERE e.department_id = d.department_id;

-- ON �� ����Ͽ� 3-Way ���� ����
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

-- ���ο� �߰� ���� ����
select e.employee_id, e.last_name,e.manager_id, e.department_id,
        d.department_id, d.location_id
from employees e JOIN departments d
ON e.department_id = d.department_id
AND e.manager_id = 149;

select e.employee_id, e.last_name,e.manager_id, e.department_id,
        d.department_id, d.location_id
from employees e JOIN departments d
ON e.department_id = d.department_id
WHERE e.manager_id = 149;       -- and �ᵵ ok

/*
���̺� ��ü ����
    ON ���� ����ϴ� Self Join
*/
select worker.last_name emp, manager.last_name mgr
from employees worker JOIN employees manager
ON worker.manager_id = manager.employee_id;
--emp_id �� ������ ��ȣ = mgr_id : emp_name �� mrg_name �� �� �ִ�. ex)emp_id = 101 �� mgr_id = 100 > Kochhar �� �����ڴ� King

-- ���̺� �ϳ��� ����� �õ�

/*
NonequiJoin
    ��ȣ ������ ���� �ٸ� �����ڸ� �����ϴ� ���� �����Դϴ�.
*/
/*
CREATE TABLE job_grades (
grade_level CHAR(1),
lowest_sal NUMBER(8,2) NOT NULL,
highest_sal NUMBER(8,2) NOT NULL
);

ALTER TABLE job_grades
ADD CONSTRAINT job_grades_grade_pk PRIMARY KEY (grade_level);    --�������� �ɱ�. pk�� ���ϱ�

INSERT INTO job_grades VALUES ('A', 1000, 2999);
INSERT INTO job_grades VALUES ('B', 3000, 5999);
INSERT INTO job_grades VALUES ('C', 6000, 9999);
INSERT INTO job_grades VALUES ('D', 10000, 14999);
INSERT INTO job_grades VALUES ('E', 15000, 24999);
INSERT INTO job_grades VALUES ('F', 25000, 40000);

-- table ��ü ���� : drop table job_grades;

COMMIT;

SELECT * FROM  job_grades;
*/

select e.last_name, e.salary, j.grade_level
from employees e JOIN job_grades j
ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;

/*
INNER JOIN �� OUTER JOIN

    (INNER) JOIN
        ��ġ���� �ʴ� ���� ��¿� ǥ�õ��� �ʽ��ϴ�. (������ �ش� �� ���)
        
    OUTER JOIN
        �� ���̺��� ���� ������� �ٸ� ���̺���� ������ ���� ����� �����Ͽ� ��ȯ�մϴ�.
*/
--(��)INNER JOIN : department_id = null �� ����� ��ȸ���� ���� 
select e.last_name, e.department_id, d.department_name
from employees e
JOIN departments d       
ON e.department_id = d.department_id;

/*
LEFT OUTER JOIN 
    departments ���̺� �����Ǵ� ���� ��� ���� ���̺��� employees ���̺��� ��� ���� �˻��մϴ�.
*/
--1.ANSI ǥ��
select e.last_name, e.department_id, d.department_name      -- e.department_id
from employees e
LEFT OUTER JOIN departments d       -- join�� �������� ���� ���̺� e �� ��� ǥ���ϰ� d�� �������� ��Ī > ��Ī �ȵǴ� ���� null�� ǥ��
ON e.department_id = d.department_id;
--2. �ش� ������� LEFT OUTER JOIN �ϰ� ������ WHERE�� �����ʿ� (+) ���̸� �ȴ�.
select e.last_name, e.department_id, d.department_name
from employees e, departments d      
WHERE e.department_id = d.department_id(+);

/*   
RIGHT OUTER JOIN
    EMPLOYEES ���̺� �����Ǵ� ���� ��� ������ ���̺��� DEPARTMENTS ���̺��� ��� ���� �˻��մϴ�.
*/
select e.last_name, d.department_id, d.department_name      -- d.department_id ( e.department_id ����ϸ� null�� ����)
from employees e
RIGHT OUTER JOIN departments d     
ON e.department_id = d.department_id;

/*
FULL OUTER JOIN
     DEPARTMENTS, EMPLOYEES �����Ǵ� ���� ��� ���̺��� ��� ���� �˻��մϴ�.
*/
select e.last_name, d.department_id, d.department_name    
from employees e
FULL OUTER JOIN departments d     
ON e.department_id = d.department_id;

/*
Cartesian Product
    ���� ������ �߸��ǰų� ������ ������ ��� ����� ��� ���� ������ ǥ�õǴ� Cartesian Product�� ��Ÿ���ϴ�.
    ����� ���� �� ���´�.
*/

/*
CROSS JOIN
    �� ���̺��� ���� ���� �����մϴ�.
*/
select last_name, department_name
from employees
CROSS JOIN departments;

