package com.bnk.plus.config.interceptors;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.servletapi.SecurityContextHolderAwareRequestWrapper;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.config.AppConstBean;
import com.bnk.plus.entity.Employee;
import com.bnk.plus.entity.T2Users;

/**
 * <pre>
 * DetectAdminUserInterceptor.java
 * 설명 : 로그인 유저의 권한에 따라 페이지 컨트롤이 필요하여 Interceptor 추가
 * 상세 :
 * 		관리자(ROLE_ADMIN)는 모든 학교의 정보를 컨트롤 할 수 있고,
 * 		사용자(ROLE_USER)는 자신이 속한 학교의 정보만 컨트롤 할 수 있다.
 * 		체크 방법 - ROLE_ADMIN이 아닐 경우 요청한 학교(userId)가 로그인한 사용자의 학교(userId)와 같은지 확인 후
 * 					같다면 PASS, 다르다면 Access Denied 페이지로 Redirect 시켜야 한다.
 * </pre>
 *
 * @author ks-choi
 * @date 2015. 8. 18.
 * 
 */
public class DetectAdminUserInterceptor extends HandlerInterceptorAdapter {
	
	private static final Logger log_usual = LoggerFactory.getLogger("ADMIN-USUAL");
	private static final Logger log_update = LoggerFactory.getLogger("ADMIN-UPDATE");
	private static final Logger log_error = LoggerFactory.getLogger("ADMIN-ERROR");
	
	static final String EXCEPT_URL[] = {"error", "main"};
	static final String EXCEPT_USER[] = {"univ"};
	static final String EXCEPT_ROLE = "";
//	public static final String ACCESS_DENIED_URL = AppConstBean.SECURITY_ACCESS_DENIED_PAGE;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		/**
		 * 1. Get Login User ID : auth.getName()
		 * 			ex 1) if Login ? "${LoginUserId}"
		 * 			ex 2) if !Login ? "anonymousUser"
		 * 
		 * 2. Get Login User Role : auth.getAuthorities().toString();
		 * 			ex 1) if Login ? "${LoginUserRole}"
		 * 			ex 2) if !Login ? "ROLE_ANONYMOUS"
		 */
		
		/**
		 * 접속자 IP 가져오기
		 */
		String ip = request.getHeader("X-FORWARDED-FOR"); 
		if (ip == null || ip.length() == 0) { ip = request.getHeader("Proxy-Client-IP"); }
		if (ip == null || ip.length() == 0) { ip = request.getHeader("WL-Proxy-Client-IP"); }		// 웹로직
		if (ip == null || ip.length() == 0) { ip = request.getRemoteAddr() ; }
		log_usual.info("Session User : " + auth.getName() + "IP : " + ip + ", Request URL : " + CoTopComponent.getRequestURLAndQueryString(request));
		
		// Session 정보 가져오기
		HashMap<String, Object> sessDetailInfo = null;
		T2Users sessUserInfo = null;
		String sessId = null;
		String sessRole = null;
		String requestURI = null;
		
		System.out.println("=======================pc 인터셉터");
		
		String authKey = (String) request.getSession().getAttribute("authKey");
		Employee empl = (Employee) request.getSession().getAttribute("sessUserInfo");
		
		if(auth != null){
			/*sessId = auth.getName();
			sessRole = auth.getAuthorities().toString();
			requestURI = request.getRequestURI().substring(request.getContextPath().length());
			
			try{
				sessDetailInfo = (HashMap<String, Object>) auth.getDetails();
			}catch(Exception e){
				log_usual.info("sessDetailInfo auth Error..");
				response.sendRedirect(request.getContextPath()+AppConstBean.SECURITY_LOGIN_PAGE);
				return false;
			}
			
			if(sessDetailInfo != null){
				sessUserInfo = (T2Users)sessDetailInfo.get("sessUserInfo");
			}else{
				log_usual.info("sessDetailInfo get Error..");
				response.sendRedirect(request.getContextPath()+AppConstBean.SECURITY_LOGIN_PAGE);
				return false;
			}*/
		}
		
		if(auth == null || "anonymousUser".equalsIgnoreCase(auth.getName())){
			// 2017-08-22 로그인되지 않은 사용자가 마이페이지로 이동할경우 로그인페이지로 리다이렉트
			String curUri = request.getRequestURI();
			if(curUri.contains("/product/mypage/") || curUri.contains("/product/market/index")){
				CoTopComponent.putSessionObject("moveUrl", curUri);
				response.sendRedirect(request.getContextPath()+AppConstBean.SECURITY_LOGIN_PAGE);
			}
		}
		
		/** Dead Code */
//		else{
//			log_usual.info("sessDetailInfo auth null Error..");
//			response.sendRedirect(request.getContextPath()+AppConstBean.SECURITY_LOGIN_PAGE);
//			return false;
//		}
		
		SecurityContextHolderAwareRequestWrapper securityWrapper = new SecurityContextHolderAwareRequestWrapper(request, AppConstBean.SECURITY_ROLE_PREFIX);    	
		String role = EXCEPT_ROLE;
		if (EXCEPT_ROLE.indexOf(AppConstBean.SECURITY_ROLE_PREFIX) == 0) role = EXCEPT_ROLE.replaceFirst(AppConstBean.SECURITY_ROLE_PREFIX, "");
		
		return super.preHandle(request, response, handler);
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		super.postHandle(request, response, handler, modelAndView);
	}
}
