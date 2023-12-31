-- 사원 이름이 JONES인 사원의 급여 출력하기
SELECT  SAL
FROM EMP 
WHERE ENAME = 'JONES';

-- 급여가 2975보다 높은 사원 정보 출력하기
SELECT *
FROM EMP
WHERE SAL > 2975;

-- 서브쿼리로 JONES의 급여보다 높은 급여를 받는 사원 정보 출력하기 
SELECT * 
FROM EMP
WHERE SAL > ( SELECT SAL FROM EMP WHERE ENAME='JONES');

-- 서브 쿼리 결과 값이 날짜형인 경우
SELECT  *
FROM EMP 
WHERE HIREDATE < (SELECT HIREDATE FROM EMP WHERE ENAME = 'JONES');

-- 평균 급여보다 많이 받는 사원 출력
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
 
 -- 서브쿼리 안에서 함수를 사용한 경우
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL, D.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 20
AND E.SAL > (SELECT AVG(SAL) FROM EMP);

-- IN 연산자 사용하기 "각 부서별 최고 급여"(SUBQUERY) 와 동일한 급여를 받는 사원 정보 출력하기
SELECT MAX(SAL)
FROM EMP
GROUP BY DEPTNO;


SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL)FROM EMP GROUP BY DEPTNO);
	
-- ANY 연산자 사용하기
SELECT *
FROM EMP
WHERE SAL = ANY(SELECT MAX(SAL)FROM EMP GROUP BY DEPTNO);
	

-- SOME 연산자 사용하기
SELECT *
FROM EMP
WHERE SAL = SOME(SELECT MAX(SAL)FROM EMP GROUP BY DEPTNO);
	
-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원 정보 출력하기

SELECT SAL
FROM EMP WHERE DEPTNO =30;

SELECT *
FROM EMP
WHERE SAL < ANY(SELECT SAL FROM EMP WHERE DEPTNO = 30)
ORDER BY SAL, EMPNO;

-- 부서번호가 30번인 사원들의 최소 급여보다 더 적은 급여를 받는 사원 출력하기
SELECT *
FROM EMP
WHERE DEPTNO = 30;

SELECT *
FROM EMP
WHERE SAL < ALL(SELECT SAL FROM EMP WHERE DEPTNO = 30);

-- 서브쿼리에 결과 값이 하나 이상 존재하면 조건식이 true, 존재하지 않으면 false
SELECT *
FROM EMP
WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO = 10);

-- 서브리쿼리 결과 값이 존재하지 않는경우 (50번 부서는 존재하지않음)
SELECT *
FROM EMP
WHERE EXISTS(SELECT DNAME FROM DEPT WHERE DEPTNO = 50);

-- 다중열 서브쿼리 MULTIPLE-COLUMN SUBQUERY
-- 서브쿼리의 SELECT 절에 비교할 데이터를 여러 개 지정하는 방식
SELECT *
FROM EMP
WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL) FROM EMP GROUP BY DEPTNO);

-- FROM 절에 사용하는 서브쿼리
-- inline view, 주로 별칭을 붙여사용
-- 인라인 뷰 사용하기
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10,
	 (SELECT * FROM DEPT) D
WHERE E10.DEPTNO = D.DEPTNO;

-- WITH절 , 가독성을 위해 인라인 뷰를 FROM 절에 분리해서 사용

WITH 
 E10 AS (SELECT * FROM EMP WHERE DEPTNO = 10),
 D   AS (SELECT * FROM DEPT)
 SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
 FROM E10, D
WHERE E10.DEPTNO = D.DEPTNO; 