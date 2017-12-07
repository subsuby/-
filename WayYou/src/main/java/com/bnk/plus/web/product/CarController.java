package com.bnk.plus.web.product;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.CoCodeManager;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.FalseCar;
import com.bnk.plus.entity.T2Users;
import com.bnk.plus.service.car.service.CarMstService;
import com.bnk.plus.service.car.service.UserApiService;
import com.bnk.plus.service.my.service.MyService;

/**
 * Controller
 * 컨트롤러 템플릿
 *
 * @author hk-lee
 */
@Controller
@RequestMapping(value = {"/product/car"})
public class CarController extends CoTopComponent{
	private final String tilesPrefix = "tiles.product.car.";

	@Autowired CarMstService carMstService;
	@Autowired UserApiService userApiService;
	@Autowired MyService myService;

	//페이지 이동
	@RequestMapping(value={"/index"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String pageMoveToIndex(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page.");
		model.addAttribute("makerList", CoCodeManager.CAR_CODE_SEARCH_INFO.get("makerList"));
		model.addAttribute("colorList", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_COLOR_TYPE));
		model.addAttribute("areaList", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_EIGHTEEN_AREA));
		model.addAttribute("marketList", CoCodeManager.getCodeString(CoConstDef.CD_MGMT_MAIN, CoConstDef.CD_MGMT_SUB_MARKET));
		return tilesPrefix+"index";
	}



	 //공통 제조사 코드
    @RequestMapping(value = {"/quick/search"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> makerCombo(String searchName, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load makerCombo");
        List<Map<String, String>> resList = new ArrayList<Map<String, String>>();
        for(Map<String, String> map : CoCodeManager.CAR_CODE_QUICK_SEARCH) {
        	if(map.get("name").contains(searchName.toUpperCase())) {
        		resList.add(map);
        	}
        }
        return makeJsonResponseHeader(resList);
    }

	//페이지 이동
	@RequestMapping(value={"/detail/{carSeq}"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String pageMoveToDetail(@PathVariable String carSeq, Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page.");
		try {
			//매물정보
			car = carMstService.getCarCommonInfo(car);

			// 사고이력정보 2017-09-15
			model.addAttribute("sago", userApiService.getSagoInfo(car));

			//BNK시세정보
			model.addAttribute("price", userApiService.getBnkPriceInfo(car));
			model.addAttribute("priceArr", toJson(userApiService.getBnkPriceInfo(car)));

			//추천차량정보(내게맞는매물참조한결과)
			Car recommendCar = new Car();
			recommendCar.setCarArea(car.getCarArea());
			recommendCar.setCarFullCode(car.getCarFullCode());
			recommendCar.setSaleAmt(car.getSaleAmt());
			recommendCar.setCarPlateNum(car.getCarPlateNum());
			recommendCar.setPageListSize(3);
			recommendCar.setSchType(CarMstService.SELECT_TYPE_RECOMMEND);
			model.addAttribute("recommend", carMstService.selectCarModel(recommendCar));
			model.addAttribute("recommendArr", toJson(carMstService.selectCarModel(recommendCar)));
			
			//내게맞는매물 정보
			Car reverseAuction = new Car();
			model.addAttribute("reverse", myService.getReverseAuctionInfo(reverseAuction));
			model.addAttribute("reverseArr", toJson(myService.getReverseAuctionInfo(reverseAuction)));

		} catch (Exception e) {

		}
		model.addAttribute("car", car);
		model.addAttribute("carArr", toJson(car));

		return tilesPrefix+"detail";
	}
	//평가 리스트 출력
	@RequestMapping(value={"/evaluateList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String evaluateListAjax(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page evaluateList AJAX.");
		Map<String, Object> resMap = new HashMap<>();
		try {
			car.setPageListSize(3);
			resMap = userApiService.getDealerEvalList(car);
			model.addAttribute("user", resMap.get("user"));
			model.addAttribute("curPage", car.getCurPage());
			model.addAttribute("totPages", resMap.get("totPage"));
		} catch (Exception e) {
			e.printStackTrace();
		}

		return tilesAjaxPrefix+"car.AJAX.evaluate_list_ajax";
	}
	//평가 등록
	@RequestMapping(value={"/evaluateRegist/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> evaluateRegistAjax(@RequestBody T2Users t2Users, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page evaluateRegist AJAX.");
		Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";
		try {
			userApiService.registDealerEval(t2Users);
		} catch (Exception e) {
			resCd = "99";
		}

		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}
	//내게맞는매물 등록
	@RequestMapping(value={"/reverseAuctionRegist/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> reverseAuctionRegist(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page evaluateRegist AJAX.");
		Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";
		try {
			myService.registReverseAuction(car);
		} catch (Exception e) {
			resCd = "99";
		}

		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}
	//허위매물신고
	@RequestMapping(value={"/declareRegist/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> declareRegistAjax(@RequestBody FalseCar car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page declareRegist AJAX.");
		HashMap<String, Object> resMap = new HashMap<String, Object>();
		String resCd = "00";
		int result = 0;
		try{
			result = userApiService.selectFakeReport(car);

			if(result == 0){
				userApiService.insFakeReport(car);
				resCd="11";
			}
		}catch(Exception e){
			System.out.println(e.getMessage());
			resCd = "99";
		}
		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}
	//BNK 시세 조회
	@RequestMapping(value={"/bnkPriceInfo/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> bnkPriceInfoAjax(Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page bnkPriceInfo AJAX.");
		Map<String, Object> resMap = new HashMap<>();
		String resCd = "00";
		try {
			resMap.putAll(userApiService.getBnkPriceInfo(car));
		} catch (Exception e) {
			resCd = "99";
		}

		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}

	//대출한도조회
	@RequestMapping(value={"/bnkcapital/{type}"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String bnkcapital(@PathVariable String type, Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		String forward = "";
		try{
			// TODO 하드코딩
			car = carMstService.getCarCommonInfo(car);
			//오토다이렉트
			if(type.equals("direct")){
				forward = CoConstDef.AUTO_DIRECT_DOMAIN;
			//오토모바일
			}else if(type.equals("mobile")){
				forward = CoConstDef.AUTO_MOBILE_DOMAIN;
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		model.addAttribute("car", car);
		model.addAttribute("forward", forward);
		return "tiles.layout.product.forward.bnkcapital";
	}

	//방문,시승,탁송 예약 승인, 거절
	@RequestMapping(value={"/reserveRegist/AJAX"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> requestCarReserve(@RequestBody Map<String, String> params, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load reserveRegist.");
		Map<String, String> resMap = new HashMap<>();
		String resCd = "00";
		try{
			int rows = userApiService.registResHis(params);
			if(rows >= 3){
				resCd ="10";
			}else if(rows == -1){
				resCd = "11";	//중복된 매물
			}
		} catch(Exception e){
			e.printStackTrace();
			resCd = "99";
		}
		// push는 서비스에서

		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}

	@RequestMapping(value={"/getComponent/AJAX"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
	public String getComponent(String json, HttpServletRequest req, HttpServletResponse res, Model model){
		System.out.println(fromJsonToMap(json));
		model.addAllAttributes(fromJsonToMap(json));
		return tilesPrefix+"component.search.component";
	}
	
	@RequestMapping(value={"/dealerSaleCarList/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String dealerSaleCarList(Car car,HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load dealerSaleCarList Page.");

		Map<String, Object> resMap = new HashMap<>();
		try {
			car.setPageListSize(5);
			car.setSchType(CarMstService.SELECT_TYPE_DEALER);
			resMap.put("data", carMstService.selectCarModel(car));
			model.addAttribute("saleList", resMap);
			model.addAttribute("totPages"   , car.getTotBlockSize());
			model.addAttribute("curPage"    , car.getCurPage());
			model.addAttribute("totSize"    , car.getTotListSize());
		} catch (Exception e) {
			e.printStackTrace();
		}
		return tilesAjaxPrefix+"car.AJAX.car_sale_dealer_ajax";
	}
	
    //내게맞는매물 등록
    @RequestMapping(value = {"/carDetailInsertReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> carDetailInsertReserve(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load carDetailInsertReserve");
        HashMap<String, Object> resMap = new HashMap<>();

        try {
            myService.registReverseAuction(car);
        } catch (Exception e) {
            // TODO Auto-generated catch block
        }

        return makeJsonResponseHeader(resMap);
    }

    //내게맞는매물 수정
    @RequestMapping(value = {"/carDetailModifyReserve"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
    public @ResponseBody ResponseEntity<Object> carDetailModifyReserve(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
        mlog_usual.debug(" :: Load carDetailModifyReserve");
        HashMap<String, Object> resMap = new HashMap<>();

        try {
            myService.modifyReverseAuctionInfo(car);
        } catch (Exception e) {
            // TODO Auto-generated catch block
        }

        return makeJsonResponseHeader(resMap);
    }
    
	//사고이력정보 조회
	@RequestMapping(value={"/sagoInfo/AJAX"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> sagoInfoAjax(@RequestBody Car car, HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page sagoInfo AJAX.");
		Map<String, Object> resMap = new HashMap<>();
		System.out.println("car -=" + car);
		String resCd = "00";
		try {
			//resMap.putAll(userApiService.getBnkPriceInfo(car));
		} catch (Exception e) {
			resCd = "99";
		}

		resMap.put("resCd", resCd);

		return makeJsonResponseHeader(resMap);
	}    
}
