package com.way.you.controllers;
 
import java.util.HashMap;
import java.util.Locale;

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
import com.way.you.bean.Appt;
import com.way.you.bean.User;
import com.way.you.services.ApptService;
import com.way.you.services.LoginService;
 
/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/front")
public class MainController extends CoTopComponent{
	
	@Autowired ApptService apptService;
	@Autowired LoginService loginService;
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String login(Model model, HttpServletRequest req, HttpServletResponse res) {
		
		System.out.println(messageSource.getMessage("appt.test", null, Locale.KOREA));
		System.out.println(Locale.JAPAN);
	return "/front/main";
	}
	
	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public String download(Model model) {
	return "/front/download";
	}
	
	//메인 정보 가져오기
	@RequestMapping(value="/main/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> mainInfo(HttpServletRequest req,HttpServletResponse res, @ModelAttribute Appt param) throws Exception{
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		Appt appt = new Appt();
		//변수 설정
		param.setApptHostId(req.getSession().getAttribute("userId").toString());
		try {
			//service호출
			appt = apptService.getMainInfo(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("appt", appt);
		return makeJsonResponseHeader(resultMap);
	}
	
	//메인 정보 가져오기
	@RequestMapping(value="/main/new/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> newApi(HttpServletRequest req,HttpServletResponse res, @ModelAttribute User param) throws Exception{
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "false";
		if(req.getSession().getAttribute("userId").toString().isEmpty()) {
			result = "false";
		}else {
			//변수 설정
			param.setUserId(req.getSession().getAttribute("userId").toString());
			try {
				//service호출
				result = loginService.getNewInfo(param);
			}catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		resultMap.put("result", result);
		return makeJsonResponseHeader(resultMap);
	}
}