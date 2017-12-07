package com.bnk.plus.web.product;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.CoCodeManager;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.commons.util.StringUtil;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.CarMarketInfoShop;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.car.service.CarMarketInfoService;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.session.service.T2UserService;

/**
 * Controller
 * 컨트롤러 템플릿
 *
 * @author jj-choi
 */
@Controller
@RequestMapping(value = {"/product/co"})
public class ComController extends CoTopComponent{
	private final String tilesPrefix = "tiles.product.common.";

    private String cpId 				= "CFLM1001";				// 회원사 ID
    private String extendVar     		= "0000000000000000";       // 확장변수
    private String certMet				= "M";						// 인증방식(모바일인증)
    private String nation				= "0";						// 내국인, 외국인(내국인)
    private String plusInfo				= "";						// 추가정보

    @Autowired
    T2UserService t2UserService;
    @Autowired
    CarMarketInfoService carMarketInfoService;
    @Autowired
    UserApiService userApiService;

    /*
     * 내용   : 회원가입 초기 화면(일반인지, 딜러인지)
     */
    @RequestMapping(value = {"/joinKind"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memberAgree(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load join_kind");
        return tilesPrefix+"join_kind";
    }

    /*
    * 내용   : 회원가입 초기 화면(동의체크 - 일반)
    */
    @RequestMapping(value={"/memberAgree"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memAgree(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_agree");
        return tilesPrefix+"member_agree";
    }

    /*
     * 내용   : 회원가입 초기 화면(동의체크 - 딜러)
     */
    @RequestMapping(value={"/memberAgreeDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memberAgreeDealer(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_agree_dealer");
        return tilesPrefix+"member_agree_dealer";
    }


    /*
     * 내용   : 본인인증에 필요한 DATA 생성
     */
    @RequestMapping(value={"/kcmSendData/ajax"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> kcmSendDataAjax(HttpServletRequest req, HttpServletResponse res, Model model){
    	mlog_usual.debug(" :: Load kcmSendDataAjax");
    	Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";
		try {
			String urlCode = "";
			String name = StringUtil.nvl(req.getParameter("name"));
			String gender = StringUtil.nvl(req.getParameter("gender"));
			String phoneNo = StringUtil.nvl(req.getParameter("phoneNo"));
			String phoneCorp     = StringUtil.nvl(req.getParameter("phoneCorp"));   // 이동통신사
			String birthDay = StringUtil.nvl(req.getParameter("year"))
					+ StringUtil.nvl(req.getParameter("month"))
					+ StringUtil.nvl(req.getParameter("day"));
			String urlType = StringUtil.nvl(req.getParameter("urlType"));

			// 01 : 회원가입, 02 : 회원가입(딜러), 03 : 프로필수정, 04 : 프로필수정(딜러), 05 : 비번찾기
			if("01".equals(urlType)) {
				urlCode = CoConstDef.PC_KMC_URL_CD_MEMBER_AGREE;
			} else if("02".equals(urlType)) {
				urlCode = CoConstDef.PC_KMC_URL_CD_MEMBER_AGREE_DEALER;
			} else if("03".equals(urlType)) {
				urlCode = CoConstDef.PC_KMC_URL_CD_MEMBER_MODIFY;
			} else if("04".equals(urlType)) {
				urlCode = CoConstDef.PC_KMC_URL_CD_MEMBER_MODIFY_DEALER;
			} else if("05".equals(urlType)) {
				urlCode = CoConstDef.PC_KMC_URL_CD_PASSWORD_RESET_BEFORE;
			}

			//날짜 생성
	        Calendar today = Calendar.getInstance();
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	        String day = sdf.format(today.getTime());
	        java.util.Random ran = new Random();

	        //랜덤 문자 길이
	        int numLength = 6;
	        String randomStr = "";
	        for (int i = 0; i < numLength; i++) {
	            //0 ~ 9 랜덤 숫자 생성
	            randomStr += ran.nextInt(10);
	        }

			//reqNum은 최대 40byte 까지 사용 가능
	        String certNum = day + randomStr;

	        //01. 한국모바일인증(주) 암호화 모듈 선언
	        com.icert.comm.secu.IcertSecuManager seed  = new com.icert.comm.secu.IcertSecuManager();

	    	String trCert		= cpId +"/"+ urlCode +"/"+ certNum +"/"+ day +"/"+ certMet +"/"+
	    					birthDay +"/"+ gender +"/"+ name +"/"+ phoneNo +"/"+ phoneCorp +"/"+ nation +"/"+ plusInfo +"/"+ extendVar;

	    	mlog_usual.debug(" :: data [{}]", trCert);
	     	String encTrCert    = seed.getEnc(trCert, "");
	     	String hmacMsg 		= seed.getMsg(encTrCert);
	     	trCert  = seed.getEnc(encTrCert + "/" + hmacMsg + "/" + extendVar, "");
	    	resMap.put("trCert", trCert);
	    	resMap.put("trUrl", CoConstDef.PC_KMC_URL_RESULT_PAGE);
		} catch (Exception e) {
			resCd = "99";
			e.printStackTrace();
		}

		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
    }

    /*
     * 내용   : 일반 회원 회원가입 결과 화면
     */
    @RequestMapping(value={"/memberJoinPopup"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String memberJoinPopip(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load memberJoinPopup");
    	return tilesPrefix+"member_join-popup";
    }

    /*
     * 내용   : 일반 회원 회원가입 결과 화면
     */
    @RequestMapping(value={"/kmcResult"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> kmcResult(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load kmcResult");
        Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";

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

			mlog_usual.debug(" :: name : [{}], phoneNo : [{}], urlCode : [{}] ", name, phoneNo, plusInfo);
			resMap.put("name", name);
	    	resMap.put("phoneNo", phoneNo);
	    	resMap.put("urlCode", plusInfo);
    	 }catch(Exception ex){
    		 resCd = "99";
    		 ex.getStackTrace();
    	 }
    	 resMap.put("resCd", resCd);
    	 return makeJsonResponseHeader(resMap);

    }


    /*
     * 내용   : 일반 회원 회원가입 초기 화면(회원 정보 입력 화면)
     */
    @RequestMapping(value={"/memberJoin"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public String memJoin(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_join");
		model.addAttribute("name", StringUtil.nvl(req.getParameter("name")));		// 성명
		model.addAttribute("phoneNo", StringUtil.nvl(req.getParameter("phoneNo")));	// 휴대폰번호
		return tilesPrefix+"member_join";

    }

    /*
     * 내용   : 딜러 회원 회원가입 초기 화면(회원 정보 입력 화면)
     */
    @RequestMapping(value={"/memberJoinDealer"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public String memJoinDealer(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load member_join_dealer");
    	model.addAttribute("name", StringUtil.nvl(req.getParameter("name")));
 		model.addAttribute("phoneNo", StringUtil.nvl(req.getParameter("phoneNo")));
        return tilesPrefix+"member_join_dealer";
    }

    /*
     * 내용   : 회원정보 등록
     */
    @RequestMapping(value = {"/insertUser"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public ResponseEntity<Object> insertUser(CarMarketInfoShop carMarketInfoShop, @RequestBody T2Users t2Users,
    		HttpServletRequest req, HttpServletResponse res, Model model){
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
     * 내용   : 딜러회원 소속단체 검색
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
     */
    @RequestMapping(value = {"/searchFirm"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> searchFirm(@RequestBody CarMarketInfoShop carMarketInfoShop, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load searchFirm");

        HashMap<String, Object> resMap = new HashMap<>();

        //소속상사 찾기
        resMap = carMarketInfoService.getFirmList(carMarketInfoShop);

        return makeJsonResponseHeader(resMap);
    }

    @RequestMapping(value={"/pwResetBefore"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public String pwResetBefore(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load pwResetBefore");
        String urlCode = CoConstDef.PC_KMC_URL_CD_PASSWORD_RESET_BEFORE;

        //날짜 생성
        Calendar today = Calendar.getInstance();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String nowDate = sdf.format(today.getTime());

        java.util.Random ran = new Random();
        //랜덤 문자 길이
        int numLength = 6;
        String randomStr = "";

        for (int i = 0; i < numLength; i++) {
            //0 ~ 9 랜덤 숫자 생성
            randomStr += ran.nextInt(10);
        }

		//reqNum은 최대 40byte 까지 사용 가능
        String certNum = nowDate + randomStr;

        //01. 한국모바일인증(주) 암호화 모듈 선언
        com.icert.comm.secu.IcertSecuManager seed  = new com.icert.comm.secu.IcertSecuManager();

     	//02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
     	String enc_tr_cert = "";
     	String trCert     = cpId +"/"+ urlCode +"/"+ certNum +"/"+ nowDate +"/" +"M" + "/"+ "/"+ "/"+ "/"+ "/"+ "/"+ "/";
     	enc_tr_cert        = seed.getEnc(trCert, "");

     	//03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
     	String hmacMsg = "";
     	hmacMsg = seed.getMsg(enc_tr_cert);

     	//04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
     	trCert  = seed.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + extendVar, "");

     	model.addAttribute("trCert",trCert);
     	model.addAttribute("trUrl",CoConstDef.PC_KMC_URL_RESULT_PAGE);

        return tilesPrefix+"pw_reset_before";
    }

    /*
     * 내용   : 비밀번호 변경
     */
    @RequestMapping(value={"/pwReset"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
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
     * 내용   : 비밀번호 재설정(로그인 화면의 비밀번호 찾기)
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

    // 공통 제조사 코드
    @RequestMapping(value = {"/makerCombo"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> makerCombo(HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load makerCombo");
        Map<String, String> resMap = CoCodeManager.CAR_CODE_SEARCH_INFO.get("makerList");

        return makeJsonResponseHeader(resMap);
    }

    // 공통 모델 코드
    @RequestMapping(value = {"/modelCombo"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> modelCombo(String makerCd, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load modelCombo");
        Map<String, String> resMap = CoCodeManager.CAR_CODE_SEARCH_INFO.get(makerCd);
        return makeJsonResponseHeader(resMap);
    }

  //로그인 체크
    @RequestMapping(value = {"/loginCheck"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
    public ResponseEntity<Object> loginCheck(HttpServletRequest req, HttpServletResponse res) {
    	mlog_usual.debug(" :: Load Login Check.");
    	HashMap<String, Object> resMap = new HashMap<String, Object>();
    	HashMap<String, Object> dataMap = new HashMap<String, Object>();
    	String resCd = "00";
    	String loginYn = "";
    	try{
    		loginYn = isLogin() ? "Y" : "N";
    		dataMap.put("loginYn", loginYn);
    		dataMap.put("sessUserInfo", loginUserInfo());
    		dataMap.put("newDataInfo", userApiService.getUserHasNotiData(loginUserName()));
    	}catch(Exception e){
    		resCd = "99";
    	}
    	resMap.put("code", resCd);
    	resMap.put("data", dataMap);
    	return makeJsonResponseHeader(resMap);
    }

    //찜하기
    @RequestMapping(value={"/dibsOn/{carSeq}"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> dibsOnCar(@PathVariable String carSeq, Car car, HttpServletRequest req, HttpServletResponse res){
    	mlog_usual.debug(" :: Load mstList Page.");
    	HashMap<String, Object> resMap = new HashMap<String, Object>();
    	String resCd = "00";
    	try{
    		userApiService.dibsOn(car);
    	}catch(Exception e){
    		resCd = "99";
    	}
    	resMap.put("resCd", resCd);
    	return makeJsonResponseHeader(resMap);
    }
    //관심딜러등록/삭제
    @RequestMapping(value={"/interestDealer/{userId}"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> dibsOnDealer(@PathVariable String userId, Car car, HttpServletRequest req, HttpServletResponse res){
    	mlog_usual.debug(" :: Load mstList Page.");
    	HashMap<String, Object> resMap = new HashMap<String, Object>();
    	String resCd = "00";
    	try{
    		userApiService.toggleInterestDealer(car);
    	}catch(Exception e){
    		e.printStackTrace();
    		resCd = "99";
    	}
    	resMap.put("resCd", resCd);
    	return makeJsonResponseHeader(resMap);
    }
    //Page View Count
    @RequestMapping(value={"/viewCnt/{carSeq}"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> incViewCnt(@PathVariable String carSeq, Car car, HttpServletRequest req, HttpServletResponse res){
    	mlog_usual.debug(" :: Load mstList Page.");
    	HashMap<String, Object> resMap = new HashMap<String, Object>();
    	String resCd = "00";
    	try{
    		userApiService.incViewCnt(car);
    	}catch(Exception e){
    		e.printStackTrace();
    		resCd = "99";
    	}
    	resMap.put("resCd", resCd);
    	return makeJsonResponseHeader(resMap);
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

    @RequestMapping(value={"/getComponent/AJAX"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
	public String getComponent(String json, HttpServletRequest req, HttpServletResponse res, Model model){
    	model.addAllAttributes(fromJsonToMap(json));
		return tilesPrefix+"component";
	}
}
