package com.bnk.plus.web.front;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.commons.components.bean.ComBean;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.my.service.MyService;

@Controller
@RequestMapping(value = {"/front/my"})
public class MyBusinesscardMgmtController extends CoTopComponent {
	private final String tilesPrefix = "tiles.front.my.";

	@Autowired
	MyService myService;
	@Autowired UserApiService userApiService;

	//일반 - 명함관리
	@RequestMapping(value={"/businesscardManagement"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String businesscard_management(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load businesscard_management Page.");
		
		userApiService.updateReadFlag("businesscardManagement");
		
		model.addAttribute("pageTitle", "명함 관리");
		return tilesPrefix+"businesscard_management.businesscard_management";
	}

	//일반 - 명함관리 리스트
	@RequestMapping(value={"/businesscardManagement/list"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> businesscardMgmtList(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load businesscardMgmtList Page.");
		Map<String, Object> resMap  = new HashMap<>();
		String resCd = "00";
		try{

			resMap = myService.setBusinessCardMgmtList(t2Users);

		}catch (Exception e) {
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	//일반 - 명함관리 리스트
	@RequestMapping(value={"/businesscardManagement/delete"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> businesscardMgmtDelete(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load businesscardMgmtDelete Page.");
		Map<String, Object> resMap  = new HashMap<>();
		String resCd = "00";
		try{
			myService.deleteBusinessCard(t2Users);
		}catch (Exception e) {
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

}
