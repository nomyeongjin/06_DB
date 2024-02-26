/* SELECT(조회)
 * 
 * - 지정된 테이블에서 원하는 데이터를 선택해서 조회하는 SQL
 * 
 * - 데이터를 조회하면 행, 열 데이터가 조회됨
 *   -> 조회된 결과 행의 집합 == RESULT SET (결과 집합)
 * 
 * - RESULT SET은 0행 이상이 포함 될 수 있다.
 *   -> 조건에 맞는 행이 없을 수도 있기 때문에
 */

/* [SELECT 작성법 - 1(기초)]
 * 
 * SELECT 컬럼명, 컬럼명, .... FROM 테이블명
 * -> 지정된 테이블 모든 행의 컬럼명이 일치하는 컬럼 값 조회
 * 
 * 
 */

-- EMPLOYEE 테이블에서 
-- 모든 행의 사번 (EMP_ID), 이름 (EMP_NAME), 급여 (SALARY) 조회
SELECT EMP_ID, EMP_NAME, SALARY FROM EMPLOYEE;


-- EMPLOYEE 테이블에서 
-- 모든 행의 이름 (EMP_NAME), 입사일 (HIRE_DATE) 조회
SELECT EMP_NAME, HIRE_DATE FROM EMPLOYEE;

-- EMPLOYEE 테이블의 모든 행, 모든 컬럼 조회

-- asterisk (*) : 모든, 포함하다의 뜻을 나타내는 기호

SELECT * FROM EMPLOYEE;

-- DEPARTMENT TABLE의 부서코드, 부서명 조회
SELECT DEPT_ID, DEPT_TITLE FROM DEPARTMENT;

-- DEPARTMENT 테이블의 모든 데이터 조회
SELECT * FROM DEPARTMENT;

------------------------------------------------------------------------

/* 컬럼 값 산술 연산 */

-- 컬럼 값 : 행과 열이 교차되는 테이블의 한 칸에 작성된 값

-- SELECT문 작성 시 
-- 컬럼명에 산술 연산을 직접 작성하면
-- 조회 결과(RESULT SET)에 연산 결과가 반영되어 조회된다

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 급여, 급여 + 100만 조회

SELECT EMP_NAME , SALARY , SALARY +1000000 FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 모든 사원의 사번, 이름, 연봉 (급여 * 12) 조회
SELECT EMP_ID ,EMP_NAME , (SALARY*12) FROM EMPLOYEE;

----------------------------------------------------------------

/* SYSDATE, STSTIMESTAMP */
-- (시스템이 나타내고 있는 현재 시간)

-- SYSDATE		  : 
-- SYSTIMESTAMP :

/* DUAL(DUmmy tAbLe) 테이블 */
-- 가짜 테이블(임시 테이블)
-- 실존하는 테이블이 아님
-- 테이블 데이터가 아닌 단순 데이터 조회 시 사용

SELECT SYSDATE, SYSTIMESTAMP 
FROM DUAL;

/* 날짜 데이터 연산하기 (+,- 만 가능!) */
---> +1 == 1일 추가
---> -1 == 1일 감소
---> 일 단위로 계산

-- 어제, 현재 시간, 내일, 모레 조회
SELECT SYSDATE - 1, SYSDATE, SYSDATE + 1 , SYSDATE + 2
FROM DUAL;

-- 현재 시간, 한 시간 후, 1분 후, 10초 후 조회
SELECT SYSDATE,
			 SYSDATE +1/24,
			 SYSDATE +1/24/60,
			 SYSDATE +1/24/60/60*10
FROM DUAL;

/* 날짜 끼리 연산하기 */
-- 날짜 - 날짜 == 일 단위 숫자

-- TO_DATE('문자열','패턴') :
-- '문자열'을 '패턴' 형태로 해석해서 DATE 타입으로 변경하는 함수

-- '' : 문자열 리터럴 표기법
SELECT '2024-02-26', TO_DATE('2024-02-26','YYYY-MM-DD') 
FROM DUAL;

-- 오늘 - 어제 (24시간 차이) == 1
SELECT TO_DATE('2024-02-26', 'YYYY-MM-DD')
				- TO_DATE('2024-02-25', 'YYYY-MM-DD')
FROM DUAL;

-- 현재 시간 - 어제 0시 0분 0초 = 1.5290972222
SELECT SYSDATE - TO_DATE('2024-02-25', 'YYYY-MM-DD')
FROM DUAL;

-- EMPLOYEE 테이블에서
-- 모든 사원의 이름, 입사일, 근무 일수 (현재 시간 - 입사일)
SELECT EMP_NAME , HIRE_DATE, SYSDATE - HIRE_DATE  FROM EMPLOYEE;

-- CEIL (숫자) : 올림 처리
-- 현재 시간 - 생년월일
SELECT CEIL((SYSDATE - TO_DATE('1999-02-23', 'YYYY-MM-DD'))/365)
FROM DUAL;

---------------------------------------------------------------------------

/* 컬럼명 별칭 지정하기 */

-- 별칭 지정 방법
-- 1) 컬럼명 AS 별칭   :  문자O, 띄어쓰기 X, 특수문자 X
-- 2) 컬럼명 AS "별칭" : 	문자O, 띄어쓰기 O, 특수문자 O
-- 3) 컬럼명 별칭      : 	문자O, 띄어쓰기 X, 특수문자 X
-- 4) 컬럼명 "별칭"    :  문자O, 띄어쓰기 O, 특수문자 O

