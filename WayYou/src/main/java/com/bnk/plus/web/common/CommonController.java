package com.bnk.plus.web.common;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.commons.util.StringUtil;
import com.bnk.plus.config.AppConstBean;
import com.bnk.plus.entity.CarMarketInfoShop;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.car.service.CarMarketInfoService;
import com.bnk.plus.service.session.service.T2UserService;

@Controller
@RequestMapping(value = {"/front/common"})
public class CommonController extends CoTopComponent {

    private final String tilesPrefix 	= "tiles.front.common.";
    private String mTrCert 				= "";
    private String mCpid 				= "CFLM1001";				// 회원사 ID
    private String mUrlCode				= "";						// URL 코드
    private String mCertNum				= "";						// 요청번호
    private String mDate				= "";						// 요청일시
    private String mTrUrl				= "";						// 결과수신 URL
    private String extendVar     		= "0000000000000000";       // 확장변수
    @Autowired
    T2UserService t2UserService;
    @Autowired
    CarMarketInfoService carMarketInfoService;

    /*
     * 내용   : 회원가입 초기 화면(일반인지, 딜러인지)
     * 개발자 : 김예지
     */
    @RequestMapping(value = {"/joinKind"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memberAgree(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load join_kind");

        return tilesPrefix+"join_kind";
    }

    /*
    * 내용   : 회원가입 초기 화면(동의체크 - 일반)
    * 개발자 : 김예지
    */
    @RequestMapping(value={"/memberAgree"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memAgree(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_agree");
        // 결과 받을 URL
        mTrUrl = "https://bnkautomoa.co.kr/m" + CoConstDef.KMC_URL_RESULT_PAGE;

        // 요청 CODE
//        mUrlCode = "001001";
        mUrlCode = CoConstDef.KMC_URL_CD_MEMBER_AGREE;

        //날짜 생성
        Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        mDate = sdf.format(today.getTime());

        java.util.Random ran = new Random();
        //랜덤 문자 길이
        int numLength = 6;
        String randomStr = "";

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr += ran.nextInt(10);
        }

		//reqNum은 최대 40byte 까지 사용 가능
        mCertNum = mDate + randomStr;

        //01. 한국모바일인증(주) 암호화 모듈 선언
        com.icert.comm.secu.IcertSecuManager seed  = new com.icert.comm.secu.IcertSecuManager();

     	//02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
     	String enc_tr_cert = "";
     	// 테스트용
     	//mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/"+ certMet +"/"+ birthDay +"/"+ gender +"/"+ name +"/"+ phoneNo +"/"+ phoneCorp +"/"+ nation +"/"+ plusInfo +"/"+ extendVar;

     	// 실제용
     	mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/" +"M" + "/"+ "/"+ "/"+ "/"+ "/"+ "/"+ "/"+ mUrlCode +"/";
     	enc_tr_cert        = seed.getEnc(mTrCert, "");

     	//03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
     	String hmacMsg = "";
     	hmacMsg = seed.getMsg(enc_tr_cert);

     	//04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
     	mTrCert  = seed.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + extendVar, "");

     	model.addAttribute("tr_cert",mTrCert);
     	model.addAttribute("tr_url",mTrUrl);

        return tilesPrefix+"member_agree";
    }

    /*
     * 내용   : 회원가입 초기 화면(동의체크 - 딜러)
     * 개발자 : 김예지
     */
    @RequestMapping(value={"/memberAgreeDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memberAgreeDealer(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_agree_dealer");
        // 결과 받을 URL
        mTrUrl = "https://bnkautomoa.co.kr/m" + CoConstDef.KMC_URL_RESULT_PAGE;
        // 요청 CODE
        mUrlCode = CoConstDef.KMC_URL_CD_MEMBER_AGREE_DEALER;

        //날짜 생성
        Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        mDate = sdf.format(today.getTime());

        java.util.Random ran = new Random();
        //랜덤 문자 길이
        int numLength = 6;
        String randomStr = "";

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr += ran.nextInt(10);
        }

		//reqNum은 최대 40byte 까지 사용 가능
        mCertNum = mDate + randomStr;

        //01. 한국모바일인증(주) 암호화 모듈 선언
        com.icert.comm.secu.IcertSecuManager seed  = new com.icert.comm.secu.IcertSecuManager();

     	//02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
     	String enc_tr_cert = "";
     	// 테스트용
     	//mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/"+ certMet +"/"+ birthDay +"/"+ gender +"/"+ name +"/"+ phoneNo +"/"+ phoneCorp +"/"+ nation +"/"+ plusInfo +"/"+ extendVar;

     	// 실제용
     	mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/" +"M" + "/"+ "/"+ "/"+ "/"+ "/"+ "/"+ "/";
     	enc_tr_cert        = seed.getEnc(mTrCert, "");

     	//03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
     	String hmacMsg = "";
     	hmacMsg = seed.getMsg(enc_tr_cert);

     	//04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
     	mTrCert  = seed.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + extendVar, "");

     	model.addAttribute("tr_cert",mTrCert);
     	model.addAttribute("tr_url",mTrUrl);

        return tilesPrefix+"member_agree_dealer";
    }


