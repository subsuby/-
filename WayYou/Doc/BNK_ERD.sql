
/* Drop Triggers */

DROP TRIGGER TRI_CAR_MST_CAR_SEQ;
DROP TRIGGER TRI_DEALER_EVAL_EVAL_SEQ;
DROP TRIGGER TRI_T2_FILE_FILE_SEQ;



/* Drop Tables */

DROP TABLE CAR_OPTION CASCADE CONSTRAINTS;
DROP TABLE USER_INTEREST CASCADE CONSTRAINTS;
DROP TABLE CAR_MST CASCADE CONSTRAINTS;
DROP TABLE DEALER_EVAL CASCADE CONSTRAINTS;
DROP TABLE T2_FILE CASCADE CONSTRAINTS;
DROP TABLE USER_INTEREST_DEALER CASCADE CONSTRAINTS;
DROP TABLE USER_RECOMMEND CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_CAR_MST_CAR_SEQ;
DROP SEQUENCE SEQ_DEALER_EVAL_EVAL_SEQ;
DROP SEQUENCE SEQ_T2_FILE_FILE_SEQ;




/* Create Sequences */

CREATE SEQUENCE SEQ_CAR_MST_CAR_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_DEALER_EVAL_EVAL_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_T2_FILE_FILE_SEQ INCREMENT BY 1 START WITH 1;



/* Create Tables */

-- 매물정보
CREATE TABLE CAR_MST
(
	-- 매물식별SEQ
	CAR_SEQ number(10,0) NOT NULL,
	-- 차량번호
	CAR_PLATE_NUM varchar2(10) NOT NULL,
	-- 차량코드
	CAR_FULL_CODE varchar2(10) NOT NULL,
	-- 차대번호
	CAR_FRAME_NUM varchar2(30) NOT NULL,
	-- 제조사
	MAKER_NAME varchar2(20),
	-- 모델명
	MODEL_NAME varchar2(30),
	-- 상세모델명
	DETAIL_MODEL_NAME varchar2(40),
	-- 등급
	GRADE_NAME varchar2(40),
	-- 차량최초등록일
	CAR_REG_DAY varchar2(8),
	-- 연식
	CAR_REG_YEAR varchar2(4),
	-- 연료
	CAR_FUEL varchar2(10),
	-- 미션
	CAR_MISSION varchar2(10),
	-- 주행거리
	USE_KM number,
	-- 원부상 주행거리
	USE_KM_WONBU number,
	-- 색상
	CAR_COLOR varchar2(20),
	-- 옵션
	CAR_OPTION varchar2(800),
	-- 사고여부
	SAGO_YN varchar2(10) DEFAULT '''0''',
	-- 판매상태
	CAR_STATE varchar2(10),
	-- 차량등록일
	APPLY_DAY varchar2(8),
	-- 차량 판매가
	SALE_AMT number,
	-- BNK인증
	BNK_CONF_YN char(1) DEFAULT 'N',
	-- 차량설명
	CAR_DESC clob,
	-- 딜러인증여부
	DEALER_CONF_YN char(1) DEFAULT 'N',
	-- 딜러인증일
	DEALER_CONF_DATE date,
	-- 회원아이디(딜러)
	USER_ID varchar2(50) NOT NULL,
	-- 매매상사NO
	SHOP_NO number NOT NULL,
	-- 압류건수
	ATTACH_CNT number(3,0) DEFAULT 0,
	-- 저당건수
	MORT_GAGE_CNT number(3,0) DEFAULT 0,
	-- 미납세금정보
	UNPAID_TAX varchar2(200),
	-- 파일아이디
	FILE_ID number,
	-- 등록자
	CREATOR varchar2(50) NOT NULL,
	-- 등록일
	CREATED_DATE date DEFAULT SYSDATE NOT NULL,
	-- 수정자
	MODIFIER varchar2(50) NOT NULL,
	-- 마지막수정일
	MODIFIED_DATE date DEFAULT SYSDATE NOT NULL,
	-- 실매물확인여부
	CAR_EXIST_YN char(1) DEFAULT 'N',
	-- 보장서비스 - 헛걸음
	CAR_GUAR_FRUITLESS_YN char(1) DEFAULT 'N',
	-- 보장서비스 - 환불
	CAR_GUAR_REFUND_YN char(1) DEFAULT 'N',
	-- 보장서비스 - 보장기간연장
	CAR_GUAR_TERM_YN char(1) DEFAULT 'N',
	-- 보장서비스 - 무상점검
	CAR_GUAR_CHECK_YN char(1) DEFAULT 'N',
	-- 매물이미지등록건수
	CAR_IMAGE_CNT number(3,0) DEFAULT 0,
	-- 외관상태
	SURFACE_STATE varchar2(10) DEFAULT '0',
	-- 렌트카 사용여부
	RENT_YN varchar2(10) DEFAULT 'N',
	-- 동영상 url
	CAR_VIDEO_URL varchar2(300),
	-- 차량지역
	CAR_AREA varchar2(10),
	-- 주차위치 - 우편번호
	PARK_ZIP varchar2(6),
	-- 주차위치 기본주소
	PARK_ADDR1 varchar2(200),
	-- 주차위치 - 상세주소
	PART_ADDR2 varchar2(300),
	PRIMARY KEY (CAR_SEQ)
);


