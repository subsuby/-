package com.way.you.controllers;
 
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.way.you.Util.CoTopComponent;
import com.way.you.bean.User;
import com.way.you.services.LoginService;
 
/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/front")
public class MyInfoController extends CoTopComponent{
	
	@Autowired LoginService loginService;
	
	@RequestMapping(value = "/myinfo/info", method = RequestMethod.GET)
	public String myinfo(Model model) {
	return "/front/myinfo/info";
	}
	
	//마이페이지 정보가져오기
	@RequestMapping(value="/myinfo/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> myinfoApi(HttpServletRequest req,HttpServletResponse res) throws Exception{
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		User user = new User();
		//변수 설정
		user.setUserId(req.getSession().getAttribute("userId").toString());
		try {
			//service호출
			user = loginService.getMyInfo(user);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("user", user);
		return makeJsonResponseHeader(resultMap);

	}
	
	//마이페이지 정보가져오기
	@RequestMapping(value="/changeInfo/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> changeInfo(HttpServletRequest req,HttpServletResponse res, @ModelAttribute User user) throws Exception{
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//변수 설정
		user.setUserId(req.getSession().getAttribute("userId").toString());
		try {
			//service호출
			user = loginService.changeMyInfo(user);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("user", user);
		return makeJsonResponseHeader(resultMap);

	}
}