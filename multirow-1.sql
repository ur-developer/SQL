-- ������ �Լ�

SELECT ENAME, SUM(SAL) FROM EMP;

SELECT * FROM EMP;

SELECT COUNT(COMM) FROM EMP;

SELECT COUNT(*)  -- ���� ������ �˷��޶�, TABLE DATA ���� ����ϱ�
FROM EMP;

SELECT COUNT(*)
FROM EMP
WHERE DEPTNO = 30;

SELECT COUNT(DISTINCT SAL),
	   COUNT(ALL SAL),
	   COUNT(SAL)
FROM EMP;

SELECT COUNT(COMM)  -- COUNT �Լ��� ����Ͽ� �߰� ���� �� ���� ����ϱ�
FROM EMP;

SELECT COUNT(*) FROM EMP 
WHERE COMM IS NOT NULL;

-- �ִ밪�� �ּҰ��� ���ϴ� MAX, MIN �Լ�

SELECT MAX(SAL) FROM EMP -- �μ� ��ȣ�� 10���� ������� �ִ� �޿� ����ϱ�
WHERE DEPTNO = 10;

SELECT MIN(SAL) FROM EMP  -- �μ� ��ȣ�� 10���� ������� �ּ� �޿� ����ϱ�
WHERE DEPTNO = 10;

 SELECT MAX(HIREDATE) -- �μ� ��ȣ�� 20�� ����� �Ի��� �� ���� �ֱ� �Ի��� ����ϱ� 
 FROM EMP
 WHERE DEPTNO = 20;
 
SELECT MIN(HIREDATE)
FROM EMP
WHERE DEPTNO = 20;

-- ��հ��� ���ϴ� AVG�Լ�

SELECT AVG(SAL) FROM EMP
WHERE DEPTNO = 30;

-- ��� ���� ���ϴ� ���� ���� ����ϴ� GROUP BY

SELECT DEPTNO, AVG(SAL)
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, COUNT(*) --�μ��� ������, POST(�׷��)�� ����� ��
FROM EMP
GROUP BY DEPTNO;

SELECT DEPTNO, COUNT(*) ECOUNT
FROM EMP
GROUP BY DEPTNO
ORDER BY ECOUNT DESC;

-- �μ� ��ȣ �� ��å��, ��� �޿��� �����ϱ�

SELECT DEPTNO, JOB, AVG(SAL) 
FROM EMP
GROUP BY DEPTNO, JOB
ORDER BY JOB;

SELECT DEPTNO, JOB, COUNT(*)
FROM EMP 
GROUP BY DEPTNO, JOB
ORDER BY JOB;

-- GROUP BY���� ������ �� �� ����ϴ� HAVING��

-- �� �μ��� ��å�� ��� �޿��� ���ϵ� �� ��� �޿��� 2000 �̻��� �׷츸 ����ϱ�
SELECT DEPTNO, JOB, AVG(SAL)             
FROM EMP e 
GROUP BY DEPTNO , JOB 
HAVING AVG(SAL) >= 2000 -- HAVING ���� ASAL ����
ORDER BY DEPTNO, JOB;

-- WHERE ���� HAVING���� ������

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) > 2000
ORDER BY DEPTNO, JOB;

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
WHERE SAL <= 3000
GROUP BY DEPTNO, JOB
HAVING AVG(SAL) > 2000
ORDER BY DEPTNO, JOB;