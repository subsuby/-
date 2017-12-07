
/* Drop Triggers */

DROP TRIGGER TRI_CAR_MST_CAR_SEQ;
DROP TRIGGER TRI_CHECK_LIST_HIS_CHK_LIST_SEQ;
DROP TRIGGER TRI_COSTING_HIS_COSTING_SEQ;
DROP TRIGGER TRI_DEALER_EVAL_EVAL_SEQ;
DROP TRIGGER TRI_MAKEUP_HIS_MAKEUP_SEQ;
DROP TRIGGER TRI_MYCAR_MST_MYCAR_SEQ;
DROP TRIGGER TRI_NAME_CARD_HIS_NAME_CARD_SEQ;
DROP TRIGGER TRI_PUSH_SND_SEQ;
DROP TRIGGER TRI_RES_HIS_RES_HIS_SEQ;
DROP TRIGGER TRI_SND_HIS_PUSH_SND_SEQ;
DROP TRIGGER TRI_T2_FILE_FILE_SEQ;
DROP TRIGGER TRI_TBL_QUESTION_ANSWER_QA_SEQ;
DROP TRIGGER TRI_TBL_QUESTION_QT_SEQ;



/* Drop Tables */

DROP TABLE ACC_LOG CASCADE CONSTRAINTS;
DROP TABLE ACC_URL CASCADE CONSTRAINTS;
DROP TABLE BLACKLIST_REQ_HIS CASCADE CONSTRAINTS;
DROP TABLE CAR_CD_MST CASCADE CONSTRAINTS;
DROP TABLE CAR_OPTION CASCADE CONSTRAINTS;
DROP TABLE USER_INTEREST CASCADE CONSTRAINTS;
DROP TABLE CAR_MST CASCADE CONSTRAINTS;
DROP TABLE CHECK_LIST_HIS CASCADE CONSTRAINTS;
DROP TABLE COSTING_HIS CASCADE CONSTRAINTS;
DROP TABLE DEALER_EVAL CASCADE CONSTRAINTS;
DROP TABLE DEVICE_INFO CASCADE CONSTRAINTS;
DROP TABLE EST_APPLY CASCADE CONSTRAINTS;
DROP TABLE EST_HIS CASCADE CONSTRAINTS;
DROP TABLE EST_HIS_BAK CASCADE CONSTRAINTS;
DROP TABLE FALSE_CAR CASCADE CONSTRAINTS;
DROP TABLE MAKEUP_HIS CASCADE CONSTRAINTS;
DROP TABLE MYCAR_MST CASCADE CONSTRAINTS;
DROP TABLE NAME_CARD_HIS CASCADE CONSTRAINTS;
DROP TABLE RES_HIS CASCADE CONSTRAINTS;
DROP TABLE SND_HIS_PUSH CASCADE CONSTRAINTS;
DROP TABLE T2_AUTHORITIES CASCADE CONSTRAINTS;
DROP TABLE T2_CODE_DTL CASCADE CONSTRAINTS;
DROP TABLE T2_CODE CASCADE CONSTRAINTS;
DROP TABLE T2_FILE CASCADE CONSTRAINTS;
DROP TABLE T2_ROLES CASCADE CONSTRAINTS;
DROP TABLE T2_ROLES_HIERARCHY CASCADE CONSTRAINTS;
DROP TABLE T2_SECURED_RESOURCES CASCADE CONSTRAINTS;
DROP TABLE T2_SECURED_RESOURCES_ROLE CASCADE CONSTRAINTS;
DROP TABLE T2_USERS CASCADE CONSTRAINTS;
DROP TABLE TBL_QUESTION CASCADE CONSTRAINTS;
DROP TABLE TBL_QUESTION_ANSWER CASCADE CONSTRAINTS;
DROP TABLE USER_DIVICE CASCADE CONSTRAINTS;
DROP TABLE USER_INTEREST_DEALER CASCADE CONSTRAINTS;
DROP TABLE USER_RECOMMEND CASCADE CONSTRAINTS;



/* Drop Sequences */

DROP SEQUENCE SEQ_CAR_MST_CAR_SEQ;
DROP SEQUENCE SEQ_CHECK_LIST_HIS_CHK_LIST_SEQ;
DROP SEQUENCE SEQ_COSTING_HIS_COSTING_SEQ;
DROP SEQUENCE SEQ_DEALER_EVAL_EVAL_SEQ;
DROP SEQUENCE SEQ_MAKEUP_HIS_MAKEUP_SEQ;
DROP SEQUENCE SEQ_MYCAR_MST_MYCAR_SEQ;
DROP SEQUENCE SEQ_NAME_CARD_HIS_NAME_CARD_SEQ;
DROP SEQUENCE SEQ_PUSH_SND_HIS_SND_SEQ;
DROP SEQUENCE SEQ_PUSH_SND_SEQ;
DROP SEQUENCE SEQ_RES_HIS_RES_HIS_SEQ;
DROP SEQUENCE SEQ_SND_HIS_PUSH_SND_SEQ;
DROP SEQUENCE SEQ_T2_FILE_FILE_SEQ;
DROP SEQUENCE SEQ_TBL_QUESTION_ANSWER_QA_SEQ;
DROP SEQUENCE SEQ_TBL_QUESTION_QT_SEQ;




/* Create Sequences */

CREATE SEQUENCE SEQ_CAR_MST_CAR_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_CHECK_LIST_HIS_CHK_LIST_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_COSTING_HIS_COSTING_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_DEALER_EVAL_EVAL_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_MAKEUP_HIS_MAKEUP_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_MYCAR_MST_MYCAR_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_NAME_CARD_HIS_NAME_CARD_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_PUSH_SND_HIS_SND_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_PUSH_SND_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_RES_HIS_RES_HIS_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_SND_HIS_PUSH_SND_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_T2_FILE_FILE_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_TBL_QUESTION_ANSWER_QA_SEQ INCREMENT BY 1 START WITH 1;
CREATE SEQUENCE SEQ_TBL_QUESTION_QT_SEQ INCREMENT BY 1 START WITH 1;



/* Create Tables */

-- access history
CREATE TABLE ACC_LOG
(
	-- ACC_TIME
	ACC_TIME timestamp DEFAULT SYSTIMESTAMP NOT NULL,
	-- ACC_TYPE
	ACC_TYPE varchar2(10),
	-- DEVICE_TYPE
	DEVICE_TYPE varchar2(10),
	-- APP_VER
	APP_VER varchar2(10),
	-- BUILD_VER
	BUILD_VER varchar2(10),
	-- USER_ID
	USER_ID varchar2(50),
	-- IP_ADDR
	IP_ADDR varchar2(30),
	-- USER_AGENT
	USER_AGENT varchar2(512 char),
	-- REFERER
	REFERER varchar2(250 char),
	-- 디바이스 모델
	DEVICE_MODEL varchar2(250),
	-- 디바이스 OS 버전
	DEVICE_OS_VER varchar2(10),
	PRIMARY KEY (ACC_TIME)
);


-- forwarding URL 정합성 체크
CREATE TABLE ACC_URL
(
	-- ACC_KEY
	ACC_KEY varchar2(15) NOT NULL,
	-- FW_URL
	FW_URL varchar2(200) NOT NULL,
	PRIMARY KEY (ACC_KEY)
);


-- 매물 BLACKLIST 신청
CREATE TABLE BLACKLIST_REQ_HIS
(
	-- 매물순번
	CAR_SEQ number NOT NULL,
	-- 차량번호
	CAR_PLATE_NUM varchar2(30) NOT NULL,
	-- 딜러사용자ID
	DEALER_ID varchar2(50) NOT NULL,
	-- 딜러명
	DEALER_NM varchar2(100),
	-- SHOP_NO
	SHOP_NO number,
	-- 매물등록일시
	CAR_CREATED_DATE date,
	-- 매물삭제요청일시
	DEL_REQ_DATE date DEFAULT SYSDATE,
	-- 요청자명
	REQ_USER_NM varchar2(100) NOT NULL,
	-- 요청사유
	REQ_REMARK varchar2(1000 char) NOT NULL
);


-- 차량코드정보
CREATE TABLE CAR_CD_MST
(
	-- 차량코드
	CARCODE varchar2(10) NOT NULL,
	-- 제조국가코드
	COUNTRY_CODE varchar2(2),
	-- 제조국가명
	COUNTRY_NAME varchar2(10),
	-- 제조사코드
	MAKER_CODE varchar2(3),
	-- 제조사명
	MAKER_NAME varchar2(20),
	-- 모델코드
	MODEL_CODE varchar2(2),
	-- 모델명
	MODEL_NAME varchar2(30),
	-- 상세모델코드
	MODELDETAIL_CODE varchar2(1),
	-- 상세모델명
	MODELDETAIL_NAME varchar2(40),
	-- 등급코드
	GRADE_CODE varchar2(2),
	-- 등급명
	GRADE_NAME varchar2(40),
	-- 차종코드
	KIND_CODE varchar2(1),
	-- 차종명칭
	KIND_NAME varchar2(10),
	-- 세부차종코드
	SUB_KIND_CODE varchar2(1),
	-- 세부차종명칭
	SUB_KIND_NAME varchar2(20),
	PRIMARY KEY (CARCODE)
);


