-- ��� �̸��� JONES�� ����� �޿� ����ϱ�
SELECT  SAL
FROM EMP 
WHERE ENAME = 'JONES';

-- �޿��� 2975���� ���� ��� ���� ����ϱ�
SELECT *
FROM EMP
WHERE SAL > 2975;

-- ���������� JONES�� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ� 
SELECT * 
FROM EMP
WHERE SAL > ( SELECT SAL FROM EMP WHERE ENAME='JONES');

-- ���� ���� ��� ���� ��¥���� ���
SELECT  *
FROM EMP 
WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'JONES');

-- ��� �޿����� ���� �޴� ��� ���
SELECT * 
FROM EMP
WHERE SAL > (SELECT AVG(SAL) FROM EMP);

SELECT *
FROM EMP, DEPT
WHERE DEPTNO = 20 AND SAL > (SELECT AVG(SAL) FROM EMP);

SELECT  D.DNAME, E.ENAME, E.SAL
FROM EMP E JOIN DEPT D ON(E.DEPTNO = D.DEPTNO)
WHERE
 	E.DEPTNO = 20 AND 
 	E.SAL > (SELECT AVG(SAL) FROM EMP );
 
 -- �������� �ȿ��� �Լ��� ����� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 20
AND E.SAL > (SELECT AVG(SAL) FROM EMP);

-- IN ������ ����ϱ� "�� �μ��� �ְ� �޿�"(SUBQUERY) �� ������ �޿��� �޴� ��� ���� ����ϱ�
SELECT MAX(SAL)
FROM EMP
GROUP BY DEPTNO;


SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)FROM EMP GROUP BY DEPTNO);
	
-- ANY ������ ����ϱ�
SELECT *
FROM EMP
WHERE SAL = ANY(SELECT MAX(SAL)FROM EMP GROUP BY DEPTNO);
	

-- SOME ������ ����ϱ�
SELECT *
FROM EMP
WHERE SAL = SOME(SELECT MAX(SAL)FROM EMP GROUP BY DEPTNO);
	
-- 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ��� ���� ����ϱ�

SELECT SAL
FROM EMP WHERE DEPTNO =30;

SELECT *
FROM EMP
WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO;

-- �μ���ȣ�� 30���� ������� �ּ� �޿����� �� ���� �޿��� �޴� ��� ����ϱ�
SELECT *
FROM EMP
WHERE DEPTNO = 30;

SELECT *
FROM EMP
WHERE SAL < ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);

-- ���������� ��� ���� �ϳ� �̻� �����ϸ� ���ǽ��� true, �������� ������ false
SELECT *
FROM EMP
WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO = 10);

-- ���긮���� ��� ���� �������� �ʴ°�� (50�� �μ��� ������������)
SELECT *
FROM EMP
WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO = 50);

-- ���߿� �������� MULTIPLE-COLUMN SUBQUERY
-- ���������� SELECT ���� ���� �����͸� ���� �� �����ϴ� ���
SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- FROM ���� ����ϴ� ��������
-- inline view, �ַ� ��Ī�� �ٿ����
-- �ζ��� �� ����ϱ�
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
	 (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

-- WITH�� , �������� ���� �ζ��� �並 FROM ���� �и��ؼ� ���

WITH 
 E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
 D   AS (SELECT * FROM DEPT)
 SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
 FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO; 