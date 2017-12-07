package com.bnk.plus.web.front;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.car.service.CarMstService;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.my.service.MyService;

@Controller
@RequestMapping(value = {"/front/my"})
public class MyInterestController extends CoTopComponent {
	private final String tilesPrefix = "tiles.front.my.";
	
	
	@Autowired MyService myService;
	@Autowired CarMstService carMstService;
	@Autowired UserApiService userApiService;
		
	//관심 차량
	@RequestMapping(value={"/interestCar"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String interestCar(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load interest_car Page.");
		try {
			userApiService.updateReadFlag("interestCar");
		} catch (Exception e) {
			log.error(e.getMessage(), e);
		}
		return tilesPrefix+"interest_car.interest_car";
	}
	
	//관심차량 - 딜러
	@RequestMapping(value={"/interestCarDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String interestCarDealer(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load interest_car_dealer Page.");
		
		return tilesPrefix+"interest_car_dealer.interest_car_dealer";
	}

	// 관심딜러 - 일반
	@RequestMapping(value={"/interestDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String interest_dealer(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load interest_dealer Page.");
		
		return tilesPrefix+"interest_dealer.interest_dealer";
	}
	// 관심딜러 - 리스트 가져오기
	@RequestMapping(value={"/interestDealer/ajax"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> interestDealerAjax(T2Users t2Users, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Start interestDealer");
		
		Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";

		try {
			resMap = userApiService.getInterestDealerList(t2Users);
		} catch (Exception e) {
			resCd = "99";
			e.printStackTrace();
		}
		
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
}