-- 매물정보
CREATE TABLE CAR_MST
(
	-- 매물식별SEQ
	CAR_SEQ number(10,0) NOT NULL,
	-- 차량번호
	CAR_PLATE_NUM varchar2(30) NOT NULL,
	-- 차량코드
	CAR_FULL_CODE varchar2(10) NOT NULL,
	-- 차대번호
	CAR_FRAME_NUM varchar2(30),
	-- 제조사명
	MAKER_NAME varchar2(50),
	-- 모델명
	MODEL_NAME varchar2(50),
	-- 등급명
	GRADE_NAME varchar2(50),
	-- 세부모델명
	DETAIL_MODEL_NAME varchar2(50),
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
	SAGO_YN varchar2(10) DEFAULT '0',
	-- 판매상태
	CAR_STATE varchar2(10),
	-- 차량등록일
	APPLY_DAY varchar2(8),
	-- 차량 판매가
	SALE_AMT number,
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
	PARK_ADDR2 varchar2(300),
	-- 성능점검번호
	CAR_CHECK_NO varchar2(20),
	-- 매매 단지 번호
	DANJI_NO number,
	-- PAGE VIEW COUNT
	PV_CNT number DEFAULT 0,
	-- 디카매물PK(매물가져오기시에만설정)
	CAR_NO varchar2(20),
	-- 연장보장상품 실행 여부
	CAR_GUAR_TERM_EXEC_YN char(1) DEFAULT '''N''',
	-- 연장보장상품 계약번호
	CAR_GUAR_TERM_CONT_NO varchar2(20),
	-- 확장FLAG
	MOD_FLAG char(1),
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


-- 체크리스트이력
CREATE TABLE CHECK_LIST_HIS
(
	-- 체크리스트발송순번
	CHK_LIST_SEQ number NOT NULL,
	-- 딜러 사용자ID
	DEALER_ID varchar2(50) NOT NULL,
	-- 사용자ID
	USER_ID varchar2(50) NOT NULL,
	-- 체크항목(콤마구분으로 코드(150하위코드) 복수등록)
	CHECK_ITEMS varchar2(500),
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE,
	-- 확인여부
	READ_YN char(1) DEFAULT 'N',
	PRIMARY KEY (CHK_LIST_SEQ)
);


-- 비용계산전송이력
CREATE TABLE COSTING_HIS
(
	-- 비용계산순번
	COSTING_SEQ number NOT NULL,
	-- 딜러 사용자 ID
	DEALER_ID varchar2(50) NOT NULL,
	-- 사용자 ID
	USER_ID varchar2(50) NOT NULL,
	-- 차량번호
	CAR_PLATE_NUM varchar2(20) NOT NULL,
	-- 차량코드
	CAR_FULL_CODE varchar2(10) NOT NULL,
	-- 차량최초등록일
	CAR_REG_DAY varchar2(8),
	-- 연식
	CAR_REG_YEAR varchar2(4),
	-- 잔존률
	REMAIN_RATE varchar2(30),
	-- 과세표준
	TAX_BASE number,
	-- 신차가격
	NEW_CAR_AMT number,
	-- 구매비용
	PURCHASE_COST number,
	-- 등록지역
	REG_AREA varchar2(10),
	-- 용도구분
	USE_TYPE varchar2(10),
	-- 차종구분
	CAR_KIND_TYPE varchar2(10),
	-- 상세차종구분
	CAR_DETAIL_KIND_TYPE varchar2(10),
	-- 저당비용
	ADD_MORTGAGE_AMT number,
	-- 등록대행료
	ADD_PROXY_AMT number,
	-- 관리비용
	ADD_MANAGEMENT_AMT number,
	-- 부대비용합계
	ADD_TOTAL_AMT number,
	-- 등록세
	PRE_REG_TAX number,
	-- 취득세
	PRE_ACQU_TAX number,
	-- 공채할인비
	PRE_DISCOUNT_AMT number,
	-- 인지대
	PRE_STAMP_TAX number,
	-- 증지대
	PRE_CERTIFICATE_TAX number,
	-- 번호판교체비용
	PRE_REPLACE_PLATE_CHARGE number,
	-- 이전등록합계
	PRE_TOTAL_AMT number,
	-- 총합계
	TOTAL_AMT number,
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE,
	-- 확인여부
	READ_YN char(1) DEFAULT 'N',
	PRIMARY KEY (COSTING_SEQ)
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


-- 디바이스정보
CREATE TABLE DEVICE_INFO
(
	-- PUSH_TOKEN
	PUSH_TOKEN varchar2(256) NOT NULL,
	-- DEVICE_TYPE
	DEVICE_TYPE varchar2(10),
	-- DEVICE_OS_VER
	DEVICE_OS_VER varchar2(10),
	-- DEVICE_MODEL
	DEVICE_MODEL varchar2(100),
	-- BUILD_VER
	BUILD_VER varchar2(10),
	-- APP_VER
	APP_VER varchar2(10),
	-- 사용자ID
	USER_ID varchar2(50),
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE
);


-- 견적요청
CREATE TABLE EST_APPLY
(
	-- MYCAR순번
	MYCAR_SEQ number NOT NULL,
	-- 견적요청상태(10:요청, 20:회신)
	EST_STATE varchar2(10) DEFAULT '10',
	-- 견적요청종류(1:직접방문, 2:방문요청)
	EST_TYPE char(1) NOT NULL,
	-- 견적요청정보-BNK ID(USER_ID)
	EST_USER_SITE_ID number NOT NULL,
	-- 견적요청정보 - 이름
	EST_USER_NM varchar2(100) NOT NULL,
	-- 견적요청정보 - 연락처
	EST_USER_TEL varchar2(20) NOT NULL,
	-- 견적요청정보 - 지역 시도
	EST_SIDO varchar2(200),
	-- 견적요청정보 - 지역 시군구
	EST_SI_GUN_GU varchar2(300),
	-- 견적요청정보 - 판매시기(1:1개월이내, 2:3개월이내, 3:3개월이상)
	EST_SALE_PERIOD char(1),
	-- 견적요청정보 - 상세정보
	EST_REMARK clob,
	-- 차량번호
	CAR_PLATE_NUM varchar2(30),
	-- 차량코드
	CAR_FULL_CODE varchar2(10) NOT NULL,
	-- 제조사명
	MAKER_NM varchar2(20),
	-- 모델명
	MODEL_NM varchar2(50),
	-- 상세모델명
	DETAIL_MODEL_NM varchar2(100),
	-- 등급명
	GRADE_NM varchar2(50),
	-- 년식 - 년도
	CAR_REG_YEAR varchar2(4),
	-- 연식 - 월(1-12)
	CAR_REG_MONTH varchar2(2),
	-- 미션
	CAR_MISSION varchar2(50),
	-- 연료
	CAR_FUEL varchar2(50),
	-- 주행거리
	USE_KM varchar2(10),
	-- 차량색상
	CAR_COLOR varchar2(30),
	-- 사진URL1
	CAR_PHOTO_URL1 varchar2(300),
	-- 사진URL2
	CAR_PHOTO_URL2 varchar2(300),
	-- 사진URL3
	CAR_PHOTO_URL3 varchar2(300),
	-- 사진URL4
	CAR_PHOTO_URL4 varchar2(300),
	-- 사진URL5
	CAR_PHOTO_URL5 varchar2(300),
	-- 동영상URL
	CAR_VIDEO_URL varchar2(500),
	-- 견적요청처리결과코드
	EST_REQ_RESULT_CD varchar2(10) DEFAULT '0000',
	-- 견적요청일
	EST_REQ_DATE date DEFAULT SYSDATE NOT NULL,
	-- 부가서비스 - 메이크업 포함
	EXTRA_MAKEUP_YN char(1),
	-- 부가서비스 - 위탁판매 포함
	EXTRA_CONSIGN_YN char(1),
	-- 소속단지(직접방문인 경우만 설정)
	DANJI_NO number,
	-- 소속상사(직접방문인 경우만 설정)
	SHOP_NO number,
	-- 견적방문예약일
	EST_RES_DATE varchar2(8),
	-- 견적방문예약시간(온라인통화후 확정시 입력)
	EST_RES_TIME varchar2(4),
	PRIMARY KEY (MYCAR_SEQ)
);


-- 견적요청이력
CREATE TABLE EST_HIS
(
	-- MYCAR순번
	MYCAR_SEQ number NOT NULL,
	-- 견적요청상태(10:요청, 20:회신)
	EST_STATE varchar2(10) DEFAULT '10',
	-- 견적요청종류(1:직접방문, 2:방문요청)
	EST_TYPE char(1) NOT NULL,
	-- 견적요청정보-BNK ID(USER_ID)
	EST_USER_SITE_ID number NOT NULL,
	-- 견적요청정보 - 이름
	EST_USER_NM varchar2(100) NOT NULL,
	-- 견적요청정보 - 연락처
	EST_USER_TEL varchar2(20) NOT NULL,
	-- 견적요청정보 - 지역 시도
	EST_SIDO varchar2(200),
	-- 견적요청정보 - 지역 시군구
	EST_SI_GUN_GU varchar2(300),
	-- 견적요청정보 - 판매시기(1:1개월이내, 2:3개월이내, 3:3개월이상)
	EST_SALE_PERIOD char(1),
	-- 견적요청정보 - 상세정보
	EST_REMARK clob,
	-- 차량코드
	CAR_FULL_CODE varchar2(10) NOT NULL,
	-- 제조사명
	MAKER_NM varchar2(20),
	-- 모델명
	MODEL_NM varchar2(50),
	-- 상세모델명
	DETAIL_MODEL_NM varchar2(100),
	-- 등급명
	GRADE_NM varchar2(50),
	-- 년식 - 년도
	CAR_REG_YEAR varchar2(4),
	-- 연식 - 월(1-12)
	CAR_REG_MONTH varchar2(2),
	-- 미션
	CAR_MISSION varchar2(50),
	-- 연료
	CAR_FUEL varchar2(50),
	-- 주행거리
	USE_KM varchar2(10),
	-- 차량색상
	CAR_COLOR varchar2(30),
	-- 사진URL1
	CAR_PHOTO_URL1 varchar2(300),
	-- 사진URL2
	CAR_PHOTO_URL2 varchar2(300),
	-- 사진URL3
	CAR_PHOTO_URL3 varchar2(300),
	-- 사진URL4
	CAR_PHOTO_URL4 varchar2(300),
	-- 사진URL5
	CAR_PHOTO_URL5 varchar2(300),
	-- 동영상URL
	CAR_VIDEO_URL varchar2(500),
	-- 견적요청처리결과코드
	EST_REQ_RESULT_CD varchar2(10) DEFAULT '0000',
	-- 견적요청일
	EST_REQ_DATE date DEFAULT SYSDATE NOT NULL,
	-- 견적요청KEY
	EST_KEY varchar2(100),
	-- 견적결과회신일
	EST_RES_DATE date,
	-- 견적결과확인 결과
	EST_RES_RESULT_CD varchar2(10),
	-- 1 견적딜러 SHOPNO
	EST_SHOP_NO1 number,
	-- 1 견적딜러 상사명
	EST_SHOP_NM1 varchar2(200),
	-- 1 견적딜러 상사 주소
	EST_SHOP_ADDR1 varchar2(1024),
	-- 1 견적딜러명
	EST_DEALER_NM1 varchar2(100),
	-- 1 견적딜러 연락처
	EST_DEALER_TEL1 varchar2(50),
	-- 1 견적금액(만원단위)
	EST_AMT1 number DEFAULT 0,
	-- 1 견적딜러 추가내용
	EST_REMARK1 clob,
	-- 2 견적딜러 ShopNo
	EST_SHOP_NO2 number,
	-- 2 견적딜러 상사명
	EST_SHOP_NM2 varchar2(200),
	-- 2 견적딜러 상사 주소
	EST_SHOP_ADDR2 varchar2(1024),
	-- 2 견적딜러명
	EST_DEALER_NM2 varchar2(100),
	-- 2 견적딜러 연락처
	EST_DEALER_TEL2 varchar2(50),
	-- 2 견적가금액(만원단위)
	EST_AMT2 number,
	-- 2 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)
	EST_REMARK2 clob,
	-- 3 견적딜러 ShopNo
	EST_SHOP_NO3 number,
	-- 3 견적딜러 상사명
	EST_SHOP_NM3 varchar2(200),
	-- 3 견적딜러 상사 주소
	EST_SHOP_ADDR3 varchar2(1024),
	-- 3 견적딜러명
	EST_DEALER_NM3 varchar2(100),
	-- 3 견적딜러 연락처
	EST_DEALER_TEL3 varchar2(50),
	-- 3 견적가금액(만원단위)
	EST_AMT3 number,
	-- 3 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)
	EST_REMARK3 clob,
	-- 4 견적딜러 ShopNo
	EST_SHOP_NO4 number,
	-- 4 견적딜러 상사명
	EST_SHOP_NM4 varchar2(200),
	-- 4 견적딜러 상사 주소
	EST_SHOP_ADDR4 varchar2(1024),
	-- 4 견적딜러명
	EST_DEALER_NM4 varchar2(100),
	-- 4 견적딜러 연락처
	EST_DEALER_TEL4 varchar2(50),
	-- 4 견적가금액(만원단위)
	EST_AMT4 number,
	-- 4 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)
	EST_REMARK4 clob,
	-- 5 견적딜러 ShopNo
	EST_SHOP_NO5 number,
	-- 5 견적딜러 상사명
	EST_SHOP_NM5 varchar2(200),
	-- 5 견적딜러 상사 주소
	EST_SHOP_ADDR5 varchar2(1024),
	-- 5 견적딜러명
	EST_DEALER_NM5 varchar2(100),
	-- 5 견적딜러 연락처
	EST_DEALER_TEL5 varchar2(50),
	-- 5 견적가금액(만원단위)
	EST_AMT5 number,
	-- 5 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)
	EST_REMARK5 clob,
	PRIMARY KEY (MYCAR_SEQ)
);


