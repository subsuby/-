package com.bnk.plus.commons.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.CoCodeManager;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.config.AppConstBean;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.car.service.UserApiService;

/**
 *
 * <pre>
 * AdviceController.java
 * </pre>
 *
 * 전체페이지에 적용되는 ControllerAdvice
 *
 * @author Administrator
 * @date 2015. 8. 27.
 */
@ControllerAdvice
public class AdviceController extends CoTopComponent{

	@Autowired UserApiService userApiService;
	
	/**
		jsp reqest 자동 리턴
	 */
	@ModelAttribute("req")
	public HttpServletRequest getRequest(HttpServletRequest req){
		return req;
	}

	/**
			"현재 로그인 되어 있는 세션 ID" 를 일괄적으로 model에 담아 리턴
	 */
	@ModelAttribute("sessUserId")
	public String getSessUserId(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		if(auth != null){
			return auth.getName();
		}
		return "";
	}

	/**
	현재 로그인 되어 있는 유저 상세정보" 를 리턴
	*/
	@ModelAttribute("sessUserInfo")
	public T2Users getSessUserInfo(){
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();

		HashMap<String, Object> sessDetailInfo = null;
		T2Users sessUserInfo = null;

		if(auth != null){
			try{
				sessDetailInfo = (HashMap<String, Object>) auth.getDetails();
			}catch(Exception e){
				//log_error.error("Detail Error : " + e.getMessage());
			}

			if(sessDetailInfo != null){
				sessUserInfo = (T2Users)sessDetailInfo.get("sessUserInfo");
			}else{
				//log_error.error("sessDetailInfo is null");
			}
		}
		return sessUserInfo;
	}

	/**
	 * 현재 접속 기기가 모바일인지 여부를 리턴
	 */
	@ModelAttribute("isMobile")
	public boolean checkMobile(HttpServletRequest req) {
		return req.getHeader("User-Agent").indexOf("Mobile") != -1;
	}
	/**
	 *
	 * <pre>
	 * 1. 설명 : AppConstBean.java에 등록된 페이지 명 기본값
	 * 2. 동작 :
	 *    Tiles 레이아웃 구조의 "pageTitle" attribute에 입력되는 값으로 사용된다.
	 *    각 페이지별로 수정을 원할 경우 @Controller 각 메소드에 Model에 addAttribute("pageTitle", String)로 덮어쓰기가 가능하다.
	 * 3. Input :
	 * 4. Output :
	 * 5. 수정내역
	 * ----------------------------------------------------------------
	 * 변경일            작성자                   변경내용
	 * ----------------------------------------------------------------
	 * 2016. 4. 5.     ks-choi    최초작성
	 * ----------------------------------------------------------------
	 * </pre>
	 *
	 * @return
	 */
	@ModelAttribute("pageTitle")
	public String pageTitle(HttpServletRequest req){
		String pageTitle = "";
		Vector<String[]> v = CoCodeManager.getAllValues(CoConstDef.CD_URI_CODE_TYPE);
		for(String[] s : v){
			if(req.getRequestURI().indexOf(s[4]) >= 0){
				pageTitle = s[2];
				break;
			}
		}
		return pageTitle;
	}
	@ModelAttribute("pageTitlePrefix") public String pageTitlePrefix(){return AppConstBean.APP_NAME;}
	@ModelAttribute("context") public String context(HttpServletRequest request){return request.getRequestURL().toString();}
	@ModelAttribute("newDataInfo") public Map<String, String> newDataInfo(HttpServletRequest request){return userApiService.getUserHasPcNotiData(loginUserName());}
	
}
