/*
���ϸ�: ex02-select-where.sql

������ ����Ͽ� �� ����
    WHERE ���� ����Ͽ� ��ȯ�Ǵ� ���� �����մϴ�.
    
WHERE
    ������ �����ϴ� ������ query�� �����մϴ�.
    
    ������ ���
    - �� �̸�
    - �� ����
    - �� �̸�, ��� �Ǵ� �� ����Ʈ
*/
-- WHERE �� ���
SELECT employee_id, last_name, job_id, department_id
FROM employees
WHERE department_id = 90;   --���� 90�� �͸� select-from ������ ��ȸ�ش޶�.(from -> where -> select ����)

/*
���ڿ� �� ��¥
    ���ڿ� �� ��¥ ���� ���� ����ǥ�� �����ϴ�.
    ���� ���� ��ҹ��ڸ� �����ϰ� ��¥ ���� ������ �����մϴ�.
    
    �⺻ ��¥ ǥ�� ������ DD-MON-RR(��-��-��)
    (����-ȯ�漳��-�����ͺ��̽�-NLS)
*/

SELECT last_name, job_id, department_id
FROM employees
WHERE last_name = 'Whalen';

SELECT last_name, hire_date
FROM employees
WHERE hire_date = '03/06/17';

/*
�� ������
    Ư�� ǥ������ �ٸ� ���̳� ǥ���İ� ���ϴ� ���ǿ��� ���˴ϴ�.
    
    =   ����
    >   ���� ŭ
    >=  ���� ũ�ų� ����
    <   ���� ����
    <=  ���� �۰ų� ����
    <>  ���� ����
    BETWEEN ... AND ... �� �� ����(��谪 ����)
    IN(set)             �� ����Ʈ �� ��ġ�ϴ� �� �˻�
    LIKE                ��ġ�ϴ� ���� ���� �˻�
    IS NULL             NULL ������ ����
    
*/
--�� ������ ���
select last_name, salary
from employees
where salary <= 3000;

-- BETWEEN  �����ڸ� ����ϴ� ���� ����
select last_name, salary
from employees
where salary BETWEEN 2500 AND 3500;

select last_name, salary
from employees
where salary >= 2500 
AND salary <= 3500;

-- IN �����ڸ� ����ϴ� ��� ����
select employee_id, last_name, salary, manager_id
from employees
where manager_id IN (100, 101, 201);

select employee_id, last_name, salary, manager_id
from employees
where manager_id = 100
OR manager_id = 101         -- AND: �� ������ ��� ���� �� ��
OR manager_id = 201;        -- OR : �� �� �ϳ��� ���̾ ��

/*
LIKE �����ڸ� ����Ͽ� ���� ��ġ
    LIKE �����ڸ� ����Ͽ� ��ȿ�� �˻� ���ڿ� ���� ��ü ���� �˻��� �����մϴ�.
    �˻� ���ǿ��� ���ͷ� ���ڳ� ���ڰ� ���Ե� �� �ֽ��ϴ�.
        - % : 0�� �̻��� ���ڸ� ��Ÿ���ϴ�.
        - _ : �� ���ڸ� ��Ÿ���ϴ�.
        
*/
select first_name
from employees
where first_name LIKE 'A%';     -- A�� �����ϰ� �ڿ� ���ڰ� �� ���̵� �̾����� �͵� ��ȸ

select first_name
from employees
where first_name LIKE '%a%';     -- ��� ���� a�� ���� �͵� ��ȸ

--��ü ���� ����
select last_name
from employees
where last_name LIKE '_o%';     -- �ι�° ���ڰ� o�� �͵� ��ȸ

 -- ESCAPE �ĺ���
select employee_id, last_name, job_id
from employees
where job_id LIKE '%SA\_%' ESCAPE '\';  -- LIKE���� �� ����_�� �ƴ϶� �����_ ���ڸ� ��ȸ�ϰ� ���� �� �ĺ��� �ʿ��ѵ�, �ĺ��ڸ� \�� ������ ��  --�����: SA_MAN , SA_REP

/*
NULL ���� ���
    IS NULL �����ڷ� NULL�� �׽�Ʈ �մϴ�.
*/
select last_name, manager_id, salary
from employees
where manager_id IS NULL;   -- NULL ������ ��ȸ �� = NULL �ϸ� �� �ȴ�.

/*
�� �����ڸ� ����Ͽ� ���� ����
    AND : ���� ��� ������ ��� ���� ��� TRUE ��ȯ
    OR  : ���� ��� ���� �� �ϳ��� ���� ��� TRUE ��ȯ
    NOT : ������ ������ ��� TRUE ��ȯ
    
*/
-- AND ������ ���
select employee_id, last_name, job_id, salary
from employees
where salary >= 10000
AND job_id LIKE '%MAN%';

-- OR ������ ���
select employee_id, last_name, job_id, salary, 10000*12*1200 as test
from employees
where salary >= 10000
OR job_id LIKE '%MAN%';

-- NOT ������ ���
select last_name, job_id
from employees
where job_id NOT IN ('IT_PROG', 'ST_CLERK', 'SA_REP');      --IN(set) �� �ϳ��� �ش���� �ʴ� ���� ��ȸ(����)