-- 견적요청이력(삭제이력)
CREATE TABLE EST_HIS_BAK
(
	-- MYCAR순번
	MYCAR_SEQ number NOT NULL,
	-- 견적요청상태(10:요청, 20:회신)
	EST_STATE varchar2(10) DEFAULT '10',
	-- 견적요청종류(1:직접방문, 2:방문요청)
	EST_TYPE char(1) NOT NULL,
	-- 견적요청정보-BNK ID(USER_ID)
	EST_USER_SITE_ID number NOT NULL,
	-- 견적요청정보 - 이름
	EST_USER_NM varchar2(100) NOT NULL,
	-- 견적요청정보 - 연락처
	EST_USER_TEL varchar2(20) NOT NULL,
	-- 견적요청정보 - 지역 시도
	EST_SIDO varchar2(200),
	-- 견적요청정보 - 지역 시군구
	EST_SI_GUN_GU varchar2(300),
	-- 견적요청정보 - 판매시기(1:1개월이내, 2:3개월이내, 3:3개월이상)
	EST_SALE_PERIOD char(1),
	-- 견적요청정보 - 상세정보
	EST_REMARK clob,
	-- 차량코드
	CAR_FULL_CODE varchar2(10) NOT NULL,
	-- 제조사명
	MAKER_NM varchar2(20),
	-- 모델명
	MODEL_NM varchar2(50),
	-- 상세모델명
	DETAIL_MODEL_NM varchar2(100),
	-- 등급명
	GRADE_NM varchar2(50),
	-- 년식 - 년도
	CAR_REG_YEAR varchar2(4),
	-- 연식 - 월(1-12)
	CAR_REG_MONTH varchar2(2),
	-- 미션
	CAR_MISSION varchar2(50),
	-- 연료
	CAR_FUEL varchar2(50),
	-- 주행거리
	USE_KM varchar2(10),
	-- 차량색상
	CAR_COLOR varchar2(30),
	-- 사진URL1
	CAR_PHOTO_URL1 varchar2(300),
	-- 사진URL2
	CAR_PHOTO_URL2 varchar2(300),
	-- 사진URL3
	CAR_PHOTO_URL3 varchar2(300),
	-- 사진URL4
	CAR_PHOTO_URL4 varchar2(300),
	-- 사진URL5
	CAR_PHOTO_URL5 varchar2(300),
	-- 동영상URL
	CAR_VIDEO_URL varchar2(500),
	-- 견적요청처리결과코드
	EST_REQ_RESULT_CD varchar2(10) DEFAULT '0000',
	-- 견적요청일
	EST_REQ_DATE date DEFAULT SYSDATE NOT NULL,
	-- 견적요청KEY
	EST_KEY varchar2(100),
	-- 견적결과회신일
	EST_RES_DATE date,
	-- 견적결과확인 결과
	EST_RES_RESULT_CD varchar2(10),
	-- 1 견적딜러 SHOPNO
	EST_SHOP_NO1 number,
	-- 1 견적딜러 상사명
	EST_SHOP_NM1 varchar2(200),
	-- 1 견적딜러 상사 주소
	EST_SHOP_ADDR1 varchar2(1024),
	-- 1 견적딜러명
	EST_DEALER_NM1 varchar2(100),
	-- 1 견적딜러 연락처
	EST_DEALER_TEL1 varchar2(50),
	-- 1 견적금액(만원단위)
	EST_AMT1 number DEFAULT 0,
	-- 1 견적딜러 추가내용
	EST_REMARK1 clob,
	-- 2 견적딜러 ShopNo
	EST_SHOP_NO2 number,
	-- 2 견적딜러 상사명
	EST_SHOP_NM2 varchar2(200),
	-- 2 견적딜러 상사 주소
	EST_SHOP_ADDR2 varchar2(1024),
	-- 2 견적딜러명
	EST_DEALER_NM2 varchar2(100),
	-- 2 견적딜러 연락처
	EST_DEALER_TEL2 varchar2(50),
	-- 2 견적가금액(만원단위)
	EST_AMT2 number,
	-- 2 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)
	EST_REMARK2 clob,
	-- 3 견적딜러 ShopNo
	EST_SHOP_NO3 number,
	-- 3 견적딜러 상사명
	EST_SHOP_NM3 varchar2(200),
	-- 3 견적딜러 상사 주소
	EST_SHOP_ADDR3 varchar2(1024),
	-- 3 견적딜러명
	EST_DEALER_NM3 varchar2(100),
	-- 3 견적딜러 연락처
	EST_DEALER_TEL3 varchar2(50),
	-- 3 견적가금액(만원단위)
	EST_AMT3 number,
	-- 3 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)
	EST_REMARK3 clob,
	-- 4 견적딜러 ShopNo
	EST_SHOP_NO4 number,
	-- 4 견적딜러 상사명
	EST_SHOP_NM4 varchar2(200),
	-- 4 견적딜러 상사 주소
	EST_SHOP_ADDR4 varchar2(1024),
	-- 4 견적딜러명
	EST_DEALER_NM4 varchar2(100),
	-- 4 견적딜러 연락처
	EST_DEALER_TEL4 varchar2(50),
	-- 4 견적가금액(만원단위)
	EST_AMT4 number,
	-- 4 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)
	EST_REMARK4 clob,
	-- 5 견적딜러 ShopNo
	EST_SHOP_NO5 number,
	-- 5 견적딜러 상사명
	EST_SHOP_NM5 varchar2(200),
	-- 5 견적딜러 상사 주소
	EST_SHOP_ADDR5 varchar2(1024),
	-- 5 견적딜러명
	EST_DEALER_NM5 varchar2(100),
	-- 5 견적딜러 연락처
	EST_DEALER_TEL5 varchar2(50),
	-- 5 견적가금액(만원단위)
	EST_AMT5 number,
	-- 5 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)
	EST_REMARK5 clob,
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE
);


-- 허위매물신고
CREATE TABLE FALSE_CAR
(
	-- 매물순번
	CAR_SEQ number NOT NULL,
	-- 허위매물사용자ID
	FALSE_USER_ID varchar2(50) NOT NULL,
	-- 신고자명
	FALSE_USER_NM varchar2(100),
	-- 신고자 연락처
	FALSE_USER_TEL varchar2(30),
	-- 차량코드
	CAR_FULL_CODE varchar2(10) NOT NULL,
	-- 차량번호
	CAR_PLATE_NUM varchar2(30),
	-- 판매가격
	SALE_AMT number,
	-- 신고종류 코드:215
	FALSE_TYPE varchar2(10) NOT NULL,
	-- 신고내용
	FALSE_REQ_REMARK clob,
	-- 신고일
	CREATED_DATE date DEFAULT SYSDATE NOT NULL,
	-- 신고처리상태 코드:214(1차오픈 미사용)
	FALSE_STATE varchar2(10) DEFAULT '10',
	-- 신고매물소속상사
	FALSE_SHOP_NO number,
	-- 신고매물판매딜러ID
	FALSE_DEALER_ID varchar2(50) NOT NULL,
	-- 신고매물판매딜러명
	FALSE_DEALER_NM varchar2(100),
	-- 신고매물판매딜러연락처
	FALSE_DEALER_TEL varchar2(30),
	-- 처리내용
	FALSE_RES_REMARK clob,
	-- 마지막수정자
	MODIFIER varchar2(50),
	-- 마지막수정일
	MODIFIED_DATE date DEFAULT SYSDATE,
	PRIMARY KEY (CAR_SEQ, FALSE_USER_ID)
);


-- 메이크업신청이력
CREATE TABLE MAKEUP_HIS
(
	-- 메이크업신청순번
	MAKEUP_SEQ number NOT NULL,
	-- 진행상태
	MAKEUP_STATE varchar2(10) DEFAULT '10' NOT NULL,
	-- 딜러구분
	DEALER_YN char(1) DEFAULT 'N' NOT NULL,
	-- 사용자ID
	USER_ID varchar2(50) NOT NULL,
	-- 차량번호
	CAR_PLATE_NUM varchar2(20) NOT NULL,
	-- 매물순번
	CAR_SEQ number NOT NULL,
	-- 요청서비스
	REQ_ITEMS varchar2(300),
	-- 기타요청사항
	REQ_REMARK clob,
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE NOT NULL,
	-- 서비스 - 방문일
	VISIT_DAY varchar2(8),
	-- 서비스 - 방문시간
	VISIT_TIME varchar2(4),
	-- 방문지 주소
	VISIT_ADDR varchar2(500),
	-- 담당자명
	VISITOR_NM varchar2(100),
	-- 방문자연락처
	VISITOR_TEL varchar2(100),
	PRIMARY KEY (MAKEUP_SEQ)
);


-- 개인매물정보
CREATE TABLE MYCAR_MST
(
	-- 개인매물식별SEQ
	MYCAR_SEQ number(10,0) NOT NULL,
	-- 회원아이디
	USER_ID varchar2(50) NOT NULL,
	-- 차량번호
	CAR_PLATE_NUM varchar2(30) NOT NULL,
	-- 차량코드
	CAR_FULL_CODE varchar2(10) NOT NULL,
	-- 차대번호
	CAR_FRAME_NUM varchar2(30),
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
	-- 색상
	CAR_COLOR varchar2(20),
	-- 사고여부
	SAGO_YN varchar2(10) DEFAULT '0',
	-- 차량등록일
	APPLY_DAY varchar2(8),
	-- 차량 판매가
	SALE_AMT number,
	-- 차량설명
	CAR_DESC clob,
	-- 견적요청여부
	EST_REQ_YN char(1) DEFAULT 'N',
	-- 매매상사NO
	SHOP_NO number,
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
	PARK_ADDR2 varchar2(300),
	-- 견젹요청구분(코드209)
	EST_REQ_TYPE varchar2(10),
	PRIMARY KEY (MYCAR_SEQ)
);


-- 명함발송관리
CREATE TABLE NAME_CARD_HIS
(
	-- 명함발송순번
	NAME_CARD_SEQ number NOT NULL,
	-- 딜러 사용자ID
	DEALER_ID varchar2(50) NOT NULL,
	-- 사용자ID
	USER_ID varchar2(50) NOT NULL,
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE,
	-- 확인여부
	READ_YN char(1) DEFAULT 'N',
	-- 발송일
	SEND_DATE date DEFAULT SYSDATE,
	-- 재발송여부
	RESENT_YN char(1) DEFAULT 'N',
	PRIMARY KEY (NAME_CARD_SEQ)
);


-- 예약 시승 탁송 요청이력
CREATE TABLE RES_HIS
(
	-- 예약요청순번
	RES_HIS_SEQ number NOT NULL,
	-- 차량번호
	CAR_PLATE_NUM nvarchar2(30) NOT NULL,
	-- 딜러 종사자번호
	DEALER_LICENSE_NO nvarchar2(20) NOT NULL,
	-- 예약상태
	RES_STATUS varchar2(10) DEFAULT '1' NOT NULL,
	-- 예약요청 KEY
	RES_KEY varchar2(30),
	-- 예약 요청 종류
	RES_TYPE varchar2(10) NOT NULL,
	-- 예약일자
	RES_DATE varchar2(8),
	-- 예약일자 오전오후
	RES_AMPM varchar2(10) DEFAULT 'AM',
	-- 예약자정보 - 이름
	RES_USER_NM varchar2(50) NOT NULL,
	-- 예약자정보 - 연락처
	RES_USER_TEL varchar2(13) NOT NULL,
	-- 예약자정보 - BNKID
	RES_USER_ID varchar2(50) NOT NULL,
	-- 예약신청일
	RES_REQ_DATE date DEFAULT SYSDATE,
	-- 예약요청승인일
	RES_APPR_DATE date,
	-- 승인자 ID
	RES_APPR_USER_ID varchar2(50),
	-- 예약요청취소일
	RES_CANCEL_DATE date,
	-- 사용여부
	USE_YN char(1) DEFAULT 'Y' NOT NULL,
	-- 탁송우편번호
	PARK_ZIP varchar2(6),
	-- 탁송주소
	PARK_ADDR1 varchar2(200),
	-- 탁송상세주소
	PARK_ADDR2 varchar2(300),
	-- 오토모아 매물SEQ
	CAR_SEQ number,
	PRIMARY KEY (RES_HIS_SEQ)
);


-- PUSH발송이력
CREATE TABLE SND_HIS_PUSH
(
	-- 발송순분
	SND_SEQ number NOT NULL,
	-- 발송구분(p:개별, G:GROUP)
	SND_DIV char(1) DEFAULT 'p' NOT NULL,
	-- MESSAGE TYPE
	MSG_TYPE varchar2(10) NOT NULL,
	-- 개별수신자
	SND_TO varchar2(300),
	-- JSON MESSAGE TITLE
	TITLE varchar2(1024) NOT NULL,
	-- BODY(미사용)
	BODY varchar2(1024),
	-- ICON
	ICON varchar2(100),
	-- CLICK_ACTION
	CLICK_ACTION varchar2(1024),
	-- RESULT : MESSAGE_ID
	MESSAGE_ID varchar2(100),
	-- ERROR_MSG
	ERROR_MSG varchar2(2048),
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE,
	-- 생성자(요청자)
	CREATOR varchar2(50),
	-- DEVICE_TYPE
	DEVICE_TYPE varchar2(20),
	PRIMARY KEY (SND_SEQ)
);


