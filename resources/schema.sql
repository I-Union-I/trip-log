-- 공용 DB
DROP USER C##IUNIONI;
CREATE USER C##IUNIONI IDENTIFIED BY IUNIONI;
GRANT CONNECT, RESOURCE TO C##IUNIONI;
ALTER USER C##IUNIONI QUOTA UNLIMITED ON USERS;

--------------------------------------------------------------------------

-- 회원 테이블
DROP TABLE TB_MEMBER;
CREATE TABLE TB_MEMBER (
	MEMBER_ID NUMBER PRIMARY KEY,
	EMAIL VARCHAR2(100) UNIQUE NOT NULL,
	PASSWORD VARCHAR2(100) NOT NULL,
	ROLE VARCHAR2(10) DEFAULT 'MEMBER' NOT NULL CHECK(ROLE IN ('ADMIN','MEMBER')),
	NICKNAME VARCHAR2(40),
	BIRTHDAY DATE,
	PHONE CHAR(13),
	CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	DELETED_AT DATE,
	COUNTRY_ID REFERENCES TR_COUNTRY(COUNTRY_ID)
);

COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '회원번호';
COMMENT ON COLUMN TB_MEMBER.EMAIL IS '이메일';
COMMENT ON COLUMN TB_MEMBER.PASSWORD IS '비밀번호';
COMMENT ON COLUMN TB_MEMBER.ROLE IS '관리자/회원';
COMMENT ON COLUMN TB_MEMBER.NICKNAME IS '닉네임';
COMMENT ON COLUMN TB_MEMBER.BIRTHDAY IS '생일';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '연락처';
COMMENT ON COLUMN TB_MEMBER.CREATED_AT IS '생성일';
COMMENT ON COLUMN TB_MEMBER.DELETED_AT IS '탈퇴일';
COMMENT ON COLUMN TB_MEMBER.COUNTRY_ID IS '국가번호';

-- 회원 테이블 시퀀스
DROP SEQUENCE SEQ_MEM_ID;
CREATE SEQUENCE SEQ_MEM_ID;

--------------------------------------------------------------------------

-- 게시판 테이블
DROP TABLE TB_POST;
CREATE TABLE TB_POST (
	POST_ID NUMBER PRIMARY KEY,
	TITLE VARCHAR2(100) NOT NULL,
	CONTENT CLOB NOT NULL,
	VIEWS NUMBER NOT NULL,
	CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	MEMBER_ID REFERENCES TB_MEMBER(MEMBER_ID) NOT NULL,
	COUNTRY_ID REFERENCES TR_COUNTRY(COUNTRY_ID) NOT NULL
);

COMMENT ON COLUMN TB_POST.POST_ID IS '게시글 번호';
COMMENT ON COLUMN TB_POST.TITLE IS '게시글 제목';
COMMENT ON COLUMN TB_POST.CONTENT IS '게시글 내용';
COMMENT ON COLUMN TB_POST.VIEWS IS '조회수';
COMMENT ON COLUMN TB_POST.CREATED_AT IS '작성일';
COMMENT ON COLUMN TB_POST.MEMBER_ID IS '회원번호';
COMMENT ON COLUMN TB_POST.COUNTRY_ID IS '국가번호';

-- 게시판 테이블 시퀀스
DROP SEQUENCE SEQ_POST_ID;
CREATE SEQUENCE SEQ_POST_ID;

--------------------------------------------------------------------------

-- 댓글 테이블
DROP TABLE TB_COMMENT;
CREATE TABLE TB_COMMENT (
	COMMENT_ID NUMBER PRIMARY KEY,
	CONTENT VARCHAR2(300) NOT NULL,
	CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	PARENT_ID NUMBER REFERENCES TB_COMMENT(COMMENT_ID),
	POST_ID NUMBER REFERENCES TB_POST(POST_ID) NOT NULL,
	MEMBER_ID NUMBER REFERENCES TB_MEMBER(MEMBER_ID) NOT NULL
);

COMMENT ON COLUMN TB_COMMENT.COMMENT_ID IS '댓글 번호';
COMMENT ON COLUMN TB_COMMENT.CONTENT IS '댓글 내용';
COMMENT ON COLUMN TB_COMMENT.CREATED_AT IS '작성일';
COMMENT ON COLUMN TB_COMMENT.PARENT_ID IS '부모댓글 아이디';
COMMENT ON COLUMN TB_COMMENT.POST_ID IS '게시글 번호';
COMMENT ON COLUMN TB_COMMENT.MEMBER_ID IS '회원 번호';

-- 댓글 테이블 시퀀스
DROP SEQUENCE SEQ_COMMENT_ID;
CREATE SEQUENCE SEQ_COMMENT_ID;

--------------------------------------------------------------------------