    /*
     * 내용   : 일반 회원 회원가입 결과 화면
     * 개발자 : 최정주
     */
    @RequestMapping(value={"/kmcResult"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memResultJoin(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load kmcResult");
        String rec_cert		= "";           // 결과수신DATA
    	String k_certNum = "";			    // 파라미터로 수신한 요청번호
    	String certNum		= "";			// 요청번호
        String date			= "";			// 요청일시
    	String CI	    	= "";			// 연계정보(CI)
    	String DI	    	= "";			// 중복가입확인정보(DI)
        String phoneNo		= "";			// 휴대폰번호
    	String phoneCorp	= "";			// 이동통신사
    	String birthDay		= "";			// 생년월일
    	String gender		= "";			// 성별
    	String nation		= "";			// 내국인
    	String name			= "";			// 성명
        String result		= "";			// 결과값

        String certMet		= "";			// 인증방법

        String plusInfo		= "";			// 추가정보

    	String encPara		= "";
    	String encMsg1		= "";
    	String encMsg2		= "";
    	String msgChk       = "";

    	String viewUrl		= "";

    	 try{

	        // Parameter 수신 --------------------------------------------------------------------
	        rec_cert       = req.getParameter("rec_cert").trim();
	        k_certNum      = req.getParameter("certNum").trim();

	      //01. 암호화 모듈 (jar) Loading
	        com.icert.comm.secu.IcertSecuManager seed = new com.icert.comm.secu.IcertSecuManager();

	        //02. 1차 복호화
	        //수신된 certNum를 이용하여 복호화
	        rec_cert  = seed.getDec(rec_cert, k_certNum);

	        //03. 1차 파싱
	        int inf1 = rec_cert.indexOf("/",0);
	        int inf2 = rec_cert.indexOf("/",inf1+1);

			encPara  = rec_cert.substring(0,inf1);         //암호화된 통합 파라미터
	        encMsg1  = rec_cert.substring(inf1+1,inf2);    //암호화된 통합 파라미터의 Hash값

			//04. 위변조 검증
			encMsg2  = seed.getMsg(encPara);

	        if(encMsg2.equals(encMsg1)){
	            msgChk="Y";
	        }

	      //05. 2차 복호화
			rec_cert  = seed.getDec(encPara, k_certNum);

	        //06. 2차 파싱
	        int info1  = rec_cert.indexOf("/",0);
	        int info2  = rec_cert.indexOf("/",info1+1);
	        int info3  = rec_cert.indexOf("/",info2+1);
	        int info4  = rec_cert.indexOf("/",info3+1);
	        int info5  = rec_cert.indexOf("/",info4+1);
	        int info6  = rec_cert.indexOf("/",info5+1);
	        int info7  = rec_cert.indexOf("/",info6+1);
	        int info8  = rec_cert.indexOf("/",info7+1);
			int info9  = rec_cert.indexOf("/",info8+1);
			int info10 = rec_cert.indexOf("/",info9+1);
			int info11 = rec_cert.indexOf("/",info10+1);
			int info12 = rec_cert.indexOf("/",info11+1);
			int info13 = rec_cert.indexOf("/",info12+1);
			int info14 = rec_cert.indexOf("/",info13+1);
			int info15 = rec_cert.indexOf("/",info14+1);
			int info16 = rec_cert.indexOf("/",info15+1);
			int info17 = rec_cert.indexOf("/",info16+1);
			int info18 = rec_cert.indexOf("/",info17+1);

	        certNum		= rec_cert.substring(0,info1);
	        date		= rec_cert.substring(info1+1,info2);
	        CI			= rec_cert.substring(info2+1,info3);
	        phoneNo		= rec_cert.substring(info3+1,info4);
	        phoneCorp	= rec_cert.substring(info4+1,info5);
	        birthDay	= rec_cert.substring(info5+1,info6);
	        gender		= rec_cert.substring(info6+1,info7);
	        nation		= rec_cert.substring(info7+1,info8);
			name		= rec_cert.substring(info8+1,info9);
			result		= rec_cert.substring(info9+1,info10);
			certMet		= rec_cert.substring(info10+1,info11);
			plusInfo	= rec_cert.substring(info16+1,info17);
			DI      	= rec_cert.substring(info17+1,info18);

	        //07. CI, DI 복호화
	        CI  = seed.getDec(CI, k_certNum);
	        DI  = seed.getDec(DI, k_certNum);

			// Start - 수신내역 유효성 검증(사설망의 사설 IP로 인해 미사용, 공용망의 경우 확인 후 사용) *********************/
			// 1. date 값 검증
			SimpleDateFormat formatter	= new SimpleDateFormat("yyyyMMddHHmmss",Locale.KOREAN); // 현재 서버 시각 구하기
			String strCurrentTime	= formatter.format(new Date());

			Date toDate				= formatter.parse(strCurrentTime);
			Date fromDate			= formatter.parse(date);
			long timediff			= toDate.getTime()-fromDate.getTime();

			if ( timediff < -30*60*1000 || 30*60*100 < timediff  ){
				//System.out.println("비정상적인 접근입니다.(요청시간경과");
				//return;
			}

			model.addAttribute("name",name);
			model.addAttribute("phoneNo",phoneNo);
			model.addAttribute("urlCode",plusInfo);

			/*if("N".equals(result)){
				return tilesPrefix+"member_join";
			}else{
			}*/

    	 }catch(Exception ex){
             System.out.println("[KMCIS] Receive Error -"+ex.getMessage());
       }

    	 return tilesPrefix+"member_result_join";

    }


    /*
     * 내용   : 일반 회원 회원가입 초기 화면(회원 정보 입력 화면)
     * 개발자 : 김예지
     */
    @RequestMapping(value={"/memberJoin"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memJoin(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_join");
    	 try{
	        // Parameter 수신 --------------------------------------------------------------------
			model.addAttribute("name",req.getParameter("name"));		// 성명
			model.addAttribute("phoneNo",req.getParameter("phoneNo"));	// 휴대폰번호
    	 }catch(Exception ex){
             System.out.println("[KMCIS] Receive Error -"+ex.getMessage());
       }

    	 return tilesPrefix+"member_join";

    }

    /*
     * 내용   : 딜러 회원 회원가입 초기 화면(회원 정보 입력 화면)
     * 개발자 : 김예지
     */
    @RequestMapping(value={"/memberJoinDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memJoinDealer(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_join_dealer");
    	 try{
	        // Parameter 수신 --------------------------------------------------------------------
    		model.addAttribute("name",req.getParameter("name"));
 			model.addAttribute("phoneNo",req.getParameter("phoneNo"));
    	 }catch(Exception ex){
             System.out.println("[KMCIS] Receive Error -"+ex.getMessage());
    	 }

        return tilesPrefix+"member_join_dealer";
    }

    /*
     * 내용   : 비밀번호 변경전 화면
     * 개발자 : 최정주
     */
    @RequestMapping(value={"/pwResetBefore"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String pwResetBefore(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load pwResetBefore");

        // 결과 받을 URL
        mTrUrl = "https://bnkautomoa.co.kr/m" + CoConstDef.KMC_URL_RESULT_PAGE;
        // 요청 CODE
        mUrlCode = CoConstDef.KMC_URL_CD_PASSWORD_RESET_BEFORE;

        //날짜 생성
        Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        mDate = sdf.format(today.getTime());

        java.util.Random ran = new Random();
        //랜덤 문자 길이
        int numLength = 6;
        String randomStr = "";

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr += ran.nextInt(10);
        }

		//reqNum은 최대 40byte 까지 사용 가능
        mCertNum = mDate + randomStr;

        //01. 한국모바일인증(주) 암호화 모듈 선언
        com.icert.comm.secu.IcertSecuManager seed  = new com.icert.comm.secu.IcertSecuManager();

     	//02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
     	String enc_tr_cert = "";
     	// 테스트용
     	//mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/"+ certMet +"/"+ birthDay +"/"+ gender +"/"+ name +"/"+ phoneNo +"/"+ phoneCorp +"/"+ nation +"/"+ plusInfo +"/"+ extendVar;

     	// 실제용
     	mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/" +"M" + "/"+ "/"+ "/"+ "/"+ "/"+ "/"+ "/";
     	enc_tr_cert        = seed.getEnc(mTrCert, "");

     	//03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
     	String hmacMsg = "";
     	hmacMsg = seed.getMsg(enc_tr_cert);

     	//04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
     	mTrCert  = seed.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + extendVar, "");

     	model.addAttribute("tr_cert",mTrCert);
     	model.addAttribute("tr_url",mTrUrl);

        return tilesPrefix+"pw_reset_before";
    }

    /*
     * 내용   : 비밀번호 변경
     * 개발자 : 김예지
     */
    @RequestMapping(value={"/pwReset"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String pwReset(HttpServletRequest req, HttpServletResponse res, Model model){
    	mlog_usual.debug(" :: Load pw_reset");
    	 try{
	        // Parameter 수신 --------------------------------------------------------------------
    		model.addAttribute("name",req.getParameter("name"));
 			model.addAttribute("phoneNo",req.getParameter("phoneNo"));
    	 }catch(Exception ex){
             System.out.println("[KMCIS] Receive Error -"+ex.getMessage());
    	 }
        return tilesPrefix+"pw_reset";
    }

    /*
     * 내용   : 회원정보 수정 초기화면 (일반)
     * 개발자 : 김예지
     */
    @RequestMapping(value={"/memberModify"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memModify(T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_modify");

	    // 결과 받을 URL
	    mTrUrl = "https://bnkautomoa.co.kr/m" + CoConstDef.KMC_URL_RESULT_PAGE;
	    // 요청 CODE
	    mUrlCode = CoConstDef.KMC_URL_CD_MEMBER_MODIFY;

	    //날짜 생성
	    Calendar today = Calendar.getInstance();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	    mDate = sdf.format(today.getTime());

	    java.util.Random ran = new Random();
	    //랜덤 문자 길이
	    int numLength = 6;
	    String randomStr = "";

	    for (int i = 0; i < numLength; i++) {
	        //0 ~ 9 랜덤 숫자 생성
	        randomStr += ran.nextInt(10);
	    }

		//reqNum은 최대 40byte 까지 사용 가능
	    mCertNum = mDate + randomStr;

	    //01. 한국모바일인증(주) 암호화 모듈 선언
	    com.icert.comm.secu.IcertSecuManager seed  = new com.icert.comm.secu.IcertSecuManager();

	   	//02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
	   	String enc_tr_cert = "";
	   	// 테스트용
	   	//mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/"+ certMet +"/"+ birthDay +"/"+ gender +"/"+ name +"/"+ phoneNo +"/"+ phoneCorp +"/"+ nation +"/"+ plusInfo +"/"+ extendVar;

	   	// 실제용
	   	mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/" +"M" + "/"+ "/"+ "/"+ "/"+ "/"+ "/"+ "/";
	   	enc_tr_cert        = seed.getEnc(mTrCert, "");

	   	//03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
	   	String hmacMsg = "";
	   	hmacMsg = seed.getMsg(enc_tr_cert);

	   	//04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
	   	mTrCert  = seed.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + extendVar, "");

	   	model.addAttribute("tr_cert",mTrCert);
	   	model.addAttribute("tr_url",mTrUrl);


        T2Users userInfo = t2UserService.getUser(t2Users);

        model.addAttribute("userInfo",toJson(userInfo));
        model.addAttribute("userInfo",userInfo);
        model.addAttribute("pageTitle","회원정보수정 - 일반");

        return tilesPrefix+"member_modify";
    }

    /*
     * 내용   : 회원정보 수정 초기화면 (딜러)
     * 개발자 : 김예지
     */
    @RequestMapping(value={"/memberModifyDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memModifyDealer(T2Users t2Users,CarMarketInfoShop carMarketInfoShop,HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_modify_dealer");

     // 결과 받을 URL
	    mTrUrl = "https://bnkautomoa.co.kr/m" + CoConstDef.KMC_URL_RESULT_PAGE;
	    // 요청 CODE
	    mUrlCode = CoConstDef.KMC_URL_CD_MEMBER_MODIFY_DEALER;

	    //날짜 생성
	    Calendar today = Calendar.getInstance();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	    mDate = sdf.format(today.getTime());

	    java.util.Random ran = new Random();
	    //랜덤 문자 길이
	    int numLength = 6;
	    String randomStr = "";

	    for (int i = 0; i < numLength; i++) {
	        //0 ~ 9 랜덤 숫자 생성
	        randomStr += ran.nextInt(10);
	    }

		//reqNum은 최대 40byte 까지 사용 가능
	    mCertNum = mDate + randomStr;

	    //01. 한국모바일인증(주) 암호화 모듈 선언
	    com.icert.comm.secu.IcertSecuManager seed  = new com.icert.comm.secu.IcertSecuManager();

	   	//02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
	   	String enc_tr_cert = "";
	   	// 테스트용
	   	//mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/"+ certMet +"/"+ birthDay +"/"+ gender +"/"+ name +"/"+ phoneNo +"/"+ phoneCorp +"/"+ nation +"/"+ plusInfo +"/"+ extendVar;

	   	// 실제용
	   	mTrCert            = mCpid +"/"+ mUrlCode +"/"+ mCertNum +"/"+ mDate +"/" +"M" + "/"+ "/"+ "/"+ "/"+ "/"+ "/"+ "/";
	   	enc_tr_cert        = seed.getEnc(mTrCert, "");

	   	//03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
	   	String hmacMsg = "";
	   	hmacMsg = seed.getMsg(enc_tr_cert);

	   	//04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
	   	mTrCert  = seed.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + extendVar, "");

	   	model.addAttribute("tr_cert",mTrCert);
	   	model.addAttribute("tr_url",mTrUrl);

        T2Users userInfo = t2UserService.getUser(t2Users);
        model.addAttribute("userInfo",toJson(userInfo));
        model.addAttribute("userInfo",userInfo);
        model.addAttribute("pageTitle","회원정보수정 - 딜러");

        return tilesPrefix+"member_modify_dealer";
    }

    /*
     * 내용   : 회원정보 등록
     * 개발자 : 김예지
     */
    @RequestMapping(value = {"/insertUser"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> insertUser(CarMarketInfoShop carMarketInfoShop,@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load insertUser");
        Map<String, Object> resMap = new HashMap<>();

        //이름, 핸드폰 번호 중복체크
        int rslt = t2UserService.selectDuplicateByPhNm(t2Users);

        //일반 회원일 경우
        if("N".equals(t2Users.getDivision())){
            if(rslt != 0){
                resMap.put("result", rslt);
                return makeJsonResponseHeader(resMap);
            }else{
                //회원가입
                t2UserService.addNewUsers(t2Users);
                return makeJsonResponseHeader(resMap);
            }
        }else{//딜러일 경우
            //딜러가 입력한 정보에 해당하는 종사자번호가 유효한지 체크
            String rsltDealer = carMarketInfoService.getDealerChk(t2Users);
            //딜러가 입력한 정보가 이미 회원가입이 되어있는지 체크(이름과 종사자번호로)
            int chkDealer  = t2UserService.selectDuplicateByDealerNo(t2Users);

            //입력한 정보가 false 값을 반납 할 때
            if("N".equals(rsltDealer)){
                resMap.put("rsltDealer", rsltDealer);
                return makeJsonResponseHeader(resMap);
            }else{
                //기존 등록 된 사용자일경우(이름과 핸드폰 번호로 체크)
                if(rslt != 0){
                    resMap.put("result", rslt);
                    return makeJsonResponseHeader(resMap);
                }
                //기존 등록 된 사용자일경우(이름과 종사자번호로 체크)
                if(chkDealer != 0){
                    resMap.put("chkDealer", chkDealer);
                    return makeJsonResponseHeader(resMap);
                }else{
                    //회원가입
                    t2UserService.addNewUsers(t2Users);
                    return makeJsonResponseHeader(resMap);
                }
            }
        }
    }

    /*
     * 내용   : 회원정보 수정(일반, 딜러)
     * 개발자 : 김예지
     */
    @RequestMapping(value = {"/updateUser"}, method =RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> updateUser(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load updateUser");
        Map<String, Object> resMap = new HashMap<>();
        String resCd="00";

        /*if("D".equals(t2Users.getDivision())){
            t2Users.setAgreePushYn("Y");
            t2Users.setAgreeSmsYn("Y");
            T2Users user = t2UserService.getUser(t2Users);
            if(StringUtil.notEquals(t2Users.getDealerLicenseNo(), user.getDealerLicenseNo())){
            	resCd="10";
            	resMap.put("resCd", resCd);
            	return makeJsonResponseHeader(resMap);
            }
        }*/

        try{
        	t2UserService.updateUsers(t2Users);
        }catch(Exception e){
        	resCd="99";
        }

        resMap.put("resCd", resCd);

        return makeJsonResponseHeader(resMap);
    }

    /*
     * 내용   : 회원탈퇴
     *
     */
    @RequestMapping(value={"/memberSecession"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memberSecession(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_secession");

        return tilesPrefix+"member_secession";
    }

    /*
     * 내용   : 딜러회원 소속단체 검색
     * 개발자 : 김예지
     */
    @RequestMapping(value = {"/searchGroup"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> searchGroup(@RequestBody CarMarketInfoShop carMarketInfoShop, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load searchGroup");

        HashMap<String, Object> resMap = new HashMap<>();
        //소속단체 찾기
        resMap = carMarketInfoService.getGroupList(carMarketInfoShop);

        return makeJsonResponseHeader(resMap);
    }

    /*
     * 내용   : 딜러회원 소속상사 검색
     * 개발자 : 김예지
     */
    @RequestMapping(value = {"/searchFirm"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> searchFirm(@RequestBody CarMarketInfoShop carMarketInfoShop, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load searchFirm");

        HashMap<String, Object> resMap = new HashMap<>();

        //소속상사 찾기
        resMap = carMarketInfoService.getFirmList(carMarketInfoShop);

        return makeJsonResponseHeader(resMap);
    }

    /*
     * 내용   : 비밀번호 변경
     * 개발자 : 김예지
     */
    @RequestMapping(value = {"/chkUpdatePw"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> chkUpdatePw(@RequestBody T2Users t2users, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load chkUpdatePw");
        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";
        //입력한 현재비밀번호와 기존 비밀번호가 동일한지 확인
        String str = t2users.getOldPw();
        //기존비밀번호 가져오기
        String getPassword = t2UserService.getPassword(t2users);

        StandardPasswordEncoder s = new StandardPasswordEncoder(AppConstBean.StandardPasswordEncoderSalt);

        boolean psChk = s.matches(str,getPassword);

        if(psChk){//입력한 비밀번호가 현재 비밀번호와 동일 할 때 비밀번호 변경 실행
            resMap.put("resCd", resCd);
            int rslt = t2UserService.updateUsersPassword(t2users);
            resMap.put("rslt", rslt);
            return makeJsonResponseHeader(resMap);
        }else{
            resMap.put("resCd", "99");
            return makeJsonResponseHeader(resMap);
        }
    }

    /*
     * 내용   : 종사자번호 변경
     * 개발자 : 김예지
     */
    @RequestMapping(value = {"/changeDealerNo"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> changeDealerNo(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load changeDealerNo");

        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";
        //입력한 현재 종사자번호와 기존 종사자번호와 동일한지 확인
        String str = t2Users.getDealerNoCurrent();
        //기존종사자번호 가져오기
        String getDealerNo = t2UserService.getDealerNo(t2Users);

        if(str.equals(getDealerNo)){//기존 종사자번호와 입력한 종사자번호가 같을 떄
            //딜러가 입력한 정보에 해당하는 종사자번호가 유효한지 체크
            String rsltDealer = carMarketInfoService.getDealerChk(t2Users);
            //딜러가 입력한 정보가 이미 회원가입이 되어있는지 체크(이름과 종사자번호로)
            int chkDealer  = t2UserService.selectDuplicateByDealerNo(t2Users);

            if("N".equals(rsltDealer)){
                resMap.put("rsltDealer", rsltDealer);
            }else{
                //기존 등록 된 사용자일경우(이름과 종사자번호로 체크)
                if(chkDealer != 0){
                    resMap.put("chkDealer", chkDealer);
                }else{
                    //종사자번호 변경
                    t2UserService.updateDealerNo(t2Users);
                    resMap.put("resCd", "00");
                }
            }
        }else{
            resMap.put("resCd", "99");
        }
        return makeJsonResponseHeader(resMap);
    }

    /*
     * 내용   : 비밀번호 재설정(로그인 화면의 비밀번호 찾기)
     * 개발자 : 김예지
     * parameter : userId
     */
    @RequestMapping(value = {"/changePassword"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> changePassword(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletRequest res, Model model){
        mlog_usual.debug(" :: Load changePassword");

        /*
         * 비밀번호를 변경 하기 위하여 userId 가 필요한데,
         * 현재 휴대폰 인증의 모듈이 붙어 있지 않은 관계로 임의의 userId 를 넘긴다.
         * 파라미터로 받아온 userId 를 사용하여 비밀번호를 변경 한 후 변경 성공시 로그인 화면으로 넘긴다.
         */

        //test 용 임의 데이터
        //t2Users.setUserId("244");

        HashMap<String, Object> resMap = new HashMap<>();
        String resCd = "00";
        try {
            int rslt = t2UserService.updateUsersPassword(t2Users);
            resMap.put("resCd", resCd);
            resMap.put("rslt", rslt);
        } catch (Exception e) {
            resMap.put("resCd", 99);
        }

        return makeJsonResponseHeader(resMap);
    }

    /*
     * 내용   : 비밀번호 재설정 전 정보조회
     * 개발자 : 최정주
     * parameter : userId
     */
    @RequestMapping(value = {"/searchUserInfo"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> searchUserInfo(@RequestBody T2Users t2Users , HttpServletRequest req, HttpServletRequest res, Model model){
        mlog_usual.debug(" :: Load searchUserInfo");

        HashMap<String, Object> resMap = new HashMap<>();

        String resCd = "00";
        try {
            int rslt = t2UserService.searchUserInfo(t2Users);

            resMap.put("resCd", resCd);
            resMap.put("rslt", rslt);
        } catch (Exception e) {
            resMap.put("resCd", 99);
        }

        return makeJsonResponseHeader(resMap);
    }

    @RequestMapping(value = {"/privacy"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String privacy(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load privacy");
        model.addAttribute("pageTitle","개인정보처리방침");
        return tilesPrefix+"privacy";
    }

    /*
     * 내용   : 프리미엄 딱지 개수 정보조회
     * 개발자 : 최정주
     */
    @RequestMapping(value = {"/searchPremInfo"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> searchPremInfo(String userId , HttpServletRequest req, HttpServletRequest res, Model model){
        mlog_usual.debug(" :: Load searchPremInfo");

        HashMap<String, Object> resMap = new HashMap<>();

        String resCd = "00";
        try {
        	T2Users userInfo = t2UserService.getUserBasicInfoById(userId);

            resMap.put("userInfo", userInfo);
            resMap.put("resCd", resCd);
        } catch (Exception e) {
            resMap.put("resCd", 99);
        }

        return makeJsonResponseHeader(resMap);
    }

}