-- 사용자권한
CREATE TABLE T2_AUTHORITIES
(
	-- 사용자ID
	USER_ID varchar2(50) NOT NULL,
	-- 권한
	AUTHORITY varchar2(50) NOT NULL,
	PRIMARY KEY (USER_ID, AUTHORITY)
);


-- 코드정보
CREATE TABLE T2_CODE
(
	-- 코드번호
	CD_NO varchar2(6) NOT NULL,
	-- 코드명
	CD_NM varchar2(100) NOT NULL,
	-- 코드설명
	CD_EXP varchar2(255),
	-- 시스템코드여부
	SYS_CD_YN char(1) DEFAULT 'N',
	PRIMARY KEY (CD_NO)
);


-- 공통코드상세
CREATE TABLE T2_CODE_DTL
(
	-- 코드번호
	CD_NO varchar2(6) NOT NULL,
	-- 상세코드번호
	CD_DTL_NO varchar2(6) NOT NULL,
	-- 상세코드명
	CD_DTL_NM varchar2(200) NOT NULL,
	-- 하위코드
	CD_SUB_NO varchar2(6),
	-- 상세코드설명
	CD_DTL_EXP varchar2(2000),
	-- 표시순
	CD_ORDER number NOT NULL,
	-- 사용여부
	USE_YN char(1) DEFAULT 'Y' NOT NULL,
	PRIMARY KEY (CD_NO, CD_DTL_NO)
);


-- 파일정보
CREATE TABLE T2_FILE
(
	-- 파일순번
	FILE_SEQ number NOT NULL,
	-- 파일그룹ID
	FILE_GROUP_ID number DEFAULT 0 NOT NULL,
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
	-- CAR IMAGE인 경우만 설정 CAR_MST:C, MYCAR_MST:M
	CAR_DIV char(1),
	-- 디카매물원본이미지URL
	ORG_FILE_URL varchar2(500),
	PRIMARY KEY (FILE_SEQ)
);


-- 권한별역활
CREATE TABLE T2_ROLES
(
	-- 권한
	AUTHORITY varchar2(50) NOT NULL,
	-- 역활명
	ROLE_NAME varchar2(50) NOT NULL,
	-- 설명
	DESCRIPTION varchar2(500),
	-- 로그인 성공시 표시화면
	LOGIN_SUCC_URL varchar2(200) NOT NULL,
	-- 우선순위
	ODR number NOT NULL,
	PRIMARY KEY (AUTHORITY)
);


-- 역활 관계
CREATE TABLE T2_ROLES_HIERARCHY
(
	-- 부모역활
	PARENT_ROLE varchar2(45) NOT NULL,
	-- 자식역활
	CHILD_ROLE varchar2(45) NOT NULL,
	PRIMARY KEY (PARENT_ROLE, CHILD_ROLE)
);


-- 보증 리소스
CREATE TABLE T2_SECURED_RESOURCES
(
	-- 리소스 ID
	RESOURCE_ID varchar2(20) NOT NULL,
	-- 리소스명
	RESOURCE_NAME varchar2(50) NOT NULL,
	-- 리소스 패턴
	RESOURCE_PATTERN varchar2(300) NOT NULL,
	-- 설명
	DESCRIPTION varchar2(200),
	-- 리소스 종류
	RESOURCE_TYPE varchar2(10) NOT NULL,
	-- 정렬순
	SORT_ORDER number(3,0) NOT NULL,
	-- DEPTH
	DEPTH number(3,0) NOT NULL,
	PRIMARY KEY (RESOURCE_ID)
);


-- 보증 리소스별 권한
CREATE TABLE T2_SECURED_RESOURCES_ROLE
(
	-- 리스소ID
	RESOURCE_ID varchar2(20) NOT NULL,
	-- 권한
	AUTHORITY varchar2(50) NOT NULL,
	PRIMARY KEY (RESOURCE_ID, AUTHORITY)
);


-- 사용자정보
CREATE TABLE T2_USERS
(
	-- 사용자ID
	USER_ID varchar2(50) NOT NULL,
	-- 사용자명
	USER_NAME varchar2(100) NOT NULL,
	-- 패스워드
	PASSWORD varchar2(100),
	-- 전화번호
	PHONE_MOBILE varchar2(13),
	-- 연락처2
	PHONE_DIRECT varchar2(13),
	-- EMAIL
	EMAIL varchar2(100),
	-- 사용자구분
	DIVISION char(1) DEFAULT 'N',
	-- 사용여부
	USE_YN char(1) DEFAULT 'Y',
	-- 생성자
	CREATOR varchar2(50) NOT NULL,
	-- 생성일
	CREATED_DATE date DEFAULT SYSDATE,
	-- 수정자
	MODIFIER varchar2(50),
	-- 수정일
	MODIFIED_DATE date DEFAULT SYSDATE,
	-- 마지막 로그인 일시
	LAST_LOGIN_DATE date,
	-- 사용가능여부
	ENABLED char(1) DEFAULT '1',
	-- 사용자구분('10':일반, '20':딜러)
	USER_DIV varchar2(10),
	-- 종사자번호
	DEALER_LICENSE_NO varchar2(20),
	-- 사용자등급
	GRADE varchar2(10),
	-- 딜러 등급
	GRADE_DEALER varchar2(10),
	-- 우편번호
	ZIP_CODE varchar2(7),
	-- 주소1
	ADDR1 varchar2(255),
	-- 주소2
	ADDR2 varchar2(255),
	-- SMS 약관 동의
	AGREE_SMS_YN char(1) DEFAULT 'N',
	-- PHSH 발송 약관 동의
	AGREE_PUSH_YN char(1) DEFAULT 'N',
	-- 마케팅 이용약관 동의
	AGREE_MARKETING char(1) DEFAULT 'N',
	-- 소속 매매 상사 번호
	SHOP_NO number,
	-- 실사용 휴대폰 번호
	ACTUAL_PHONE_MOBILE varchar2(13),
	-- BIN인증 딜러
	BNK_CONF_YN char(1) DEFAULT 'N',
	-- 단지번호
	DANJI_NO number,
	-- 판매건수
	SALE_CNT number(3,0) DEFAULT 0,
	-- 딜러 프로필 사진 FILE 순번
	DEALER_PROFILE_FILE_SEQ number,
	-- SHOP_ETC
	SHOP_ETC varchar2(30),
	-- 프리미엄 인증 중고차
	PREM_CONF_YN char(1) DEFAULT 'N',
	-- 딜러 프로필 설명
	DEALER_PROFILE_DESC varchar2(500),
	-- 딜러 프로필 연락처
	DEALER_PROFILE_TEL varchar2(20),
	-- 초기 입수 DATA의 사용자 여부
	MIGRATION_FLAG char(1) DEFAULT 'N',
	-- 헛걸음 보장 상품 잔여 개수
	GUAR_FRUITLESS_CNT number DEFAULT 0,
	-- 환불보장 상품 잔여 개수
	GUAR_REFUND_CNT number DEFAULT 0,
	-- 보장기간연장 상품 잔여 개수
	GUAR_TERM_CNT number DEFAULT 0,
	PRIMARY KEY (USER_ID)
);


-- 문의내용
CREATE TABLE TBL_QUESTION
(
	-- 문의글 순번
	QT_SEQ number NOT NULL,
	-- 제목
	TITLE varchar2(250),
	-- 내용
	CONTENTS clob,
	-- 문의글 현재 상태
	QC_STATUS varchar2(6),
	-- 등록자
	REG_ID varchar2(50),
	-- 등록일
	REG_DT date DEFAULT SYSDATE,
	-- 수정자ID
	MOD_ID varchar2(50),
	-- 수정일
	MOD_DT date,
	-- 삭제여부
	DEL_YN char(1) DEFAULT 'N',
	PRIMARY KEY (QT_SEQ)
);


-- 문의내용답변
CREATE TABLE TBL_QUESTION_ANSWER
(
	-- 문의글답변순번
	QA_SEQ number NOT NULL,
	-- 문의글 순번
	QT_SEQ number NOT NULL,
	-- 부모 답변 키
	P_KEY number,
	-- 내용
	CONTENTS clob,
	-- 등록자
	REG_ID varchar2(50),
	-- 등록일
	REG_DT date DEFAULT SYSDATE,
	-- 수정자
	MOD_ID varchar2(50),
	-- 수정일
	MOD_DT date DEFAULT SYSDATE,
	-- 삭제여부
	DEL_YN char(1) DEFAULT 'N',
	-- READ_YN
	READ_YN char(1) DEFAULT 'N',
	-- SND_PUSH_YN
	SND_PUSH_YN char(1) DEFAULT 'N',
	-- SND_PUSH_DATE
	SND_PUSH_DATE timestamp DEFAULT SYSTIMESTAMP,
	PRIMARY KEY (QA_SEQ)
);