-- 댓글 공감 테이블
DROP TABLE TB_COMMENT_LIKE;
CREATE TABLE TB_COMMENT_LIKE (
	COMMENT_LIKE_ID NUMBER PRIMARY KEY,
	CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	MEMBER_ID REFERENCES TB_MEMBER(MEMBER_ID) NOT NULL,
	COMMENT_ID REFERENCES TB_COMMENT(COMMENT_ID) NOT NULL,
	CONSTRAINT COM_LIKE_UNQ UNIQUE(MEMBER_ID, COMMENT_ID)
);

COMMENT ON COLUMN TB_COMMENT_LIKE.COMMENT_LIKE_ID IS '댓글 공감 번호';
COMMENT ON COLUMN TB_COMMENT_LIKE.CREATED_AT IS '공감 날짜';
COMMENT ON COLUMN TB_COMMENT_LIKE.MEMBER_ID IS '회원 번호';
COMMENT ON COLUMN TB_COMMENT_LIKE.COMMENT_ID IS '댓글 번호';

-- 댓글 공감 테이블 시퀀스
DROP SEQUENCE SEQ_COM_LIKE_ID;
CREATE SEQUENCE SEQ_COM_LIKE_ID;

-- 게시글 공감 테이블
DROP TABLE TB_POST_LIKE;
CREATE TABLE TB_POST_LIKE (
	POST_LIKE_ID NUMBER PRIMARY KEY,
	CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	MEMBER_ID REFERENCES TB_MEMBER(MEMBER_ID) NOT NULL,
	POST_ID REFERENCES TB_POST(POST_ID) NOT NULL,
	CONSTRAINT POST_LIKE_UNQ UNIQUE(MEMBER_ID, POST_ID)
);

COMMENT ON COLUMN TB_POST_LIKE.POST_LIKE_ID IS '게시글 공감 번호';
COMMENT ON COLUMN TB_POST_LIKE.CREATED_AT IS '공감 날짜';
COMMENT ON COLUMN TB_POST_LIKE.MEMBER_ID IS '회원 번호';
COMMENT ON COLUMN TB_POST_LIKE.POST_ID IS '댓글 번호';

-- 게시글 공감 테이블 시퀀스
DROP SEQUENCE SEQ_POST_LIKE_ID;
CREATE SEQUENCE SEQ_POST_LIKE_ID;

--------------------------------------------------------------------------