-- 매물차량옵션
CREATE TABLE CAR_OPTION
(
	-- 매물식별SEQ
	CAR_SEQ number(10,0) NOT NULL,
	-- 옵션코드
	OPTION_CD varchar2(10) NOT NULL,
	PRIMARY KEY (CAR_SEQ, OPTION_CD)
);


-- 딜러평가
CREATE TABLE DEALER_EVAL
(
	-- 평가순번
	EVAL_SEQ number NOT NULL,
	-- 평가구분
	EVAL_DIV varchar2(10) NOT NULL,
	-- 딜러 사용자 ID
	DEALER_ID varchar2(50) NOT NULL,
	-- 사용자ID(평가자)
	USER_ID varchar2(50) NOT NULL,
	-- 평가의견
	REVIEWS varchar2(200 char),
	-- 평가점수
	RATING number(3,0) DEFAULT 0,
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE NOT NULL,
	-- 사용여부
	USE_YN char(1) DEFAULT 'Y',
	-- 삭제사유 (미사용)
	DEL_REASON varchar2(300),
	-- 삭제자
	DEL_USER_ID varchar2(50),
	-- 삭제일
	DEL_DATE date,
	PRIMARY KEY (EVAL_SEQ)
);


-- 파일정보
CREATE TABLE T2_FILE
(
	-- 파일순번
	FILE_SEQ number NOT NULL,
	-- 파일그룹ID
	FILE_GROUP_ID number DEFAULT 1 NOT NULL,
	-- 원본파일명
	ORIG_NM varchar2(512) NOT NULL,
	-- 물리파일명
	LOGI_NM varchar2(512) NOT NULL,
	-- 물리경로
	LOGI_PATH varchar2(1024) NOT NULL,
	-- 물리파일명(썸네일)
	LOGI_THUMB_NM varchar2(512),
	-- 물리경로(썸네일)
	LOGI_THUMB_PATH varchar2(1024),
	-- 타입(다운로드시 사용)
	CONTENT_TYPE varchar2(1024),
	-- 확장자
	FILE_EXT varchar2(50),
	-- FILE_SIZE
	FILE_SIZE number DEFAULT 0,
	-- 등록자
	CREATOR varchar2(50),
	-- 등록일
	CREATED_DATE date DEFAULT SYSDATE,
	-- 수정자
	MODIFIER varchar2(50),
	-- 수정일
	MODIFIED_DATE date DEFAULT SYSDATE,
	-- 사용여부
	USE_YN char(1) DEFAULT 'Y',
	PRIMARY KEY (FILE_SEQ)
);


