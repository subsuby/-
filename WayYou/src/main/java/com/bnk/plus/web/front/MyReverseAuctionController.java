package com.bnk.plus.web.front;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.my.service.MyService;

@Controller
@RequestMapping(value = {"/front/my"})
public class MyReverseAuctionController extends CoTopComponent {
	private final String tilesPrefix = "tiles.front.my.";

	@Autowired
	MyService  myService;
	@Autowired UserApiService userApiService;

	//내게맞는매물 - 가져오기
	@RequestMapping(value={"/reverseAuction"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String reverse_auction(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load reverse_auction Page.");

		userApiService.updateReadFlag("reverseAuction");
		
		Car reverAuctionInfo = null;

		try {
			reverAuctionInfo = myService.getReverseAuctionInfo(car);

		} catch (Exception e) {

		}
		model.addAttribute("reverAuctionInfo", toJson(reverAuctionInfo));

		return tilesPrefix+"reverse_auction.reverse_auction";
	}
	//내게맞는매물 - 가져오기
	@RequestMapping(value={"/reverseAuction/getInfo"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> getReverseAuction(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load reverse_auction Page.");

		HashMap<String, Object> resMap = new HashMap<>();
		String resCd = "00";

		try {
			Car reverAuctionInfo = myService.getReverseAuctionInfo(car);
			resMap.put("reverAuctionInfo", reverAuctionInfo);
		} catch (Exception e) {
			resCd="99";
		}
		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}

	//내게맞는매물(딜러)
	@RequestMapping(value={"/reverseAuctionDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String reverse_auction_dealer(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load reverse_auction_dealer Page.");
		return tilesPrefix+"reverse_auction_dealer.reverse_auction_dealer";
	}

	//내게맞는매물 - 등록
	@RequestMapping(value={"/reverseAuction/regist"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> reverseAuctionRegist(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mycar Page.");

		try{
			myService.registReverseAuction(car);
		}catch(Exception e){
			e.printStackTrace();
		}
		return makeJsonResponseHeader(car);
	}

	//내게맞는매물 - 삭제
	@RequestMapping(value={"/reverseAuction/delInfo"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> DeleteReverseAuctionInfo(@ModelAttribute Car car, HttpServletRequest req, HttpServletResponse res){
		log_usual.debug(" :: Start DeleteReverseAuctionInfo");
		Map<String, Object> resMap  = new HashMap<>();

		String resCd = "00";

		try{
			myService.deleteReverseAuctionInfo(car);
		}catch (Exception e) {
			resCd = "99";
		}
		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}

	//내게맞는매물 - 수정
	@RequestMapping(value={"/reverseAuction/modify"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> modifyReverseAuctionInfo(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res){
		log_usual.debug(" :: Start modifyReverseAuctionInfo");
		Map<String, Object> resMap  = new HashMap<>();

		String resCd = "00";

		try{
			myService.modifyReverseAuctionInfo(car);
		}catch (Exception e) {
			resCd = "99";
		}

		resMap.put("resCd", resCd);
		return makeJsonResponseHeader(resMap);
	}
}
