package com.way.you.controllers;
 
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.way.you.Util.CoTopComponent;
import com.way.you.bean.Appt;
import com.way.you.bean.ApptGuest;
import com.way.you.bean.Calendar;
import com.way.you.config.listener.SessionListener;
import com.way.you.services.ApptService;
 
/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/front/appt")
public class ApptController extends CoTopComponent{
	@Autowired ApptService apptService;
	private static final Logger logger = LoggerFactory.getLogger(SessionListener.class);
	
	/* 약속 - 대기중인 약속*/
	@RequestMapping(value = "/wait", method = RequestMethod.GET)
	public String wait(HttpServletRequest req,HttpServletResponse res, Model model) {
		logger.info("my-today called()");
		return "/front/appt/wait";
	}
	
	/* 약속 - 진행중인 약속*/
	@RequestMapping(value = "/progress", method = RequestMethod.GET)
	public String progress(HttpServletRequest req,HttpServletResponse res, Model model) {
		logger.info("my-today called()");
		return "/front/appt/progress";
	}
	
	/* 약속 - 약속 상세*/
	@RequestMapping(value = "/detail/{apptId}", method = RequestMethod.GET)
	public String detail(HttpServletRequest req,HttpServletResponse res, Model model, @PathVariable String apptId) {
		logger.info("my-today called()");
		
		Appt appt = new Appt();
		//변수 설정
		appt.setApptId(apptId);
		try {
			//service호출
			appt = apptService.getApptDetail(appt);
		}catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("appt", appt);
		model.addAttribute("userId",req.getSession().getAttribute("userId"));
		
		return "/front/appt/detail";
	}
	
	//전체목록 리스트 불러오기
	@RequestMapping(value="/api/list", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> progressList(HttpServletRequest req,HttpServletResponse res, @ModelAttribute Appt param) throws Exception{
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<Appt> appt = new ArrayList<Appt>();
		//변수 설정
		param.setApptHostId(req.getSession().getAttribute("userId").toString());
		System.out.println(param.getApptTime());
		try {
			//service호출
			appt = apptService.getList(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("appt", appt);
		resultMap.put("userId", req.getSession().getAttribute("userId"));
		return makeJsonResponseHeader(resultMap);
	}
	
	/* 나의약속 - 오늘의 약속*/
	@RequestMapping(value = "/calendar", method = RequestMethod.GET)
	public String calendar(Model model) {
		logger.info("my-today called()");
		return "/front/appt/calendar";
	}
	
	//달력 불러오기
	@RequestMapping(value="/calendar/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> calendarInfo(HttpServletRequest req,HttpServletResponse res, @ModelAttribute Calendar param)
			throws Exception{
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		List<Calendar> calendar = new ArrayList<Calendar>();
		System.out.println(req.getSession().getAttribute("userId").toString());
		//변수 설정
		param.setUserId(req.getSession().getAttribute("userId").toString());
		try {
			//service호출
			calendar = apptService.getCalendarInfo(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("calendar", calendar);
		return makeJsonResponseHeader(resultMap);

	}
	
	/* 나의약속 - 약속 등록*/
	@RequestMapping(value = "/regist", method = RequestMethod.GET)
	public String regist(Model model) {
		logger.info("my-today called()");
	return "/front/appt/regist";
	}
	
	//약속 등록
	@RequestMapping(value="/regist/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> registAppt(HttpServletRequest req,HttpServletResponse res, @ModelAttribute Appt param) throws Exception{
		System.out.println(param);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "";
		//변수 설정
		param.setApptHostId(req.getSession().getAttribute("userId").toString());
		try {
			//service호출
			 result = apptService.registAppt(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("result", result);
		return makeJsonResponseHeader(resultMap);
	}
	
	//약속 취소
	@RequestMapping(value="/modified/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> modifiedAppt(HttpServletRequest req,HttpServletResponse res, @ModelAttribute Appt param) throws Exception{
		System.out.println(param);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "";
		//변수 설정
		param.setApptHostId(req.getSession().getAttribute("userId").toString());
		try {
			//service호출
			 result = apptService.modifiedAppt(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("result", result);
		return makeJsonResponseHeader(resultMap);
	}
		
	//약속 취소
	@RequestMapping(value="/delete/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> deleteAppt(HttpServletRequest req,HttpServletResponse res, @ModelAttribute Appt param) throws Exception{
		System.out.println(param);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "";
		//변수 설정
		param.setApptHostId(req.getSession().getAttribute("userId").toString());
		try {
			//service호출
			 result = apptService.deleteAppt(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("result", result);
		return makeJsonResponseHeader(resultMap);
	}
	
	//약속 참석
	@RequestMapping(value="/attend/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> attendAppt(HttpServletRequest req,HttpServletResponse res, @ModelAttribute ApptGuest param) throws Exception{
		System.out.println(param);
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "";
		//변수 설정
		try {
			//service호출
			 result = apptService.attendAppt(param);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("result", result);
		return makeJsonResponseHeader(resultMap);
	}
	
	/* 나의약속 - 취소된 약속*/
	@RequestMapping(value = "/canceled", method = RequestMethod.GET)
	public String canceled(Model model) {
		logger.info("my-canceled called()");
	return "/front/appt/canceled";
	}
}