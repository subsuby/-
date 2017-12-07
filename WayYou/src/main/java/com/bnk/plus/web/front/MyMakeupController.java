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
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.Makeup;
import com.bnk.plus.entity.SndPush;
import com.bnk.plus.service.api.SndService;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.my.service.MyService;
import com.bnk.plus.web.api.UserAPIController;

@Controller
@RequestMapping(value = {"/front/my"})
public class MyMakeupController extends CoTopComponent {
	private final String tilesPrefix = "tiles.front.my.";
	
	@Autowired
	MyService myService;
	@Autowired SndService sndService;
	@Autowired UserApiService userApiService;
	
	// 메이크업 - 일반
	@RequestMapping(value={"/makeup"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String makeup(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load makeup Page.");
		userApiService.updateReadFlag("makeup");
		return tilesPrefix+"makeup.makeup";
	}
	
	// [일반]메이크업 신청 리스트 가져오기
	@RequestMapping(value={"/makeup/list"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> makeupList(Makeup makeup, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load makeup_list Page.");
		Map<String, Object> resMap  = new HashMap<>();
		String resCd = "00";
		try{
			resMap = myService.getMakeupList(makeup);
		}catch (Exception e) {
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	
	// [일반]메이크업 - 차량 조회
	@RequestMapping(value={"/makeup/search"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> searchCar(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load makeup_search.");

		Car cars = null;
		
		try {
			cars = myService.getMakeupSearch(car);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return makeJsonResponseHeader(cars);
	}
	
	// [일반]메이크업 등록
	@RequestMapping(value={"/makeup/regist"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> makeupRegist(Makeup makeup, HttpServletRequest req, HttpServletResponse res, Model model){
		log_usual.debug(" :: Load makeup_regist.");
		HashMap<String, Object> resMap  = new HashMap<>();
		String resCd = "00";

		try {
			myService.registMakeup(makeup);
		} catch (Exception e) {
			resCd = "99";
		}

		if("00".equals(resCd)) {
			try {
				SndPush sndParam = new SndPush(CoConstDef.CD_SND_PUSH_REQ_MAKEUP);
				sndParam.setParamUserId(sndParam.getLoginUserName());
				sndService.sndPush(sndParam);
			} catch (Exception e) {
				log.error(e.getMessage(), e);
			}
		}

		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	
	// 메이크업 - 딜러
	@RequestMapping(value={"/makeupDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String makeup_dealer(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load makeup_dealer Page.");
		userApiService.updateReadFlag("makeupDealer");
		return tilesPrefix+"makeup_dealer.makeup_dealer";
	}
	
	// [딜러]메이크업 리스트
	@RequestMapping(value={"/makeupDealer/list"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public ResponseEntity<Object> makeupDealerList(Makeup makeup, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load makeup_dealer_list Page.");
		Map<String, Object> resMap  = new HashMap<>();
		String resCd = "00";
		try{
			resMap = myService.getMakeupDealerList(makeup);
		}catch (Exception e) {
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
	
	// [딜러]메이크업 - 차량 조회
	@RequestMapping(value={"/makeupDealer/search"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> searchCarDealr(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load makeup_dealer_search.");

		Car cars = null;
		
		try {
			cars = myService.getMakeupDealerSearch(car);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return makeJsonResponseHeader(cars);
	}
	
	// [딜러]메이크업 - 신청
	@RequestMapping(value={"/makeupDealer/regist"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> makeupDealerRegist(Makeup makeup, HttpServletRequest req, HttpServletResponse res, Model model){
		log_usual.debug(" :: Load makeup_dealer_regist.");
		HashMap<String, Object> resMap  = new HashMap<>();
		String resCd = "00";

		try {
			myService.registMakeupDealer(makeup);
		} catch (Exception e) {
			resCd = "99";
		}
		
		if("00".equals(resCd)) {
			try {
				SndPush sndParam = new SndPush(CoConstDef.CD_SND_PUSH_REQ_MAKEUP);
				sndParam.setParamUserId(sndParam.getLoginUserName());
				sndService.sndPush(sndParam);
			} catch (Exception e) {
				log.error(e.getMessage(), e);
			}
		}

		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
}
