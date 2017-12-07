package com.bnk.plus.web.api;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.CoCodeManager;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.service.car.service.CarMstService;
import com.bnk.plus.service.car.service.CarSchedulerService;

@Controller
@RequestMapping(value = {"/api/code"})
public class CodeAPIController extends CoTopComponent {

	@Autowired
	CarMstService carMstService;
	@Autowired CarSchedulerService carSchedulerService;

	//차량관련 코드
	@RequestMapping(value={"/data/{type}"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> codeData(@PathVariable String type, HttpServletRequest req, HttpServletResponse res){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "00";
		try{
			HashMap<String, Object> dataMap = new HashMap<String, Object>();
			// 차량매물 코드
			if(type.equals("car")){
				dataMap.put("CAR_CODE_SEARCH_INFO", CoCodeManager.CAR_CODE_SEARCH_INFO);									//차량매물 검색 코드
				dataMap.put("CAR_CODE_QUICK_SEARCH", CoCodeManager.CAR_CODE_QUICK_SEARCH);									//차량매물 퀵검색 코드
				dataMap.put("CAR_CODE_DEF_INFO", CoCodeManager.getAllValues(CoConstDef.CAR_CODE_DEF_INFO));					//차량매물 정보 코드
			}
			// 매매단지 코드
			else if(type.equals("market")){
				dataMap.put("MARKET_CODE_SHOP_INFO", CoCodeManager.SHOP_CODE_INFO);											//매매상사 정보 코드
			}
			// 시스템 코드
			else if(type.equals("system")){
				dataMap.put("SYS_CODE_CAR_OPTION_TYPE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_OPTION_TYPE));				//옵션종류 코드
				dataMap.put("SYS_CODE_CAR_OPTION_BASIC", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_OPTION_BASIC));				//옵션(주요) 코드
				dataMap.put("SYS_CODE_CAR_OPTION_EXTERNAL", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_OPTION_EXTERNAL));		//옵션(외장장치) 코드
				dataMap.put("SYS_CODE_CAR_OPTION_INTERNAL", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_OPTION_INTERNAL));		//옵션(내장장치) 코드
				dataMap.put("SYS_CODE_CAR_OPTION_SAFETY", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_OPTION_SAFETY));			//옵션(안전장치) 코드
				dataMap.put("SYS_CODE_CAR_OPTION_CONVENIENCE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_OPTION_CONVENIENCE));	//옵션(편의장치) 코드
				dataMap.put("SYS_CODE_CAR_OPTION_MEDIA", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_OPTION_MEDIA));				//옵션(멀티미디어)
				dataMap.put("SYS_CODE_CAR_OPTION_DEFAULT", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_OPTION_DEFAULT));			//옵션(기본) 코드
				dataMap.put("SYS_CODE_DEALER_EVAL_DIV", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_DEALER_EVAL_DIV));				//딜러평가구분 코드
				dataMap.put("SYS_CODE_CAR_FUEL_TYPE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_FUEL_TYPE));					//연료종류 코드
				dataMap.put("SYS_CODE_CAR_MISSION_TYPE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_MISSION_TYPE));				//기어종류 코드
				dataMap.put("SYS_CODE_CAR_COLOR_TYPE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_COLOR_TYPE));					//색상종류 코드
				dataMap.put("SYS_CODE_CAR_STATUS", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_STATUS));							//매물상태 코드
				dataMap.put("SYS_CODE_CAR_EXT_STATUS", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_EXT_STATUS));					//매물외부상태 코드
				dataMap.put("SYS_CODE_CAR_ACC_STATUS", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_ACC_STATUS));					//매물사고여부 코드
				dataMap.put("SYS_CODE_EIGHTEEN_AREA", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_EIGHTEEN_AREA));					//18개 지역 코드
				dataMap.put("SYS_CODE_MAX_PRICE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_MAX_PRICE));							//최대가격 코드
				dataMap.put("SYS_CODE_VEHICLE_MILE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_VEHICLE_MILE));						//주행거리 코드
				dataMap.put("SYS_CODE_CAR_RENT_STATUS", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_CAR_RENT_STATUS));				//렌터카사용여부 코드
				dataMap.put("SYS_CODE_EMAIL_DOMAIN_TYPE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_EMAIL_DOMAIN_TYPE));			//이메일 코드
				dataMap.put("SYS_CODE_RES_TYPE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_RES_TYPE));								//예약 요청 구분 코드
				dataMap.put("SYS_CODE_RES_STATUS", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_RES_STATUS));							//예약 요청 구분 코드
				dataMap.put("SYS_CODE_EST_TYPE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_EST_TYPE));					//메이크업 서비스 코드
				dataMap.put("SYS_CODE_MAKEUP_STATUS", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_MAKEUP_STATUS));					//메이크업 서비스 코드
				dataMap.put("SYS_CODE_MAKEUP_OPTION", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_MAKEUP_OPTION));					//메이크업 서비스 코드
				dataMap.put("SYS_CODE_FAKE_TYPE", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_FAKE));								//허위매물 코드

				dataMap.put("SYS_CODE_COMM_REG_AREA", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_COMM_REG_AREA));					//공통코드 이전등록지역구분 - C0004
				dataMap.put("SYS_CODE_COMM_CAR_USE_DIV", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_COMM_CAR_USE_DIV));				//공통코드 차량 용도구분 - C0001
				dataMap.put("SYS_CODE_COMM_CAR_DIV", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_COMM_CAR_DIV));						//공통코드 차종구분(잔존율) - C0006
				dataMap.put("SYS_CODE_COMM_CAR_DETAIL_DIV", CoCodeManager.getAllValuesCodeBean(CoConstDef.SYS_CODE_COMM_CAR_DETAIL_DIV));		//공통코드 상세차종구분 - C0003

			}
			resultMap.put("data", dataMap);
		}catch(Exception e){
			e.printStackTrace();
			resultCode = "99";
		}
		resultMap.put("code", resultCode);
		return makeJsonResponseHeader(resultMap);
	}

	//매매단지관련 코드
	@RequestMapping(value={"/version"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> codeVersion(HttpServletRequest req, HttpServletResponse res){
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "00";
		try{
			HashMap<String, Object> dataMap = new HashMap<String, Object>();
			dataMap.put("car", CoCodeManager.getCodeString(CoConstDef.CD_MGMT_MAIN, CoConstDef.CD_MGMT_SUB_CAR));
			dataMap.put("market", CoCodeManager.getCodeString(CoConstDef.CD_MGMT_MAIN, CoConstDef.CD_MGMT_SUB_MARKET));
			dataMap.put("system", CoCodeManager.getCodeString(CoConstDef.CD_MGMT_MAIN, CoConstDef.CD_MGMT_SUB_SYSTEM));
			dataMap.put("db", CoCodeManager.getCodeString(CoConstDef.CD_MGMT_MAIN, CoConstDef.CD_MGMT_SUB_DB));
			resultMap.put("data", dataMap);
		}catch(Exception e){
			e.printStackTrace();
			resultCode = "99";
		}
		resultMap.put("code", resultCode);
		return makeJsonResponseHeader(resultMap);
	}



	@RequestMapping(value={"/refresh"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String refresh(HttpServletRequest req, HttpServletResponse res){
		CoCodeManager.getInstance().refreshCodes();
		return "success";
	}

	@RequestMapping(value={"/refreshMarketCode"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String refreshMarketCode(HttpServletRequest req, HttpServletResponse res){
		CoCodeManager.getInstance().refreshMarketCode();
		return "success";
	}

	@RequestMapping(value={"/refreshCarCode"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String refreshCarCode(HttpServletRequest req, HttpServletResponse res){
		CoCodeManager.getInstance().refreshCarCode();
		return "success";
	}

	@RequestMapping(value={"/refreshQuickSearchItemList"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String refreshQuickSearchItemList(HttpServletRequest req, HttpServletResponse res){
		CoCodeManager.getInstance().refreshQuickSearchItemList();
		return "success";
	}


	/**
	 * Chk on sale car.
	 * 실매물 batch
	 *
	 * @param req the req
	 * @param res the res
	 * @return the string
	 */
	@RequestMapping(value={"/chkOnSaleCar"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String chkOnSaleCar(HttpServletRequest req, HttpServletResponse res){
		carSchedulerService.chkOnSaleCar();
		return "success";
	}

}