-- 관심매물
CREATE TABLE USER_INTEREST
(
	-- 회원아이디
	USER_ID varchar2(50) NOT NULL,
	-- 매물식별SEQ
	CAR_SEQ number(10,0) NOT NULL,
	PRIMARY KEY (USER_ID, CAR_SEQ)
);


-- 관심딜러
CREATE TABLE USER_INTEREST_DEALER
(
	-- 회원아이디
	USER_ID varchar2(50) NOT NULL,
	-- 딜러 사용자 아이디
	DEALER_ID varchar2(50) NOT NULL,
	PRIMARY KEY (USER_ID, DEALER_ID)
);


-- 내게맞는매물정보
CREATE TABLE USER_RECOMMEND
(
	-- 회원아이디
	USER_ID varchar2(50) NOT NULL,
	-- 메이커코드
	MAKER_CD varchar2(3),
	-- 모델코드
	MODEL_CD varchar2(2),
	-- 세부모델코드
	DETAIL_MODEL_CD varchar2(1),
	-- 주행거리
	USE_KM number DEFAULT 0,
	-- 연식
	CAR_REG_YEAR varchar2(4),
	-- 색상
	CAR_COLOR varchar2(10),
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE NOT NULL,
	-- 수정일
	MODIFIED_DATE date DEFAULT SYSDATE NOT NULL,
	PRIMARY KEY (USER_ID)
);



/* Create Foreign Keys */

ALTER TABLE CAR_OPTION
	ADD FOREIGN KEY (CAR_SEQ)
	REFERENCES CAR_MST (CAR_SEQ)
;


ALTER TABLE USER_INTEREST
	ADD FOREIGN KEY (CAR_SEQ)
	REFERENCES CAR_MST (CAR_SEQ)
;



/* Create Triggers */

CREATE OR REPLACE TRIGGER TRI_CAR_MST_CAR_SEQ BEFORE INSERT ON CAR_MST
FOR EACH ROW
BEGIN
	SELECT SEQ_CAR_MST_CAR_SEQ.nextval
	INTO :new.CAR_SEQ
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_DEALER_EVAL_EVAL_SEQ BEFORE INSERT ON DEALER_EVAL
FOR EACH ROW
BEGIN
	SELECT SEQ_DEALER_EVAL_EVAL_SEQ.nextval
	INTO :new.EVAL_SEQ
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_T2_FILE_FILE_SEQ BEFORE INSERT ON T2_FILE
FOR EACH ROW
BEGIN
	SELECT SEQ_T2_FILE_FILE_SEQ.nextval
	INTO :new.FILE_SEQ
	FROM dual;
END;

/




/* Comments */