-- "" 의미 (""사이 글자 그대로 인식)
-- 1) 대/소문자 구분
-- 2) 특수문자, 띄어쓰기 인식

SELECT CEIL((SYSDATE - TO_DATE('1999-02-23', 'YYYY-MM-DD'))/365) AS 나이
FROM DUAL;


-- EMPLOYEE 테이블에서
-- 사번, 사원 이름, 급여, 연봉(급여*12) 조회
-- 컬럼명은 작성된 그대로 조회

SELECT 
	EMP_ID AS 사번, EMP_NAME AS "사원 이름", SALARY * 12 AS "연봉(급여*12)"
FROM EMPLOYEE;

------------------------------------------------------------------

/* 연결 연산자 (||) */
-- 문자열 이어쓰기 ( + 로 연결 X)

SELECT EMP_ID || EMP_NAME 
FROM EMPLOYEE;

--------------------------------------------------------------------

/* 컬럼명 자리에 리터럴 직접 작성 */
-- 조회 결과(RESULT SET)의 모든 행에
-- 컬럼명 자리에 작성한 리터럴 값이 추가 된다

SELECT EMP_NAME , SALARY , '원'
FROM EMPLOYEE;


-----------------------------------------------------------------------

/* DISTINCT (별개의, 전혀 다른) */
--> 중복 제거

-- 조회 결과 집합(RESULT SET)에서
-- 지정된 컬럼의 값이 중복되는 경우
-- 이를 한 번만 표시할 때 사용

-- EMPLOYEE 테이블에서
-- 모든 사원의 부서 코드 조회
SELECT DEPT_CODE 
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서
-- 사원이 있는 부서 코드만 조회

-- SELECT * FROM DEPARTMENT;
SELECT DISTINCT DEPT_CODE 
FROM EMPLOYEE;


-- EMPLOYEE 테이블에 존재하는
-- 직급 코드의 종류를 조회

SELECT DISTINCT JOB_CODE 
FROM EMPLOYEE;


--------------------------------------------------------------------

/******************/
/**** WHERE 절 ****/
/******************/

-- 테이블에서 조건을 충족하는 행을 조회할 때 사용
-- WHERE절에는 조건식(true/false)만 작성

-- 비교 연산자 : >, <, >=, <=, = (같다), !=, <> (같지 않다)
-- 논리 연산자 : AND, OR, NOT

/* [SELECT 작성법 - 2]
 * 
 * SELECT 컬럼명, 컬럼명, ...
 * FROM 테이블명
 * WHERE 조건식;
 * 
 * -> 지정된 테이블 모든 행에서 
 *   컬럼명이 일치하는 컬럼 값 조회
 * */

-- EMPLOYEE 테이블에서
-- 급여가 300만원을 초과하는 사원의
-- 사번, 이름, 급여, 부서코드 조회



/*3*/SELECT  EMP_ID , EMP_NAME , SALARY , DEPT_CODE 
/*1*/FROM EMPLOYEE
/*2*/WHERE SALARY > 3000000;

 /* 지정된 테이블에서
  * WHERE절로 행을 먼저 추려내고
  * 추려진 결과 행을 먼저 추려내고
  * 추려진 결과 행들 중에서
  * SELECT절에 원하는 컬럼만 조회
  */

-- EMPLOYEE 테이블에서 연봉이 5천만원 이하인 사원의
-- 사번, 이름, 연봉 조회
SELECT EMP_ID , EMP_NAME , SALARY * 12 연봉
FROM EMPLOYEE
WHERE SALARY*12 <= 50000000;
   


-- EMPLOYEE 테이블에서
-- 부서코드가 'D9'이 아닌 사원의
-- 이름, 부서코드, 전화번호 조회
SELECT EMP_ID , DEPT_CODE , PHONE 
FROM EMPLOYEE
WHERE DEPT_CODE != 'D9';



-------------------
/* NULL 비교하기 */
-------------------
-- 컬럼명 = NULL / 컬럼명 != NULL (X)
  --> =, !=, < 등의 비교 연산자는 값을 비교하는 연산자
  --> DB에서 NULL은 값 X, 저장된 값이 없다라는 의미

-- 컬럼 명 IS NULL / 컬럼명 IS NOT NULL (O)
  --> 컬럼 값이 존재하지 않는 경우 / 존재하는 경우

-- EMPLOYEE 테이블에서 DEPT_CODE가 없는 사원 조회
SELECT EMP_NAME , DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL;

-- EMPLOYEE 테이블에서 DEPT_CODE가 있는 사원 조회
SELECT EMP_NAME , DEPT_CODE 
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

-------------------------------------------------

/* 논리 연산자 사용(AND, OR) */

-- EMPLOYEE 테이블에서
-- 부서 코드가 'D6'인 사원 중
-- 급여가 300만을 초과하는 사원의
-- 이름, 부서코드, 급여 조회

SELECT EMP_NAME , DEPT_CODE , SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6' AND SALARY > 3000000;

-- EMPLOYEE 테이블에서
-- 급여가 300만 이상, 500만 이하인 사원의
-- 사번, 이름, 급여 조회
SELECT EMP_ID , EMP_NAME , SALARY 
FROM EMPLOYEE
WHERE SALARY >= 3000000 AND SALARY <=5000000

-- EMPLOYEE 테이블에서
-- 급여가 300만 미만, 500만 초과인 사원의
-- 사번, 이름, 급여 조회
SELECT EMP_ID , EMP_NAME , SALARY 
FROM EMPLOYEE
WHERE SALARY < 3000000 
OR    SALARY > 5000000;



