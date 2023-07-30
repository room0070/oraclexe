/*
���ϸ�: ex03-select-orderby.sql

ORDER By ��
    ORDER BY ���� ����Ͽ� �˻��� ���� �����մϴ�.
        ASC  : ��������, �⺻��
        DESC : ��������
    SELECT ���� �� �������� �ɴϴ�.
    
[SELECT �� �⺻����]                        �ν� ����            --[]�� �ᵵ �ǰ� �� �ᵵ �Ǵ� �ֵ�.
SELECT [DISTICT] | �÷���1, �÷���2 ...        .5
FROM ���̺��                                 .1
WHERE ������                                  .2
GROUP BY �÷���                               .3
HAVING ������                                 .4
ORDER BY �÷��� [ASC|DESC]                    .6
*/
select last_name, job_id, department_id, hire_date
from employees
ORDER BY hire_date;     -- hire_date �������� �⺻(��������) ����

-- �������� ����
select last_name, job_id, department_id, hire_date
from employees
ORDER BY hire_date DESC;    --ū ������ ����

-- �� alias(��Ī)�� �������� ����
select employee_id, last_name, salary*12 annsal
from employees
ORDER BY annsal;
--where���� ��Ī ��� �� �ǰ� ORDER BY���� ����(�ν� ���� ����)


-- �� ���� ��ġ�� ����Ͽ� ����
select last_name, job_id, department_id, hire_date      --last_name : 1 / job_id : 2 / hire_date : 4��
from employees
ORDER BY 3;     --�÷��� ��� ���� ����ϸ� select�� ���� �÷� ������� ��ȣ�� �Ű��� �־� 3��(=department_id) �������� ���ĵȴ�.

-- ���� ���� �������� ����
select last_name, job_id, department_id, salary
from employees
ORDER BY department_id, salary DESC;    --department_id �� ���� ���� �� �� �ȿ��� department_id �� ���� ��� salary �������� �������� ���� 