-- 사용자디바이스정보
CREATE TABLE USER_DIVICE
(
	-- USER_ID
	USER_ID varchar2(50) NOT NULL,
	-- TOKEN_ID
	TOKEN_ID varchar2(1024),
	-- DIVICE_TYPE(A:ANDROID, I:IOS
	DIVICE_TYPE char(1) NOT NULL,
	-- APP VERSION
	APP_VERSION varchar2(50),
	PRIMARY KEY (USER_ID)
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


ALTER TABLE T2_CODE_DTL
	ADD FOREIGN KEY (CD_NO)
	REFERENCES T2_CODE (CD_NO)
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

CREATE OR REPLACE TRIGGER TRI_CHECK_LIST_HIS_CHK_LIST_SEQ BEFORE INSERT ON CHECK_LIST_HIS
FOR EACH ROW
BEGIN
	SELECT SEQ_CHECK_LIST_HIS_CHK_LIST_SEQ.nextval
	INTO :new.CHK_LIST_SEQ
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_COSTING_HIS_COSTING_SEQ BEFORE INSERT ON COSTING_HIS
FOR EACH ROW
BEGIN
	SELECT SEQ_COSTING_HIS_COSTING_SEQ.nextval
	INTO :new.COSTING_SEQ
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

CREATE OR REPLACE TRIGGER TRI_MAKEUP_HIS_MAKEUP_SEQ BEFORE INSERT ON MAKEUP_HIS
FOR EACH ROW
BEGIN
	SELECT SEQ_MAKEUP_HIS_MAKEUP_SEQ.nextval
	INTO :new.MAKEUP_SEQ
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_MYCAR_MST_MYCAR_SEQ BEFORE INSERT ON MYCAR_MST
FOR EACH ROW
BEGIN
	SELECT SEQ_MYCAR_MST_MYCAR_SEQ.nextval
	INTO :new.MYCAR_SEQ
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_NAME_CARD_HIS_NAME_CARD_SEQ BEFORE INSERT ON NAME_CARD_HIS
FOR EACH ROW
BEGIN
	SELECT SEQ_NAME_CARD_HIS_NAME_CARD_SEQ.nextval
	INTO :new.NAME_CARD_SEQ
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_PUSH_SND_SEQ BEFORE INSERT ON PUSH_SND_HIS
FOR EACH ROW
BEGIN
	SELECT SEQ_PUSH_SND_SEQ.nextval
	INTO :new.SND_SEQ
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_RES_HIS_RES_HIS_SEQ BEFORE INSERT ON RES_HIS
FOR EACH ROW
BEGIN
	SELECT SEQ_RES_HIS_RES_HIS_SEQ.nextval
	INTO :new.RES_HIS_SEQ
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_SND_HIS_PUSH_SND_SEQ BEFORE INSERT ON SND_HIS_PUSH
FOR EACH ROW
BEGIN
	SELECT SEQ_SND_HIS_PUSH_SND_SEQ.nextval
	INTO :new.SND_SEQ
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

CREATE OR REPLACE TRIGGER TRI_TBL_QUESTION_ANSWER_QA_SEQ BEFORE INSERT ON TBL_QUESTION_ANSWER
FOR EACH ROW
BEGIN
	SELECT SEQ_TBL_QUESTION_ANSWER_QA_SEQ.nextval
	INTO :new.QA_SEQ
	FROM dual;
END;

/

CREATE OR REPLACE TRIGGER TRI_TBL_QUESTION_QT_SEQ BEFORE INSERT ON TBL_QUESTION
FOR EACH ROW
BEGIN
	SELECT SEQ_TBL_QUESTION_QT_SEQ.nextval
	INTO :new.QT_SEQ
	FROM dual;
END;

/




/* Comments */

COMMENT ON TABLE ACC_LOG IS 'access history';
COMMENT ON COLUMN ACC_LOG.ACC_TIME IS 'ACC_TIME';
COMMENT ON COLUMN ACC_LOG.ACC_TYPE IS 'ACC_TYPE';
COMMENT ON COLUMN ACC_LOG.DEVICE_TYPE IS 'DEVICE_TYPE';
COMMENT ON COLUMN ACC_LOG.APP_VER IS 'APP_VER';
COMMENT ON COLUMN ACC_LOG.BUILD_VER IS 'BUILD_VER';
COMMENT ON COLUMN ACC_LOG.USER_ID IS 'USER_ID';
COMMENT ON COLUMN ACC_LOG.IP_ADDR IS 'IP_ADDR';
COMMENT ON COLUMN ACC_LOG.USER_AGENT IS 'USER_AGENT';
COMMENT ON COLUMN ACC_LOG.REFERER IS 'REFERER';
COMMENT ON COLUMN ACC_LOG.DEVICE_MODEL IS '디바이스 모델';
COMMENT ON COLUMN ACC_LOG.DEVICE_OS_VER IS '디바이스 OS 버전';
COMMENT ON TABLE ACC_URL IS 'forwarding URL 정합성 체크';
COMMENT ON COLUMN ACC_URL.ACC_KEY IS 'ACC_KEY';
COMMENT ON COLUMN ACC_URL.FW_URL IS 'FW_URL';
COMMENT ON TABLE BLACKLIST_REQ_HIS IS '매물 BLACKLIST 신청';
COMMENT ON COLUMN BLACKLIST_REQ_HIS.CAR_SEQ IS '매물순번';
COMMENT ON COLUMN BLACKLIST_REQ_HIS.CAR_PLATE_NUM IS '차량번호';
COMMENT ON COLUMN BLACKLIST_REQ_HIS.DEALER_ID IS '딜러사용자ID';
COMMENT ON COLUMN BLACKLIST_REQ_HIS.DEALER_NM IS '딜러명';
COMMENT ON COLUMN BLACKLIST_REQ_HIS.SHOP_NO IS 'SHOP_NO';
COMMENT ON COLUMN BLACKLIST_REQ_HIS.CAR_CREATED_DATE IS '매물등록일시';
COMMENT ON COLUMN BLACKLIST_REQ_HIS.DEL_REQ_DATE IS '매물삭제요청일시';
COMMENT ON COLUMN BLACKLIST_REQ_HIS.REQ_USER_NM IS '요청자명';
COMMENT ON COLUMN BLACKLIST_REQ_HIS.REQ_REMARK IS '요청사유';
COMMENT ON TABLE CAR_CD_MST IS '차량코드정보';
COMMENT ON COLUMN CAR_CD_MST.CARCODE IS '차량코드';
COMMENT ON COLUMN CAR_CD_MST.COUNTRY_CODE IS '제조국가코드';
COMMENT ON COLUMN CAR_CD_MST.COUNTRY_NAME IS '제조국가명';
COMMENT ON COLUMN CAR_CD_MST.MAKER_CODE IS '제조사코드';
COMMENT ON COLUMN CAR_CD_MST.MAKER_NAME IS '제조사명';
COMMENT ON COLUMN CAR_CD_MST.MODEL_CODE IS '모델코드';
COMMENT ON COLUMN CAR_CD_MST.MODEL_NAME IS '모델명';
COMMENT ON COLUMN CAR_CD_MST.MODELDETAIL_CODE IS '상세모델코드';
COMMENT ON COLUMN CAR_CD_MST.MODELDETAIL_NAME IS '상세모델명';
COMMENT ON COLUMN CAR_CD_MST.GRADE_CODE IS '등급코드';
COMMENT ON COLUMN CAR_CD_MST.GRADE_NAME IS '등급명';
COMMENT ON COLUMN CAR_CD_MST.KIND_CODE IS '차종코드';
COMMENT ON COLUMN CAR_CD_MST.KIND_NAME IS '차종명칭';
COMMENT ON COLUMN CAR_CD_MST.SUB_KIND_CODE IS '세부차종코드';
COMMENT ON COLUMN CAR_CD_MST.SUB_KIND_NAME IS '세부차종명칭';
COMMENT ON TABLE CAR_MST IS '매물정보';
COMMENT ON COLUMN CAR_MST.CAR_SEQ IS '매물식별SEQ';
COMMENT ON COLUMN CAR_MST.CAR_PLATE_NUM IS '차량번호';
COMMENT ON COLUMN CAR_MST.CAR_FULL_CODE IS '차량코드';
COMMENT ON COLUMN CAR_MST.CAR_FRAME_NUM IS '차대번호';
COMMENT ON COLUMN CAR_MST.MAKER_NAME IS '제조사명';
COMMENT ON COLUMN CAR_MST.MODEL_NAME IS '모델명';
COMMENT ON COLUMN CAR_MST.GRADE_NAME IS '등급명';
COMMENT ON COLUMN CAR_MST.DETAIL_MODEL_NAME IS '세부모델명';
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
COMMENT ON COLUMN CAR_MST.PARK_ADDR2 IS '주차위치 - 상세주소';
COMMENT ON COLUMN CAR_MST.CAR_CHECK_NO IS '성능점검번호';
COMMENT ON COLUMN CAR_MST.DANJI_NO IS '매매 단지 번호';
COMMENT ON COLUMN CAR_MST.PV_CNT IS 'PAGE VIEW COUNT';
COMMENT ON COLUMN CAR_MST.CAR_NO IS '디카매물PK(매물가져오기시에만설정)';
COMMENT ON COLUMN CAR_MST.CAR_GUAR_TERM_EXEC_YN IS '연장보장상품 실행 여부';
COMMENT ON COLUMN CAR_MST.CAR_GUAR_TERM_CONT_NO IS '연장보장상품 계약번호';
COMMENT ON COLUMN CAR_MST.MOD_FLAG IS '확장FLAG';
COMMENT ON TABLE CAR_OPTION IS '매물차량옵션';
COMMENT ON COLUMN CAR_OPTION.CAR_SEQ IS '매물식별SEQ';
COMMENT ON COLUMN CAR_OPTION.OPTION_CD IS '옵션코드';
COMMENT ON TABLE CHECK_LIST_HIS IS '체크리스트이력';
COMMENT ON COLUMN CHECK_LIST_HIS.CHK_LIST_SEQ IS '체크리스트발송순번';
COMMENT ON COLUMN CHECK_LIST_HIS.DEALER_ID IS '딜러 사용자ID';
COMMENT ON COLUMN CHECK_LIST_HIS.USER_ID IS '사용자ID';
COMMENT ON COLUMN CHECK_LIST_HIS.CHECK_ITEMS IS '체크항목(콤마구분으로 코드(150하위코드) 복수등록)';
COMMENT ON COLUMN CHECK_LIST_HIS.CREATED_DATE IS '생성일';
COMMENT ON COLUMN CHECK_LIST_HIS.READ_YN IS '확인여부';
COMMENT ON TABLE COSTING_HIS IS '비용계산전송이력';
COMMENT ON COLUMN COSTING_HIS.COSTING_SEQ IS '비용계산순번';
COMMENT ON COLUMN COSTING_HIS.DEALER_ID IS '딜러 사용자 ID';
COMMENT ON COLUMN COSTING_HIS.USER_ID IS '사용자 ID';
COMMENT ON COLUMN COSTING_HIS.CAR_PLATE_NUM IS '차량번호';
COMMENT ON COLUMN COSTING_HIS.CAR_FULL_CODE IS '차량코드';
COMMENT ON COLUMN COSTING_HIS.CAR_REG_DAY IS '차량최초등록일';
COMMENT ON COLUMN COSTING_HIS.CAR_REG_YEAR IS '연식';
COMMENT ON COLUMN COSTING_HIS.REMAIN_RATE IS '잔존률';
COMMENT ON COLUMN COSTING_HIS.TAX_BASE IS '과세표준';
COMMENT ON COLUMN COSTING_HIS.NEW_CAR_AMT IS '신차가격';
COMMENT ON COLUMN COSTING_HIS.PURCHASE_COST IS '구매비용';
COMMENT ON COLUMN COSTING_HIS.REG_AREA IS '등록지역';
COMMENT ON COLUMN COSTING_HIS.USE_TYPE IS '용도구분';
COMMENT ON COLUMN COSTING_HIS.CAR_KIND_TYPE IS '차종구분';
COMMENT ON COLUMN COSTING_HIS.CAR_DETAIL_KIND_TYPE IS '상세차종구분';
COMMENT ON COLUMN COSTING_HIS.ADD_MORTGAGE_AMT IS '저당비용';
COMMENT ON COLUMN COSTING_HIS.ADD_PROXY_AMT IS '등록대행료';
COMMENT ON COLUMN COSTING_HIS.ADD_MANAGEMENT_AMT IS '관리비용';
COMMENT ON COLUMN COSTING_HIS.ADD_TOTAL_AMT IS '부대비용합계';
COMMENT ON COLUMN COSTING_HIS.PRE_REG_TAX IS '등록세';
COMMENT ON COLUMN COSTING_HIS.PRE_ACQU_TAX IS '취득세';
COMMENT ON COLUMN COSTING_HIS.PRE_DISCOUNT_AMT IS '공채할인비';
COMMENT ON COLUMN COSTING_HIS.PRE_STAMP_TAX IS '인지대';
COMMENT ON COLUMN COSTING_HIS.PRE_CERTIFICATE_TAX IS '증지대';
COMMENT ON COLUMN COSTING_HIS.PRE_REPLACE_PLATE_CHARGE IS '번호판교체비용';
COMMENT ON COLUMN COSTING_HIS.PRE_TOTAL_AMT IS '이전등록합계';
COMMENT ON COLUMN COSTING_HIS.TOTAL_AMT IS '총합계';
COMMENT ON COLUMN COSTING_HIS.CREATED_DATE IS '생성일';
COMMENT ON COLUMN COSTING_HIS.READ_YN IS '확인여부';
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
COMMENT ON TABLE DEVICE_INFO IS '디바이스정보';
COMMENT ON COLUMN DEVICE_INFO.PUSH_TOKEN IS 'PUSH_TOKEN';
COMMENT ON COLUMN DEVICE_INFO.DEVICE_TYPE IS 'DEVICE_TYPE';
COMMENT ON COLUMN DEVICE_INFO.DEVICE_OS_VER IS 'DEVICE_OS_VER';
COMMENT ON COLUMN DEVICE_INFO.DEVICE_MODEL IS 'DEVICE_MODEL';
COMMENT ON COLUMN DEVICE_INFO.BUILD_VER IS 'BUILD_VER';
COMMENT ON COLUMN DEVICE_INFO.APP_VER IS 'APP_VER';
COMMENT ON COLUMN DEVICE_INFO.USER_ID IS '사용자ID';
COMMENT ON COLUMN DEVICE_INFO.CREATED_DATE IS '생성일';
COMMENT ON TABLE EST_APPLY IS '견적요청';
COMMENT ON COLUMN EST_APPLY.MYCAR_SEQ IS 'MYCAR순번';
COMMENT ON COLUMN EST_APPLY.EST_STATE IS '견적요청상태(10:요청, 20:회신)';
COMMENT ON COLUMN EST_APPLY.EST_TYPE IS '견적요청종류(1:직접방문, 2:방문요청)';
COMMENT ON COLUMN EST_APPLY.EST_USER_SITE_ID IS '견적요청정보-BNK ID(USER_ID)';
COMMENT ON COLUMN EST_APPLY.EST_USER_NM IS '견적요청정보 - 이름';
COMMENT ON COLUMN EST_APPLY.EST_USER_TEL IS '견적요청정보 - 연락처';
COMMENT ON COLUMN EST_APPLY.EST_SIDO IS '견적요청정보 - 지역 시도';
COMMENT ON COLUMN EST_APPLY.EST_SI_GUN_GU IS '견적요청정보 - 지역 시군구';
COMMENT ON COLUMN EST_APPLY.EST_SALE_PERIOD IS '견적요청정보 - 판매시기(1:1개월이내, 2:3개월이내, 3:3개월이상)';
COMMENT ON COLUMN EST_APPLY.EST_REMARK IS '견적요청정보 - 상세정보';
COMMENT ON COLUMN EST_APPLY.CAR_PLATE_NUM IS '차량번호';
COMMENT ON COLUMN EST_APPLY.CAR_FULL_CODE IS '차량코드';
COMMENT ON COLUMN EST_APPLY.MAKER_NM IS '제조사명';
COMMENT ON COLUMN EST_APPLY.MODEL_NM IS '모델명';
COMMENT ON COLUMN EST_APPLY.DETAIL_MODEL_NM IS '상세모델명';
COMMENT ON COLUMN EST_APPLY.GRADE_NM IS '등급명';
COMMENT ON COLUMN EST_APPLY.CAR_REG_YEAR IS '년식 - 년도';
COMMENT ON COLUMN EST_APPLY.CAR_REG_MONTH IS '연식 - 월(1-12)';
COMMENT ON COLUMN EST_APPLY.CAR_MISSION IS '미션';
COMMENT ON COLUMN EST_APPLY.CAR_FUEL IS '연료';
COMMENT ON COLUMN EST_APPLY.USE_KM IS '주행거리';
COMMENT ON COLUMN EST_APPLY.CAR_COLOR IS '차량색상';
COMMENT ON COLUMN EST_APPLY.CAR_PHOTO_URL1 IS '사진URL1';
COMMENT ON COLUMN EST_APPLY.CAR_PHOTO_URL2 IS '사진URL2';
COMMENT ON COLUMN EST_APPLY.CAR_PHOTO_URL3 IS '사진URL3';
COMMENT ON COLUMN EST_APPLY.CAR_PHOTO_URL4 IS '사진URL4';
COMMENT ON COLUMN EST_APPLY.CAR_PHOTO_URL5 IS '사진URL5';
COMMENT ON COLUMN EST_APPLY.CAR_VIDEO_URL IS '동영상URL';
COMMENT ON COLUMN EST_APPLY.EST_REQ_RESULT_CD IS '견적요청처리결과코드';
COMMENT ON COLUMN EST_APPLY.EST_REQ_DATE IS '견적요청일';
COMMENT ON COLUMN EST_APPLY.EXTRA_MAKEUP_YN IS '부가서비스 - 메이크업 포함';
COMMENT ON COLUMN EST_APPLY.EXTRA_CONSIGN_YN IS '부가서비스 - 위탁판매 포함';
COMMENT ON COLUMN EST_APPLY.DANJI_NO IS '소속단지(직접방문인 경우만 설정)';
COMMENT ON COLUMN EST_APPLY.SHOP_NO IS '소속상사(직접방문인 경우만 설정)';
COMMENT ON COLUMN EST_APPLY.EST_RES_DATE IS '견적방문예약일';
COMMENT ON COLUMN EST_APPLY.EST_RES_TIME IS '견적방문예약시간(온라인통화후 확정시 입력)';
COMMENT ON TABLE EST_HIS IS '견적요청이력';
COMMENT ON COLUMN EST_HIS.MYCAR_SEQ IS 'MYCAR순번';
COMMENT ON COLUMN EST_HIS.EST_STATE IS '견적요청상태(10:요청, 20:회신)';
COMMENT ON COLUMN EST_HIS.EST_TYPE IS '견적요청종류(1:직접방문, 2:방문요청)';
COMMENT ON COLUMN EST_HIS.EST_USER_SITE_ID IS '견적요청정보-BNK ID(USER_ID)';
COMMENT ON COLUMN EST_HIS.EST_USER_NM IS '견적요청정보 - 이름';
COMMENT ON COLUMN EST_HIS.EST_USER_TEL IS '견적요청정보 - 연락처';
COMMENT ON COLUMN EST_HIS.EST_SIDO IS '견적요청정보 - 지역 시도';
COMMENT ON COLUMN EST_HIS.EST_SI_GUN_GU IS '견적요청정보 - 지역 시군구';
COMMENT ON COLUMN EST_HIS.EST_SALE_PERIOD IS '견적요청정보 - 판매시기(1:1개월이내, 2:3개월이내, 3:3개월이상)';
COMMENT ON COLUMN EST_HIS.EST_REMARK IS '견적요청정보 - 상세정보';
COMMENT ON COLUMN EST_HIS.CAR_FULL_CODE IS '차량코드';
COMMENT ON COLUMN EST_HIS.MAKER_NM IS '제조사명';
COMMENT ON COLUMN EST_HIS.MODEL_NM IS '모델명';
COMMENT ON COLUMN EST_HIS.DETAIL_MODEL_NM IS '상세모델명';
COMMENT ON COLUMN EST_HIS.GRADE_NM IS '등급명';
COMMENT ON COLUMN EST_HIS.CAR_REG_YEAR IS '년식 - 년도';
COMMENT ON COLUMN EST_HIS.CAR_REG_MONTH IS '연식 - 월(1-12)';
COMMENT ON COLUMN EST_HIS.CAR_MISSION IS '미션';
COMMENT ON COLUMN EST_HIS.CAR_FUEL IS '연료';
COMMENT ON COLUMN EST_HIS.USE_KM IS '주행거리';
COMMENT ON COLUMN EST_HIS.CAR_COLOR IS '차량색상';
COMMENT ON COLUMN EST_HIS.CAR_PHOTO_URL1 IS '사진URL1';
COMMENT ON COLUMN EST_HIS.CAR_PHOTO_URL2 IS '사진URL2';
COMMENT ON COLUMN EST_HIS.CAR_PHOTO_URL3 IS '사진URL3';
COMMENT ON COLUMN EST_HIS.CAR_PHOTO_URL4 IS '사진URL4';
COMMENT ON COLUMN EST_HIS.CAR_PHOTO_URL5 IS '사진URL5';
COMMENT ON COLUMN EST_HIS.CAR_VIDEO_URL IS '동영상URL';
COMMENT ON COLUMN EST_HIS.EST_REQ_RESULT_CD IS '견적요청처리결과코드';
COMMENT ON COLUMN EST_HIS.EST_REQ_DATE IS '견적요청일';
COMMENT ON COLUMN EST_HIS.EST_KEY IS '견적요청KEY';
COMMENT ON COLUMN EST_HIS.EST_RES_DATE IS '견적결과회신일';
COMMENT ON COLUMN EST_HIS.EST_RES_RESULT_CD IS '견적결과확인 결과';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NO1 IS '1 견적딜러 SHOPNO';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NM1 IS '1 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS.EST_SHOP_ADDR1 IS '1 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS.EST_DEALER_NM1 IS '1 견적딜러명';
COMMENT ON COLUMN EST_HIS.EST_DEALER_TEL1 IS '1 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS.EST_AMT1 IS '1 견적금액(만원단위)';
COMMENT ON COLUMN EST_HIS.EST_REMARK1 IS '1 견적딜러 추가내용';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NO2 IS '2 견적딜러 ShopNo';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NM2 IS '2 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS.EST_SHOP_ADDR2 IS '2 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS.EST_DEALER_NM2 IS '2 견적딜러명';
COMMENT ON COLUMN EST_HIS.EST_DEALER_TEL2 IS '2 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS.EST_AMT2 IS '2 견적가금액(만원단위)';
COMMENT ON COLUMN EST_HIS.EST_REMARK2 IS '2 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NO3 IS '3 견적딜러 ShopNo';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NM3 IS '3 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS.EST_SHOP_ADDR3 IS '3 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS.EST_DEALER_NM3 IS '3 견적딜러명';
COMMENT ON COLUMN EST_HIS.EST_DEALER_TEL3 IS '3 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS.EST_AMT3 IS '3 견적가금액(만원단위)';
COMMENT ON COLUMN EST_HIS.EST_REMARK3 IS '3 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NO4 IS '4 견적딜러 ShopNo';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NM4 IS '4 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS.EST_SHOP_ADDR4 IS '4 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS.EST_DEALER_NM4 IS '4 견적딜러명';
COMMENT ON COLUMN EST_HIS.EST_DEALER_TEL4 IS '4 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS.EST_AMT4 IS '4 견적가금액(만원단위)';
COMMENT ON COLUMN EST_HIS.EST_REMARK4 IS '4 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NO5 IS '5 견적딜러 ShopNo';
COMMENT ON COLUMN EST_HIS.EST_SHOP_NM5 IS '5 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS.EST_SHOP_ADDR5 IS '5 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS.EST_DEALER_NM5 IS '5 견적딜러명';
COMMENT ON COLUMN EST_HIS.EST_DEALER_TEL5 IS '5 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS.EST_AMT5 IS '5 견적가금액(만원단위)';
COMMENT ON COLUMN EST_HIS.EST_REMARK5 IS '5 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)';
COMMENT ON TABLE EST_HIS_BAK IS '견적요청이력(삭제이력)';
COMMENT ON COLUMN EST_HIS_BAK.MYCAR_SEQ IS 'MYCAR순번';
COMMENT ON COLUMN EST_HIS_BAK.EST_STATE IS '견적요청상태(10:요청, 20:회신)';
COMMENT ON COLUMN EST_HIS_BAK.EST_TYPE IS '견적요청종류(1:직접방문, 2:방문요청)';
COMMENT ON COLUMN EST_HIS_BAK.EST_USER_SITE_ID IS '견적요청정보-BNK ID(USER_ID)';
COMMENT ON COLUMN EST_HIS_BAK.EST_USER_NM IS '견적요청정보 - 이름';
COMMENT ON COLUMN EST_HIS_BAK.EST_USER_TEL IS '견적요청정보 - 연락처';
COMMENT ON COLUMN EST_HIS_BAK.EST_SIDO IS '견적요청정보 - 지역 시도';
COMMENT ON COLUMN EST_HIS_BAK.EST_SI_GUN_GU IS '견적요청정보 - 지역 시군구';
COMMENT ON COLUMN EST_HIS_BAK.EST_SALE_PERIOD IS '견적요청정보 - 판매시기(1:1개월이내, 2:3개월이내, 3:3개월이상)';
COMMENT ON COLUMN EST_HIS_BAK.EST_REMARK IS '견적요청정보 - 상세정보';
COMMENT ON COLUMN EST_HIS_BAK.CAR_FULL_CODE IS '차량코드';
COMMENT ON COLUMN EST_HIS_BAK.MAKER_NM IS '제조사명';
COMMENT ON COLUMN EST_HIS_BAK.MODEL_NM IS '모델명';
COMMENT ON COLUMN EST_HIS_BAK.DETAIL_MODEL_NM IS '상세모델명';
COMMENT ON COLUMN EST_HIS_BAK.GRADE_NM IS '등급명';
COMMENT ON COLUMN EST_HIS_BAK.CAR_REG_YEAR IS '년식 - 년도';
COMMENT ON COLUMN EST_HIS_BAK.CAR_REG_MONTH IS '연식 - 월(1-12)';
COMMENT ON COLUMN EST_HIS_BAK.CAR_MISSION IS '미션';
COMMENT ON COLUMN EST_HIS_BAK.CAR_FUEL IS '연료';
COMMENT ON COLUMN EST_HIS_BAK.USE_KM IS '주행거리';
COMMENT ON COLUMN EST_HIS_BAK.CAR_COLOR IS '차량색상';
COMMENT ON COLUMN EST_HIS_BAK.CAR_PHOTO_URL1 IS '사진URL1';
COMMENT ON COLUMN EST_HIS_BAK.CAR_PHOTO_URL2 IS '사진URL2';
COMMENT ON COLUMN EST_HIS_BAK.CAR_PHOTO_URL3 IS '사진URL3';
COMMENT ON COLUMN EST_HIS_BAK.CAR_PHOTO_URL4 IS '사진URL4';
COMMENT ON COLUMN EST_HIS_BAK.CAR_PHOTO_URL5 IS '사진URL5';
COMMENT ON COLUMN EST_HIS_BAK.CAR_VIDEO_URL IS '동영상URL';
COMMENT ON COLUMN EST_HIS_BAK.EST_REQ_RESULT_CD IS '견적요청처리결과코드';
COMMENT ON COLUMN EST_HIS_BAK.EST_REQ_DATE IS '견적요청일';
COMMENT ON COLUMN EST_HIS_BAK.EST_KEY IS '견적요청KEY';
COMMENT ON COLUMN EST_HIS_BAK.EST_RES_DATE IS '견적결과회신일';
COMMENT ON COLUMN EST_HIS_BAK.EST_RES_RESULT_CD IS '견적결과확인 결과';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NO1 IS '1 견적딜러 SHOPNO';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NM1 IS '1 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_ADDR1 IS '1 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_NM1 IS '1 견적딜러명';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_TEL1 IS '1 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS_BAK.EST_AMT1 IS '1 견적금액(만원단위)';
COMMENT ON COLUMN EST_HIS_BAK.EST_REMARK1 IS '1 견적딜러 추가내용';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NO2 IS '2 견적딜러 ShopNo';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NM2 IS '2 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_ADDR2 IS '2 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_NM2 IS '2 견적딜러명';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_TEL2 IS '2 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS_BAK.EST_AMT2 IS '2 견적가금액(만원단위)';
COMMENT ON COLUMN EST_HIS_BAK.EST_REMARK2 IS '2 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NO3 IS '3 견적딜러 ShopNo';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NM3 IS '3 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_ADDR3 IS '3 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_NM3 IS '3 견적딜러명';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_TEL3 IS '3 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS_BAK.EST_AMT3 IS '3 견적가금액(만원단위)';
COMMENT ON COLUMN EST_HIS_BAK.EST_REMARK3 IS '3 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NO4 IS '4 견적딜러 ShopNo';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NM4 IS '4 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_ADDR4 IS '4 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_NM4 IS '4 견적딜러명';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_TEL4 IS '4 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS_BAK.EST_AMT4 IS '4 견적가금액(만원단위)';
COMMENT ON COLUMN EST_HIS_BAK.EST_REMARK4 IS '4 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NO5 IS '5 견적딜러 ShopNo';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_NM5 IS '5 견적딜러 상사명';
COMMENT ON COLUMN EST_HIS_BAK.EST_SHOP_ADDR5 IS '5 견적딜러 상사 주소';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_NM5 IS '5 견적딜러명';
COMMENT ON COLUMN EST_HIS_BAK.EST_DEALER_TEL5 IS '5 견적딜러 연락처';
COMMENT ON COLUMN EST_HIS_BAK.EST_AMT5 IS '5 견적가금액(만원단위)';
COMMENT ON COLUMN EST_HIS_BAK.EST_REMARK5 IS '5 견적딜러 추가내용, 딜러가 하고싶은 말(max 2000 byte)';
COMMENT ON COLUMN EST_HIS_BAK.CREATED_DATE IS '생성일';
COMMENT ON TABLE FALSE_CAR IS '허위매물신고';
COMMENT ON COLUMN FALSE_CAR.CAR_SEQ IS '매물순번';
COMMENT ON COLUMN FALSE_CAR.FALSE_USER_ID IS '허위매물사용자ID';
COMMENT ON COLUMN FALSE_CAR.FALSE_USER_NM IS '신고자명';
COMMENT ON COLUMN FALSE_CAR.FALSE_USER_TEL IS '신고자 연락처';
COMMENT ON COLUMN FALSE_CAR.CAR_FULL_CODE IS '차량코드';
COMMENT ON COLUMN FALSE_CAR.CAR_PLATE_NUM IS '차량번호';
COMMENT ON COLUMN FALSE_CAR.SALE_AMT IS '판매가격';
COMMENT ON COLUMN FALSE_CAR.FALSE_TYPE IS '신고종류 코드:215';
COMMENT ON COLUMN FALSE_CAR.FALSE_REQ_REMARK IS '신고내용';
COMMENT ON COLUMN FALSE_CAR.CREATED_DATE IS '신고일';
COMMENT ON COLUMN FALSE_CAR.FALSE_STATE IS '신고처리상태 코드:214(1차오픈 미사용)';
COMMENT ON COLUMN FALSE_CAR.FALSE_SHOP_NO IS '신고매물소속상사';
COMMENT ON COLUMN FALSE_CAR.FALSE_DEALER_ID IS '신고매물판매딜러ID';
COMMENT ON COLUMN FALSE_CAR.FALSE_DEALER_NM IS '신고매물판매딜러명';
COMMENT ON COLUMN FALSE_CAR.FALSE_DEALER_TEL IS '신고매물판매딜러연락처';
COMMENT ON COLUMN FALSE_CAR.FALSE_RES_REMARK IS '처리내용';
COMMENT ON COLUMN FALSE_CAR.MODIFIER IS '마지막수정자';
COMMENT ON COLUMN FALSE_CAR.MODIFIED_DATE IS '마지막수정일';
COMMENT ON TABLE MAKEUP_HIS IS '메이크업신청이력';
COMMENT ON COLUMN MAKEUP_HIS.MAKEUP_SEQ IS '메이크업신청순번';
COMMENT ON COLUMN MAKEUP_HIS.MAKEUP_STATE IS '진행상태';
COMMENT ON COLUMN MAKEUP_HIS.DEALER_YN IS '딜러구분';
COMMENT ON COLUMN MAKEUP_HIS.USER_ID IS '사용자ID';
COMMENT ON COLUMN MAKEUP_HIS.CAR_PLATE_NUM IS '차량번호';
COMMENT ON COLUMN MAKEUP_HIS.CAR_SEQ IS '매물순번';
COMMENT ON COLUMN MAKEUP_HIS.REQ_ITEMS IS '요청서비스';
COMMENT ON COLUMN MAKEUP_HIS.REQ_REMARK IS '기타요청사항';
COMMENT ON COLUMN MAKEUP_HIS.CREATED_DATE IS '생성일';
COMMENT ON COLUMN MAKEUP_HIS.VISIT_DAY IS '서비스 - 방문일';
COMMENT ON COLUMN MAKEUP_HIS.VISIT_TIME IS '서비스 - 방문시간';
COMMENT ON COLUMN MAKEUP_HIS.VISIT_ADDR IS '방문지 주소';
COMMENT ON COLUMN MAKEUP_HIS.VISITOR_NM IS '담당자명';
COMMENT ON COLUMN MAKEUP_HIS.VISITOR_TEL IS '방문자연락처';
COMMENT ON TABLE MYCAR_MST IS '개인매물정보';
COMMENT ON COLUMN MYCAR_MST.MYCAR_SEQ IS '개인매물식별SEQ';
COMMENT ON COLUMN MYCAR_MST.USER_ID IS '회원아이디';
COMMENT ON COLUMN MYCAR_MST.CAR_PLATE_NUM IS '차량번호';
COMMENT ON COLUMN MYCAR_MST.CAR_FULL_CODE IS '차량코드';
COMMENT ON COLUMN MYCAR_MST.CAR_FRAME_NUM IS '차대번호';
COMMENT ON COLUMN MYCAR_MST.CAR_REG_DAY IS '차량최초등록일';
COMMENT ON COLUMN MYCAR_MST.CAR_REG_YEAR IS '연식';
COMMENT ON COLUMN MYCAR_MST.CAR_FUEL IS '연료';
COMMENT ON COLUMN MYCAR_MST.CAR_MISSION IS '미션';
COMMENT ON COLUMN MYCAR_MST.USE_KM IS '주행거리';
COMMENT ON COLUMN MYCAR_MST.CAR_COLOR IS '색상';
COMMENT ON COLUMN MYCAR_MST.SAGO_YN IS '사고여부';
COMMENT ON COLUMN MYCAR_MST.APPLY_DAY IS '차량등록일';
COMMENT ON COLUMN MYCAR_MST.SALE_AMT IS '차량 판매가';
COMMENT ON COLUMN MYCAR_MST.CAR_DESC IS '차량설명';
COMMENT ON COLUMN MYCAR_MST.EST_REQ_YN IS '견적요청여부';
COMMENT ON COLUMN MYCAR_MST.SHOP_NO IS '매매상사NO';
COMMENT ON COLUMN MYCAR_MST.ATTACH_CNT IS '압류건수';
COMMENT ON COLUMN MYCAR_MST.MORT_GAGE_CNT IS '저당건수';
COMMENT ON COLUMN MYCAR_MST.UNPAID_TAX IS '미납세금정보';
COMMENT ON COLUMN MYCAR_MST.FILE_ID IS '파일아이디';
COMMENT ON COLUMN MYCAR_MST.CREATOR IS '등록자';
COMMENT ON COLUMN MYCAR_MST.CREATED_DATE IS '등록일';
COMMENT ON COLUMN MYCAR_MST.MODIFIER IS '수정자';
COMMENT ON COLUMN MYCAR_MST.MODIFIED_DATE IS '마지막수정일';
COMMENT ON COLUMN MYCAR_MST.CAR_IMAGE_CNT IS '매물이미지등록건수';
COMMENT ON COLUMN MYCAR_MST.SURFACE_STATE IS '외관상태';
COMMENT ON COLUMN MYCAR_MST.RENT_YN IS '렌트카 사용여부';
COMMENT ON COLUMN MYCAR_MST.CAR_VIDEO_URL IS '동영상 url';
COMMENT ON COLUMN MYCAR_MST.CAR_AREA IS '차량지역';
COMMENT ON COLUMN MYCAR_MST.PARK_ZIP IS '주차위치 - 우편번호';
COMMENT ON COLUMN MYCAR_MST.PARK_ADDR1 IS '주차위치 기본주소';
COMMENT ON COLUMN MYCAR_MST.PARK_ADDR2 IS '주차위치 - 상세주소';
COMMENT ON COLUMN MYCAR_MST.EST_REQ_TYPE IS '견젹요청구분(코드209)';
COMMENT ON TABLE NAME_CARD_HIS IS '명함발송관리';
COMMENT ON COLUMN NAME_CARD_HIS.NAME_CARD_SEQ IS '명함발송순번';
COMMENT ON COLUMN NAME_CARD_HIS.DEALER_ID IS '딜러 사용자ID';
COMMENT ON COLUMN NAME_CARD_HIS.USER_ID IS '사용자ID';
COMMENT ON COLUMN NAME_CARD_HIS.CREATED_DATE IS '생성일';
COMMENT ON COLUMN NAME_CARD_HIS.READ_YN IS '확인여부';
COMMENT ON COLUMN NAME_CARD_HIS.SEND_DATE IS '발송일';
COMMENT ON COLUMN NAME_CARD_HIS.RESENT_YN IS '재발송여부';
COMMENT ON TABLE RES_HIS IS '예약 시승 탁송 요청이력';
COMMENT ON COLUMN RES_HIS.RES_HIS_SEQ IS '예약요청순번';
COMMENT ON COLUMN RES_HIS.CAR_PLATE_NUM IS '차량번호';
COMMENT ON COLUMN RES_HIS.DEALER_LICENSE_NO IS '딜러 종사자번호';
COMMENT ON COLUMN RES_HIS.RES_STATUS IS '예약상태';
COMMENT ON COLUMN RES_HIS.RES_KEY IS '예약요청 KEY';
COMMENT ON COLUMN RES_HIS.RES_TYPE IS '예약 요청 종류';
COMMENT ON COLUMN RES_HIS.RES_DATE IS '예약일자';
COMMENT ON COLUMN RES_HIS.RES_AMPM IS '예약일자 오전오후';
COMMENT ON COLUMN RES_HIS.RES_USER_NM IS '예약자정보 - 이름';
COMMENT ON COLUMN RES_HIS.RES_USER_TEL IS '예약자정보 - 연락처';
COMMENT ON COLUMN RES_HIS.RES_USER_ID IS '예약자정보 - BNKID';
COMMENT ON COLUMN RES_HIS.RES_REQ_DATE IS '예약신청일';
COMMENT ON COLUMN RES_HIS.RES_APPR_DATE IS '예약요청승인일';
COMMENT ON COLUMN RES_HIS.RES_APPR_USER_ID IS '승인자 ID';
COMMENT ON COLUMN RES_HIS.RES_CANCEL_DATE IS '예약요청취소일';
COMMENT ON COLUMN RES_HIS.USE_YN IS '사용여부';
COMMENT ON COLUMN RES_HIS.PARK_ZIP IS '탁송우편번호';
COMMENT ON COLUMN RES_HIS.PARK_ADDR1 IS '탁송주소';
COMMENT ON COLUMN RES_HIS.PARK_ADDR2 IS '탁송상세주소';
COMMENT ON COLUMN RES_HIS.CAR_SEQ IS '오토모아 매물SEQ';
COMMENT ON TABLE SND_HIS_PUSH IS 'PUSH발송이력';
COMMENT ON COLUMN SND_HIS_PUSH.SND_SEQ IS '발송순분';
COMMENT ON COLUMN SND_HIS_PUSH.SND_DIV IS '발송구분(p:개별, G:GROUP)';
COMMENT ON COLUMN SND_HIS_PUSH.MSG_TYPE IS 'MESSAGE TYPE';
COMMENT ON COLUMN SND_HIS_PUSH.SND_TO IS '개별수신자';
COMMENT ON COLUMN SND_HIS_PUSH.TITLE IS 'JSON MESSAGE TITLE';
COMMENT ON COLUMN SND_HIS_PUSH.BODY IS 'BODY(미사용)';
COMMENT ON COLUMN SND_HIS_PUSH.ICON IS 'ICON';
COMMENT ON COLUMN SND_HIS_PUSH.CLICK_ACTION IS 'CLICK_ACTION';
COMMENT ON COLUMN SND_HIS_PUSH.MESSAGE_ID IS 'RESULT : MESSAGE_ID';
COMMENT ON COLUMN SND_HIS_PUSH.ERROR_MSG IS 'ERROR_MSG';
COMMENT ON COLUMN SND_HIS_PUSH.CREATED_DATE IS '생성일';
COMMENT ON COLUMN SND_HIS_PUSH.CREATOR IS '생성자(요청자)';
COMMENT ON COLUMN SND_HIS_PUSH.DEVICE_TYPE IS 'DEVICE_TYPE';
COMMENT ON TABLE T2_AUTHORITIES IS '사용자권한';
COMMENT ON COLUMN T2_AUTHORITIES.USER_ID IS '사용자ID';
COMMENT ON COLUMN T2_AUTHORITIES.AUTHORITY IS '권한';
COMMENT ON TABLE T2_CODE IS '코드정보';
COMMENT ON COLUMN T2_CODE.CD_NO IS '코드번호';
COMMENT ON COLUMN T2_CODE.CD_NM IS '코드명';
COMMENT ON COLUMN T2_CODE.CD_EXP IS '코드설명';
COMMENT ON COLUMN T2_CODE.SYS_CD_YN IS '시스템코드여부';
COMMENT ON TABLE T2_CODE_DTL IS '공통코드상세';
COMMENT ON COLUMN T2_CODE_DTL.CD_NO IS '코드번호';
COMMENT ON COLUMN T2_CODE_DTL.CD_DTL_NO IS '상세코드번호';
COMMENT ON COLUMN T2_CODE_DTL.CD_DTL_NM IS '상세코드명';
COMMENT ON COLUMN T2_CODE_DTL.CD_SUB_NO IS '하위코드';
COMMENT ON COLUMN T2_CODE_DTL.CD_DTL_EXP IS '상세코드설명';
COMMENT ON COLUMN T2_CODE_DTL.CD_ORDER IS '표시순';
COMMENT ON COLUMN T2_CODE_DTL.USE_YN IS '사용여부';
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
COMMENT ON COLUMN T2_FILE.CAR_DIV IS 'CAR IMAGE인 경우만 설정 CAR_MST:C, MYCAR_MST:M';
COMMENT ON COLUMN T2_FILE.ORG_FILE_URL IS '디카매물원본이미지URL';
COMMENT ON TABLE T2_ROLES IS '권한별역활';
COMMENT ON COLUMN T2_ROLES.AUTHORITY IS '권한';
COMMENT ON COLUMN T2_ROLES.ROLE_NAME IS '역활명';
COMMENT ON COLUMN T2_ROLES.DESCRIPTION IS '설명';
COMMENT ON COLUMN T2_ROLES.LOGIN_SUCC_URL IS '로그인 성공시 표시화면';
COMMENT ON COLUMN T2_ROLES.ODR IS '우선순위';
COMMENT ON TABLE T2_ROLES_HIERARCHY IS '역활 관계';
COMMENT ON COLUMN T2_ROLES_HIERARCHY.PARENT_ROLE IS '부모역활';
COMMENT ON COLUMN T2_ROLES_HIERARCHY.CHILD_ROLE IS '자식역활';
COMMENT ON TABLE T2_SECURED_RESOURCES IS '보증 리소스';
COMMENT ON COLUMN T2_SECURED_RESOURCES.RESOURCE_ID IS '리소스 ID';
COMMENT ON COLUMN T2_SECURED_RESOURCES.RESOURCE_NAME IS '리소스명';
COMMENT ON COLUMN T2_SECURED_RESOURCES.RESOURCE_PATTERN IS '리소스 패턴';
COMMENT ON COLUMN T2_SECURED_RESOURCES.DESCRIPTION IS '설명';
COMMENT ON COLUMN T2_SECURED_RESOURCES.RESOURCE_TYPE IS '리소스 종류';
COMMENT ON COLUMN T2_SECURED_RESOURCES.SORT_ORDER IS '정렬순';
COMMENT ON COLUMN T2_SECURED_RESOURCES.DEPTH IS 'DEPTH';
COMMENT ON TABLE T2_SECURED_RESOURCES_ROLE IS '보증 리소스별 권한';
COMMENT ON COLUMN T2_SECURED_RESOURCES_ROLE.RESOURCE_ID IS '리스소ID';
COMMENT ON COLUMN T2_SECURED_RESOURCES_ROLE.AUTHORITY IS '권한';
COMMENT ON TABLE T2_USERS IS '사용자정보';
COMMENT ON COLUMN T2_USERS.USER_ID IS '사용자ID';
COMMENT ON COLUMN T2_USERS.USER_NAME IS '사용자명';
COMMENT ON COLUMN T2_USERS.PASSWORD IS '패스워드';
COMMENT ON COLUMN T2_USERS.PHONE_MOBILE IS '전화번호';
COMMENT ON COLUMN T2_USERS.PHONE_DIRECT IS '연락처2';
COMMENT ON COLUMN T2_USERS.EMAIL IS 'EMAIL';
COMMENT ON COLUMN T2_USERS.DIVISION IS '사용자구분';
COMMENT ON COLUMN T2_USERS.USE_YN IS '사용여부';
COMMENT ON COLUMN T2_USERS.CREATOR IS '생성자';
COMMENT ON COLUMN T2_USERS.CREATED_DATE IS '생성일';
COMMENT ON COLUMN T2_USERS.MODIFIER IS '수정자';
COMMENT ON COLUMN T2_USERS.MODIFIED_DATE IS '수정일';
COMMENT ON COLUMN T2_USERS.LAST_LOGIN_DATE IS '마지막 로그인 일시';
COMMENT ON COLUMN T2_USERS.ENABLED IS '사용가능여부';
COMMENT ON COLUMN T2_USERS.USER_DIV IS '사용자구분(''10'':일반, ''20'':딜러)';
COMMENT ON COLUMN T2_USERS.DEALER_LICENSE_NO IS '종사자번호';
COMMENT ON COLUMN T2_USERS.GRADE IS '사용자등급';
COMMENT ON COLUMN T2_USERS.GRADE_DEALER IS '딜러 등급';
COMMENT ON COLUMN T2_USERS.ZIP_CODE IS '우편번호';
COMMENT ON COLUMN T2_USERS.ADDR1 IS '주소1';
COMMENT ON COLUMN T2_USERS.ADDR2 IS '주소2';
COMMENT ON COLUMN T2_USERS.AGREE_SMS_YN IS 'SMS 약관 동의';
COMMENT ON COLUMN T2_USERS.AGREE_PUSH_YN IS 'PHSH 발송 약관 동의';
COMMENT ON COLUMN T2_USERS.AGREE_MARKETING IS '마케팅 이용약관 동의';
COMMENT ON COLUMN T2_USERS.SHOP_NO IS '소속 매매 상사 번호';
COMMENT ON COLUMN T2_USERS.ACTUAL_PHONE_MOBILE IS '실사용 휴대폰 번호';
COMMENT ON COLUMN T2_USERS.BNK_CONF_YN IS 'BIN인증 딜러';
COMMENT ON COLUMN T2_USERS.DANJI_NO IS '단지번호';
COMMENT ON COLUMN T2_USERS.SALE_CNT IS '판매건수';
COMMENT ON COLUMN T2_USERS.DEALER_PROFILE_FILE_SEQ IS '딜러 프로필 사진 FILE 순번';
COMMENT ON COLUMN T2_USERS.SHOP_ETC IS 'SHOP_ETC';
COMMENT ON COLUMN T2_USERS.PREM_CONF_YN IS '프리미엄 인증 중고차';
COMMENT ON COLUMN T2_USERS.DEALER_PROFILE_DESC IS '딜러 프로필 설명';
COMMENT ON COLUMN T2_USERS.DEALER_PROFILE_TEL IS '딜러 프로필 연락처';
COMMENT ON COLUMN T2_USERS.MIGRATION_FLAG IS '초기 입수 DATA의 사용자 여부';
COMMENT ON COLUMN T2_USERS.GUAR_FRUITLESS_CNT IS '헛걸음 보장 상품 잔여 개수';
COMMENT ON COLUMN T2_USERS.GUAR_REFUND_CNT IS '환불보장 상품 잔여 개수';
COMMENT ON COLUMN T2_USERS.GUAR_TERM_CNT IS '보장기간연장 상품 잔여 개수';
COMMENT ON TABLE TBL_QUESTION IS '문의내용';
COMMENT ON COLUMN TBL_QUESTION.QT_SEQ IS '문의글 순번';
COMMENT ON COLUMN TBL_QUESTION.TITLE IS '제목';
COMMENT ON COLUMN TBL_QUESTION.CONTENTS IS '내용';
COMMENT ON COLUMN TBL_QUESTION.QC_STATUS IS '문의글 현재 상태';
COMMENT ON COLUMN TBL_QUESTION.REG_ID IS '등록자';
COMMENT ON COLUMN TBL_QUESTION.REG_DT IS '등록일';
COMMENT ON COLUMN TBL_QUESTION.MOD_ID IS '수정자ID';
COMMENT ON COLUMN TBL_QUESTION.MOD_DT IS '수정일';
COMMENT ON COLUMN TBL_QUESTION.DEL_YN IS '삭제여부';
COMMENT ON TABLE TBL_QUESTION_ANSWER IS '문의내용답변';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.QA_SEQ IS '문의글답변순번';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.QT_SEQ IS '문의글 순번';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.P_KEY IS '부모 답변 키';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.CONTENTS IS '내용';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.REG_ID IS '등록자';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.REG_DT IS '등록일';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.MOD_ID IS '수정자';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.MOD_DT IS '수정일';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.DEL_YN IS '삭제여부';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.READ_YN IS 'READ_YN';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.SND_PUSH_YN IS 'SND_PUSH_YN';
COMMENT ON COLUMN TBL_QUESTION_ANSWER.SND_PUSH_DATE IS 'SND_PUSH_DATE';
COMMENT ON TABLE USER_DIVICE IS '사용자디바이스정보';
COMMENT ON COLUMN USER_DIVICE.USER_ID IS 'USER_ID';
COMMENT ON COLUMN USER_DIVICE.TOKEN_ID IS 'TOKEN_ID';
COMMENT ON COLUMN USER_DIVICE.DIVICE_TYPE IS 'DIVICE_TYPE(A:ANDROID, I:IOS';
COMMENT ON COLUMN USER_DIVICE.APP_VERSION IS 'APP VERSION';
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



