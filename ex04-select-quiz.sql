/*
���ϸ�: ex04-select-quiz.sql
*/

-- Q1. "employees" ���̺��� ��� �������� ��(last_name), �̸�(first_name) �� �޿�(salary)�� ��ȸ�ϼ���.

select last_name, first_name, salary
from employees;

-- Q2. "jobs" ���̺��� ��� �������� ���� ID(job_id)�� ������(job_title)�� ��ȸ�ϼ���.

select job_id, job_title
from jobs;

--Q3. "departments" ���̺��� ��� �μ����� �μ� ID(department_id) �� �μ���(department_name)�� ��ȸ�ϼ���.

select department_id, department_name
from departments;

--Q4. "locations" ���̺��� ��� �������� ���� ID(lacation_id) �� ����(city)�� ��ȸ�ϼ���.

select location_id, city
from locations;

--Q5."employees" ���̺��� �޿�(salary)�� 5000 �̻��� �������� �̸�(first_name)�� �޿�(salary)�� ��ȸ�ϼ���.

select first_name, salary
from employees
WHERE salary >= 5000;

--Q6. "employees" ���̺��� �ٹ� ������(hire_date)�� 2005�� ������ �������� �̸�(first_name)�� �ٹ� ������(hire_date)�� ��ȸ�ϼ���.

select first_name, hire_date
from employees
WHERE hire_date > '05/01/01';
--ORDER BY hire_date ASC;

DESC employees
--���� �� hire_date ������ DATE�� �Ǿ�����.
select first_name, hire_date
from employees
WHERE hire_date > TO_DATE('2005-01-01', 'YYYY-MM-DD');
--�ٲٰ� ���� ����(���ڿ�, ���� ������ ���ڿ� ����)
--'2005-01-01' �� ���� 'YYYY-MM-DD' �������� ���. > DATE �������� �ٲ��



