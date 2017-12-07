package com.bnk.plus.web.front;

import java.util.List;
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

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Reserve;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.my.service.MyService;

@Controller
@RequestMapping(value = {"/front/my"})
public class MyReserController extends CoTopComponent {
	private final String tilesPrefix = "tiles.front.my.";
	@Autowired MyService myService;
	@Autowired UserApiService userApiService;

	//방문 시승 탁송 예약 - 일반
	@RequestMapping(value={"/reserList"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String reser_list(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load reser_list Page.");
		userApiService.updateReadFlag("reserList");
		return tilesPrefix+"reser_list.reser_list";
	}

	//방문 시승 탁송 예약 - 일반
	@RequestMapping(value={"/reserList/ajax"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	@ResponseBody public ResponseEntity<Object> reserListAjax(@RequestBody Map<String, Object> params, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load reser_list Page.");
		List<Reserve> resList=null;
		try {
			resList = myService.getReserveList(params);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return makeJsonResponseHeader(resList);
	}

	//방문 시승 탁송 사전예약관리 - 딜러
	@RequestMapping(value={"/reserListDealer"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String reser_list_dealer(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load reser_list_dealer Page.");
		userApiService.updateReadFlag("reserListDealer");
		return tilesPrefix+"reser_list_dealer.reser_list_dealer";
	}

	//방문 시승 탁송 예약 - 딜러
		@RequestMapping(value={"/reserListDealer/ajax"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
		@ResponseBody public ResponseEntity<Object> reserListDealerAjax(@RequestBody Map<String, Object> params, HttpServletRequest req, HttpServletResponse res, Model model){
			mlog_usual.debug(" :: Load reser_list Page.");
			List<Reserve> resList=null;
			try {
				resList = myService.getReserveListDealer(params);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return makeJsonResponseHeader(resList);
		}
}
