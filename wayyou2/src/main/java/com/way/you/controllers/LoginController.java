package com.way.you.controllers;
 
import java.net.InetAddress;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.way.you.Util.RandomCode;
import com.way.you.bean.User;
import com.way.you.config.listener.SessionListener;
import com.way.you.services.EmailService;
import com.way.you.services.LoginService;
 
/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/front")
public class LoginController {
	@Autowired LoginService loginService;
	@Autowired EmailService emailService;
	private static final Logger logger = LoggerFactory.getLogger(SessionListener.class);
	
	
	//로그인 메인 페이지
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(Model model, HttpServletRequest req) {
		logger.info("login called()");
	return "/front/login";
	}
	
	//로그인 API
	@RequestMapping(value="/token/api", method = RequestMethod.POST)
	@ResponseBody
	public void token(HttpServletRequest req,HttpServletResponse res) throws Exception{
		System.out.println("token : "+req.getParameter("Token"));
		req.getSession().setAttribute("Token", req.getParameter("Token"));
	}
	
	
	//로그인 API
	@RequestMapping(value="/login/api/login", method = RequestMethod.POST)
	@ResponseBody
	public String login(HttpServletRequest req,HttpServletResponse res, User user) throws Exception{
		
		String result = "";
		
		//변수 설정
		user.setUserId(req.getParameter("userId"));
		user.setUserPwd(req.getParameter("password"));
//		user.setUserToken(req.getSession().getAttribute("Token").toString());
		try {
			//service호출
			int loginYn = loginService.login(user);
			if(loginYn == 1) {
				result = "true";
			}else {
				result = "false";
			}
		}catch (Exception e) {
			e.printStackTrace();
			result = "false";
		}
		if(result == "true") {
			req.getSession().setAttribute("userId", req.getParameter("userId"));
		}
		return result;

	}
	
	//회원인증 화면
	@RequestMapping(value = "/login/confirm/{code}", method = RequestMethod.GET)
	public String userConfirm(Model model, @PathVariable("code")String code) {
		logger.info("userConfirm called()");
		//변수 설정
		User user = new User();
		user.setUserConfirmCode(code);
		
		//인증하기
		user = loginService.userConfirm(user);
		
		model.addAttribute("user", user);
		
	return "/front/confirm";
	}
	
	//회원가입 API
	@RequestMapping(value="/login/api/sign", method = RequestMethod.POST)
	@ResponseBody
	public String signIn(HttpServletRequest req,HttpServletResponse res, User user) throws Exception{
		
		String result = "";
		
		//변수 설정
		user.setUserId(req.getParameter("userId"));
		user.setUserPwd(req.getParameter("password"));
		user.setUserName(req.getParameter("userName"));
		user.setUserBirth(req.getParameter("birth"));
		user.setUserPhone(req.getParameter("phone"));
		//사용자 인증코드 생성
		String randomCode = RandomCode.makeUserRandomCode();
		user.setUserConfirmCode(randomCode);
		
		try {
			//service호출
			int signYn = loginService.signUp(user);
			if(signYn == 1) {
				result = "true";
				//현재 아이피
				InetAddress inet= InetAddress.getLocalHost();
				//메일 보내기
				emailService.sendSimpleMessage(user.getUserId(), 
						"[BRT] 회원가입 인증 메일입니다.",
						"해당 링크를 클릭해주세요.<br/><a href='http://13.124.225.226/front/login/confirm/"+user.getUserConfirmCode()+"'>인증페이지</a>");
			}else {
				result = "false";
			}
		}catch (Exception e) {
			e.printStackTrace();
			result = "false";
		}
		
		return result;

	}
	
	
	//회원가입 API
	@RequestMapping(value="/login/api/duplicate", method = RequestMethod.POST)
	@ResponseBody
	public String duplicate(HttpServletRequest req,HttpServletResponse res, User user) throws Exception{
		
		String result = "";
		//변수 설정
		user.setUserId(req.getParameter("userId"));
		
		try {
			//service호출
			int signYn = loginService.duplicate(user);
			if(signYn == 1) {
				result = "false";
			}else {
				result = "true";
			}
		}catch (Exception e) {
			e.printStackTrace();
			result = "false";
		}
		
		return result;

	}
	//아이디 찾기 API
	@RequestMapping(value="/login/api/findId", method = RequestMethod.POST)
	@ResponseBody
	public String findId(HttpServletRequest req,HttpServletResponse res, User user) throws Exception{
		String result = "";
		//변수 설정
		user.setUserName(req.getParameter("userName"));
		user.setUserBirth(req.getParameter("userBirth"));
		user.setUserPhone(req.getParameter("userPhone"));
		System.out.println(user);
		try {
			//service호출
			user = loginService.findId(user);
			System.out.println(user);
			if(user == null) {
				result = "false";
			}else {
				result = user.getUserId();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	//비밀번호 찾기 API
	@RequestMapping(value="/login/api/findPwd", method = RequestMethod.POST)
	@ResponseBody
	public String findPwd(HttpServletRequest req,HttpServletResponse res, User user) throws Exception{
		String result = "";
		//변수 설정
		user.setUserId(req.getParameter("userId"));
		user.setUserName(req.getParameter("userName"));
		user.setUserBirth(req.getParameter("userBirth"));
		user.setUserPhone(req.getParameter("userPhone"));
		//사용자 인증코드 생성
		String randomCode = RandomCode.makeUserRandomCode();
		user.setPwdFindCode(randomCode);
		try {
			//service호출
			int success = loginService.findPwd(user);
			if(success == 0) {
				result = "false";
			}else {
				result = "true";
				//메일 보내기
				emailService.sendSimpleMessage(user.getUserId(), 
						"[BRT] 비밀번호 변경 인증 메일입니다.",
						"회원님의 비밀번호 변경 인증 코드는 "+user.getPwdFindCode()+"입니다.");
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	//비밀번호 인증코드 api
	@RequestMapping(value="/login/api/confirmPwdCode", method = RequestMethod.POST)
	@ResponseBody
	public String confirmPwdCode(HttpServletRequest req,HttpServletResponse res, User user) throws Exception{
		String result = "";
		//변수 설정
		user.setUserId(req.getParameter("userId"));
		user.setPwdFindCode(req.getParameter("pwdFindCode"));
		
		try {
			//service호출
			int success = loginService.pwdFindCode(user);
			if(success == 0) {
				result = "false";
			}else {
				result = "true";
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//비밀번호 재설정 api
	@RequestMapping(value="/login/api/pwdReset", method = RequestMethod.POST)
	@ResponseBody
	public String pwdReset(HttpServletRequest req,HttpServletResponse res, User user) throws Exception{
		String result = "";
		//변수 설정
		user.setUserId(req.getParameter("userId"));
		user.setUserPwd(req.getParameter("password"));
		
		try {
			//service호출
			int success = loginService.resetPassword(user);
			if(success == 0) {
				result = "false";
			}else {
				result = "true";
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}