-- 대륙 테이블
DROP TABLE TR_CONTINENT;
CREATE TABLE TR_CONTINENT (
	CONTINENT_ID NUMBER PRIMARY KEY,
	NAME VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN TR_CONTINENT.CONTINENT_ID IS '대륙 번호';
COMMENT ON COLUMN TR_CONTINENT.NAME IS '대륙명';

-- 대륙 테이블 시퀀스
DROP SEQUENCE SEQ_CONTINENT_ID;
CREATE SEQUENCE SEQ_CONTINENT_ID;

-- 국가 테이블
DROP TABLE TR_COUNTRY;
CREATE TABLE TR_COUNTRY (
	COUNTRY_ID NUMBER PRIMARY KEY,
	NAME VARCHAR2(50) NOT NULL,
	CONTINENT_ID REFERENCES TR_CONTINENT(CONTINENT_ID) NOT NULL
);

COMMENT ON COLUMN TR_COUNTRY.COUNTRY_ID IS '국가 번호';
COMMENT ON COLUMN TR_COUNTRY.NAME IS '국가명';
COMMENT ON COLUMN TR_COUNTRY.CONTINENT_ID IS '대륙 번호';

-- 국가 테이블 시퀀스
DROP SEQUENCE SEQ_COUNTRY_ID;
CREATE SEQUENCE SEQ_COUNTRY_ID;

--------------------------------------------------------------------------

-- 상품 테이블
DROP TABLE TB_PRODUCT;
CREATE TABLE TB_PRODUCT (
	PRODUCT_ID NUMBER PRIMARY KEY,
	NAME VARCHAR2(100) NOT NULL,
	PRICE NUMBER NOT NULL,
	STOCK NUMBER NOT NULL,
	DESCRIPTION CLOB NOT NULL,
	CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	MEMBER_ID REFERENCES TB_MEMBER(MEMBER_ID) NOT NULL,
	COUNTRY_ID REFERENCES TR_COUNTRY(COUNTRY_ID) NOT NULL
);

COMMENT ON COLUMN TB_PRODUCT.PRODUCT_ID IS '상품 번호';
COMMENT ON COLUMN TB_PRODUCT.NAME IS '상품명';
COMMENT ON COLUMN TB_PRODUCT.PRICE IS '가격';
COMMENT ON COLUMN TB_PRODUCT.STOCK IS '상품 재고';
COMMENT ON COLUMN TB_PRODUCT.DESCRIPTION IS '상품 설명';
COMMENT ON COLUMN TB_PRODUCT.CREATED_AT IS '등록 날짜';
COMMENT ON COLUMN TB_PRODUCT.MEMBER_ID IS '회원 번호';
COMMENT ON COLUMN TB_PRODUCT.COUNTRY_ID IS '나라 번호';

-- 상품 테이블 시퀀스
DROP SEQUENCE SEQ_PRODUCT_ID;
CREATE SEQUENCE SEQ_PRODUCT_ID;

--------------------------------------------------------------------------

-- 상품 후기 테이블
DROP TABLE TB_PRODUCT_REVIEW;
CREATE TABLE TB_PRODUCT_REVIEW (
	PRODUCT_REVIEW_ID NUMBER PRIMARY KEY,
	SCORE NUMBER NOT NULL,
	MEMBER_ID REFERENCES TB_MEMBER(MEMBER_ID) NOT NULL,
	PRODUCT_ID REFERENCES TB_PRODUCT(PRODUCT_ID) NOT NULL
);

COMMENT ON COLUMN TB_PRODUCT_REVIEW.PRODUCT_REVIEW_ID IS '상품 리뷰 번호';
COMMENT ON COLUMN TB_PRODUCT_REVIEW.SCORE IS '별점';
COMMENT ON COLUMN TB_PRODUCT_REVIEW.MEMBER_ID IS '회원 번호';
COMMENT ON COLUMN TB_PRODUCT_REVIEW.PRODUCT_ID IS '상품 번호';

-- 상품 후기 테이블 시퀀스
DROP SEQUENCE SEQ_PRODUCT_REVIEW_ID;
CREATE SEQUENCE SEQ_PRODUCT_REVIEW_ID;

--------------------------------------------------------------------------

-- 상품 찜 테이블
DROP TABLE TB_PRODUCT_FAVORITES;
CREATE TABLE TB_PRODUCT_FAVORITES (
	PRODUCT_FAVORITES_ID NUMBER PRIMARY KEY,
	CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	PRODUCT_ID REFERENCES TB_PRODUCT(PRODUCT_ID) NOT NULL,
	MEMBER_ID REFERENCES TB_MEMBER(MEMBER_ID) NOT NULL
);

COMMENT ON COLUMN TB_PRODUCT_FAVORITES.PRODUCT_FAVORITES_ID IS '상품 찜 번호';
COMMENT ON COLUMN TB_PRODUCT_FAVORITES.CREATED_AT IS '찜 날짜';
COMMENT ON COLUMN TB_PRODUCT_FAVORITES.PRODUCT_ID IS '상품 번호';
COMMENT ON COLUMN TB_PRODUCT_FAVORITES.MEMBER_ID IS '회원 번호';

-- 상품 찜 테이블 시퀀스
DROP SEQUENCE SEQ_PRO_FAVOR_ID;
CREATE SEQUENCE SEQ_PRO_FAVOR_ID;

--------------------------------------------------------------------------

-- 결제 기록 테이블
DROP TABLE TB_PAYMENT_RECORD;
CREATE TABLE TB_PAYMENT_RECORD (
	PAYMENT_RECORD_ID NUMBER PRIMARY KEY,
	AMOUNT NUMBER NOT NULL,
	METHOD VARCHAR2(20) NOT NULL,
	STATUS VARCHAR2(20) NOT NULL,
	CREATED_AT DATE DEFAULT SYSDATE NOT NULL,
	PRODUCT_ID REFERENCES TB_PRODUCT(PRODUCT_ID) NOT NULL,
	MEMBER_ID REFERENCES TB_MEMBER(MEMBER_ID) NOT NULL
);

COMMENT ON COLUMN TB_PAYMENT_RECORD.PAYMENT_RECORD_ID IS '결제 기록 번호';
COMMENT ON COLUMN TB_PAYMENT_RECORD.AMOUNT IS '주문 수량';
COMMENT ON COLUMN TB_PAYMENT_RECORD.METHOD IS '결제 수단';
COMMENT ON COLUMN TB_PAYMENT_RECORD.STATUS IS '결제 상태';
COMMENT ON COLUMN TB_PAYMENT_RECORD.CREATED_AT IS '결제 날짜';
COMMENT ON COLUMN TB_PAYMENT_RECORD.PRODUCT_ID IS '상품 번호';
COMMENT ON COLUMN TB_PAYMENT_RECORD.MEMBER_ID IS '회원 번호';

-- 결제 기록 테이블 시퀀스
DROP SEQUENCE SEQ_PAY_RECORD_ID;
CREATE SEQUENCE SEQ_PAY_RECORD_ID;

--------------------------------------------------------------------------