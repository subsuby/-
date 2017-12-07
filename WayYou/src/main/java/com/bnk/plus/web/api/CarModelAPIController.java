package com.bnk.plus.web.api;

import java.util.HashMap;

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

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.entity.CarCost;
import com.bnk.plus.service.car.service.CarMstService;

@Controller
@RequestMapping(value = {"/api/car"})
public class CarModelAPIController extends CoTopComponent {

	@Autowired
	CarMstService carMstService;

	//매물 리스트 조회
	@RequestMapping(value={"/list/{type}"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> carList(@PathVariable String type, @RequestBody Car car, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load mstList Page.");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "00";
		try{
			//인증 중고차 리스트
			if(type.equals("certify")){
				car.setSchType(CarMstService.SELECT_TYPE_CERTIFYCATE);
				car.setPageListSize(20);
				resultMap.put("data", carMstService.selectCarModel(car));
			//딜러 매물 리스트
			}else if(type.equals("dealerSellList")){
				car.setSchType(CarMstService.SELECT_TYPE_DEALER);
				resultMap.put("data", carMstService.selectCarModel(car));
			//관심 차량 리스트
			}else if(type.equals("interestCar")){
				car.setSchType(CarMstService.SELECT_TYPE_INTEREST);
				resultMap.put("data", carMstService.selectCarModel(car));
			//추천 매물 리스트
			}else if(type.equals("recommend")){
				car.setSchType(CarMstService.SELECT_TYPE_RECOMMEND);
				resultMap.put("data", carMstService.selectCarModel(car));
			// 현장 서비스 리스트
			}else if(type.equals("serviceList")){
				car.setSchType(CarMstService.SELECT_TYPE_SERVICE);
				resultMap.put("data", carMstService.selectCarModel(car));
			//기본 매물 리스트
			}else{
				car.setSchType(CarMstService.SELECT_TYPE_DEFAULT);
				car.setPageListSize(20);
				resultMap.put("data", carMstService.selectCarModel(car));
			}
		}catch(Exception e){
			e.printStackTrace();
			resultCode = "99";
		}
		resultMap.put("code", resultCode);
		return makeJsonResponseHeader(resultMap);
	}

	//차량번호로 조회
	@RequestMapping(value={"/costSearch"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> costSearch(String carPlateNum, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load costSearch Page.");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "00";
		try{
			CarCost carCost = new CarCost();
			carCost = carMstService.selectCostSearch(carPlateNum);
			if(carCost == null){
				resultCode = "99";
			}else{
				resultMap.put("cost", carCost);
			}
		}catch(Exception e){
			e.printStackTrace();
			resultCode = "99";
		}
		resultMap.put("code", resultCode);
		return makeJsonResponseHeader(resultMap);
	}

	//비용계산 결과 조회
	@RequestMapping(value={"/costResultSearch"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> costResultSearch(@RequestBody CarCost carCost, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load costResultSearch Page.");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "00";
		try{
			resultMap.put("cost", carMstService.costResultSearch(carCost));
		}catch(Exception e){
			e.printStackTrace();
			resultCode = "99";
		}
		resultMap.put("code", resultCode);
		return makeJsonResponseHeader(resultMap);
	}

	//차량정보 조회
	@RequestMapping(value={"/carNumSearch"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> carNumSearch(String carPlateNum, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: Load carNumSearch Page.");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "00";
		try{
			CarCost carCost = new CarCost();
			carCost = carMstService.selectcarNumSearch(carPlateNum);
			if(carCost == null){
				resultCode = "99";
			}else{
				resultMap.put("cost", carCost);
			}
		}catch(Exception e){
			e.printStackTrace();
			resultCode = "99";
		}
		resultMap.put("code", resultCode);
		return makeJsonResponseHeader(resultMap);
	}


	//딜러 상세
		@RequestMapping(value={"/popuptest"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
		public String dealer_detail(HttpServletRequest req, HttpServletResponse res, Model model){
			return "tiles.front.category.popuptest.test";
		}

}
