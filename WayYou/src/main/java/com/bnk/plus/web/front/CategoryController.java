package com.bnk.plus.web.front;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.commons.util.StringUtil;
import com.bnk.plus.entity.Car;
import com.bnk.plus.service.car.service.CarMstService;
import com.bnk.plus.service.my.service.MyService;

/**
 * CategoryController
 * 카테고리 컨트롤러
 *
 * @author jy-seo
 */
@Controller
@RequestMapping(value = {"/front/category"})
public class CategoryController extends CoTopComponent{
	private final String tilesPrefix = "tiles.front.category.";

	@Autowired CarMstService carMstService;
	@Autowired MyService myService;
	//서비스 - 현장서비스
	@RequestMapping(value={"/service/serviceList"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String serviceList(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Category Service List Page.");
		return tilesPrefix+"service.service_list";
	}

	//서비스 - BNK서비스
	@RequestMapping(value={"/service/special"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String special(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Category Service Special Page.");
		return tilesPrefix+"service.special";
	}

	//인증 - 인증중고차
	@RequestMapping(value={"/certify/certifyList"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String certifyListcertifyList(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Category Certify List Page.");
		return tilesPrefix+"certify.certify_list";
	}

	//내차 - 내차사기 리스트
	@RequestMapping(value={"/mycar/buyList"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String buyList(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Category Mycar Buy List Page.");
		return tilesPrefix+"mycar.buy_list";
	}

	//내차 - 내차사기 상세
	@RequestMapping(value={"/mycar/buyDetail/{carSeq}"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String buyDetail(@PathVariable String carSeq, Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Category Mycar Buy Detail Page.");
		Car reverAuctionInfo = null;
		//매물SEQ가 숫자가 아닌경우
		if(StringUtil.isNotNumeric(carSeq)){
			return tilesPrefix+"mycar.buy_detail";
		}

		try {
			car = carMstService.getCarCommonInfo(car);

			reverAuctionInfo = myService.getReverseAuctionInfo(car);		// 내게맞는매물 정보 가져오기

		} catch (Exception e) {
			e.printStackTrace();
		}

		if(car != null){
			model.addAttribute("car", toJson(car));
			model.addAttribute("pageTitle", car.getLabel().getModelDtlName());
			model.addAttribute("reverAuctionInfo", toJson(reverAuctionInfo));	// 내게맞는매물 정보 가져오기
		}else{
			model.addAttribute("car", toJson(car));
		}

		return tilesPrefix+"mycar.buy_detail";
	}

	//내차 - 내차팔기
	@RequestMapping(value={"/mycar/sells"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String sells(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Category Mycar Sells Page.");
		return tilesPrefix+"mycar.sells";
	}

	//내차 - 내차팔기 결과
	@RequestMapping(value={"/mycar/sellsResult"}, produces = "text/html; charset=utf-8")
	public String sellsResult(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Category Mycar Sells Result Page.");
		return tilesPrefix+"mycar.sells_result";
	}

	//딜러 상세
	@RequestMapping(value={"/mycar/dealerDetail"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String dealer_detail(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load dealer_detail Page.");
		return tilesPrefix+"mycar.dealer_detail";
	}

}
