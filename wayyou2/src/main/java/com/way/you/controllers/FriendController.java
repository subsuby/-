package com.way.you.controllers;
 
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.way.you.Util.CoTopComponent;
import com.way.you.bean.Friend;
import com.way.you.bean.User;
import com.way.you.config.listener.SessionListener;
import com.way.you.services.FriendService;
 
/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/front/friend")
public class FriendController extends CoTopComponent{
	private static final Logger logger = LoggerFactory.getLogger(SessionListener.class);
	@Autowired FriendService friendService;
	
	/* 약속 - 전체목록*/
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String friendList(HttpServletRequest req,HttpServletResponse res, Model model) {

		return "/front/friend/list";
	}
	
	//친구 목록 불러오기
	@RequestMapping(value="/list/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> friendListaApi(HttpServletRequest req,HttpServletResponse res, @ModelAttribute User user)
			throws Exception{
		System.out.println(user.getSearchKey());
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		//변수 설정
		user.setUserId(req.getSession().getAttribute("userId").toString());
		try {
			//service호출
			user = friendService.getFriendList(user);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("user", user);
		return makeJsonResponseHeader(resultMap);

	}
	
	//친구 찾기
	@RequestMapping(value="/find/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> findFriendApi(HttpServletRequest req,HttpServletResponse res,  @ModelAttribute User user)
			throws Exception{
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			//service호출
			user = friendService.findFriendById(user);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("user", user);
		return makeJsonResponseHeader(resultMap);

	}
	
	//친구 추가
	@RequestMapping(value="/add/api", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<Object> addFriendApi(HttpServletRequest req,HttpServletResponse res,  @ModelAttribute Friend friend)
			throws Exception{
		
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String result = "false";
		friend.setUserId(req.getSession().getAttribute("userId").toString());
		System.out.println(friend);
		try {
			//service호출
			result = friendService.addFriend(friend);
		}catch (Exception e) {
			e.printStackTrace();
		}
		resultMap.put("result", result);
		return makeJsonResponseHeader(resultMap);

	}
}