COMMENT ON TABLE CAR_MST IS '매물정보';
COMMENT ON COLUMN CAR_MST.CAR_SEQ IS '매물식별SEQ';
COMMENT ON COLUMN CAR_MST.CAR_PLATE_NUM IS '차량번호';
COMMENT ON COLUMN CAR_MST.CAR_FULL_CODE IS '차량코드';
COMMENT ON COLUMN CAR_MST.CAR_FRAME_NUM IS '차대번호';
COMMENT ON COLUMN CAR_MST.MAKER_NAME IS '제조사';
COMMENT ON COLUMN CAR_MST.MODEL_NAME IS '모델명';
COMMENT ON COLUMN CAR_MST.DETAIL_MODEL_NAME IS '상세모델명';
COMMENT ON COLUMN CAR_MST.GRADE_NAME IS '등급';
COMMENT ON COLUMN CAR_MST.CAR_REG_DAY IS '차량최초등록일';
COMMENT ON COLUMN CAR_MST.CAR_REG_YEAR IS '연식';
COMMENT ON COLUMN CAR_MST.CAR_FUEL IS '연료';
COMMENT ON COLUMN CAR_MST.CAR_MISSION IS '미션';
COMMENT ON COLUMN CAR_MST.USE_KM IS '주행거리';
COMMENT ON COLUMN CAR_MST.USE_KM_WONBU IS '원부상 주행거리';
COMMENT ON COLUMN CAR_MST.CAR_COLOR IS '색상';
COMMENT ON COLUMN CAR_MST.CAR_OPTION IS '옵션';
COMMENT ON COLUMN CAR_MST.SAGO_YN IS '사고여부';
COMMENT ON COLUMN CAR_MST.CAR_STATE IS '판매상태';
COMMENT ON COLUMN CAR_MST.APPLY_DAY IS '차량등록일';
COMMENT ON COLUMN CAR_MST.SALE_AMT IS '차량 판매가';
COMMENT ON COLUMN CAR_MST.BNK_CONF_YN IS 'BNK인증';
COMMENT ON COLUMN CAR_MST.CAR_DESC IS '차량설명';
COMMENT ON COLUMN CAR_MST.DEALER_CONF_YN IS '딜러인증여부';
COMMENT ON COLUMN CAR_MST.DEALER_CONF_DATE IS '딜러인증일';
COMMENT ON COLUMN CAR_MST.USER_ID IS '회원아이디(딜러)';
COMMENT ON COLUMN CAR_MST.SHOP_NO IS '매매상사NO';
COMMENT ON COLUMN CAR_MST.ATTACH_CNT IS '압류건수';
COMMENT ON COLUMN CAR_MST.MORT_GAGE_CNT IS '저당건수';
COMMENT ON COLUMN CAR_MST.UNPAID_TAX IS '미납세금정보';
COMMENT ON COLUMN CAR_MST.FILE_ID IS '파일아이디';
COMMENT ON COLUMN CAR_MST.CREATOR IS '등록자';
COMMENT ON COLUMN CAR_MST.CREATED_DATE IS '등록일';
COMMENT ON COLUMN CAR_MST.MODIFIER IS '수정자';
COMMENT ON COLUMN CAR_MST.MODIFIED_DATE IS '마지막수정일';
COMMENT ON COLUMN CAR_MST.CAR_EXIST_YN IS '실매물확인여부';
COMMENT ON COLUMN CAR_MST.CAR_GUAR_FRUITLESS_YN IS '보장서비스 - 헛걸음';
COMMENT ON COLUMN CAR_MST.CAR_GUAR_REFUND_YN IS '보장서비스 - 환불';
COMMENT ON COLUMN CAR_MST.CAR_GUAR_TERM_YN IS '보장서비스 - 보장기간연장';
COMMENT ON COLUMN CAR_MST.CAR_GUAR_CHECK_YN IS '보장서비스 - 무상점검';
COMMENT ON COLUMN CAR_MST.CAR_IMAGE_CNT IS '매물이미지등록건수';
COMMENT ON COLUMN CAR_MST.SURFACE_STATE IS '외관상태';
COMMENT ON COLUMN CAR_MST.RENT_YN IS '렌트카 사용여부';
COMMENT ON COLUMN CAR_MST.CAR_VIDEO_URL IS '동영상 url';
COMMENT ON COLUMN CAR_MST.CAR_AREA IS '차량지역';
COMMENT ON COLUMN CAR_MST.PARK_ZIP IS '주차위치 - 우편번호';
COMMENT ON COLUMN CAR_MST.PARK_ADDR1 IS '주차위치 기본주소';
COMMENT ON COLUMN CAR_MST.PART_ADDR2 IS '주차위치 - 상세주소';
COMMENT ON TABLE CAR_OPTION IS '매물차량옵션';
COMMENT ON COLUMN CAR_OPTION.CAR_SEQ IS '매물식별SEQ';
COMMENT ON COLUMN CAR_OPTION.OPTION_CD IS '옵션코드';
COMMENT ON TABLE DEALER_EVAL IS '딜러평가';
COMMENT ON COLUMN DEALER_EVAL.EVAL_SEQ IS '평가순번';
COMMENT ON COLUMN DEALER_EVAL.EVAL_DIV IS '평가구분';
COMMENT ON COLUMN DEALER_EVAL.DEALER_ID IS '딜러 사용자 ID';
COMMENT ON COLUMN DEALER_EVAL.USER_ID IS '사용자ID(평가자)';
COMMENT ON COLUMN DEALER_EVAL.REVIEWS IS '평가의견';
COMMENT ON COLUMN DEALER_EVAL.RATING IS '평가점수';
COMMENT ON COLUMN DEALER_EVAL.CREATED_DATE IS '생성일';
COMMENT ON COLUMN DEALER_EVAL.USE_YN IS '사용여부';
COMMENT ON COLUMN DEALER_EVAL.DEL_REASON IS '삭제사유 (미사용)';
COMMENT ON COLUMN DEALER_EVAL.DEL_USER_ID IS '삭제자';
COMMENT ON COLUMN DEALER_EVAL.DEL_DATE IS '삭제일';
COMMENT ON TABLE T2_FILE IS '파일정보';
COMMENT ON COLUMN T2_FILE.FILE_SEQ IS '파일순번';
COMMENT ON COLUMN T2_FILE.FILE_GROUP_ID IS '파일그룹ID';
COMMENT ON COLUMN T2_FILE.ORIG_NM IS '원본파일명';
COMMENT ON COLUMN T2_FILE.LOGI_NM IS '물리파일명';
COMMENT ON COLUMN T2_FILE.LOGI_PATH IS '물리경로';
COMMENT ON COLUMN T2_FILE.LOGI_THUMB_NM IS '물리파일명(썸네일)';
COMMENT ON COLUMN T2_FILE.LOGI_THUMB_PATH IS '물리경로(썸네일)';
COMMENT ON COLUMN T2_FILE.CONTENT_TYPE IS '타입(다운로드시 사용)';
COMMENT ON COLUMN T2_FILE.FILE_EXT IS '확장자';
COMMENT ON COLUMN T2_FILE.FILE_SIZE IS 'FILE_SIZE';
COMMENT ON COLUMN T2_FILE.CREATOR IS '등록자';
COMMENT ON COLUMN T2_FILE.CREATED_DATE IS '등록일';
COMMENT ON COLUMN T2_FILE.MODIFIER IS '수정자';
COMMENT ON COLUMN T2_FILE.MODIFIED_DATE IS '수정일';
COMMENT ON COLUMN T2_FILE.USE_YN IS '사용여부';
COMMENT ON TABLE USER_INTEREST IS '관심매물';
COMMENT ON COLUMN USER_INTEREST.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_INTEREST.CAR_SEQ IS '매물식별SEQ';
COMMENT ON TABLE USER_INTEREST_DEALER IS '관심딜러';
COMMENT ON COLUMN USER_INTEREST_DEALER.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_INTEREST_DEALER.DEALER_ID IS '딜러 사용자 아이디';
COMMENT ON TABLE USER_RECOMMEND IS '내게맞는매물정보';
COMMENT ON COLUMN USER_RECOMMEND.USER_ID IS '회원아이디';
COMMENT ON COLUMN USER_RECOMMEND.MAKER_CD IS '메이커코드';
COMMENT ON COLUMN USER_RECOMMEND.MODEL_CD IS '모델코드';
COMMENT ON COLUMN USER_RECOMMEND.DETAIL_MODEL_CD IS '세부모델코드';
COMMENT ON COLUMN USER_RECOMMEND.USE_KM IS '주행거리';
COMMENT ON COLUMN USER_RECOMMEND.CAR_REG_YEAR IS '연식';
COMMENT ON COLUMN USER_RECOMMEND.CAR_COLOR IS '색상';
COMMENT ON COLUMN USER_RECOMMEND.CREATED_DATE IS '생성일';
COMMENT ON COLUMN USER_RECOMMEND.MODIFIED_DATE IS '수정일';



