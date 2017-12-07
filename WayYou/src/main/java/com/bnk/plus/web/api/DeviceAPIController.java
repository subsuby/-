package com.bnk.plus.web.api;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.CoCodeManager;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Device;
import com.bnk.plus.service.session.service.T2UserService;

@Controller
@RequestMapping(value = {"/api/device"})
public class DeviceAPIController extends CoTopComponent {
	
	@Autowired T2UserService userService;
	
	//매매단지 리스트 조회 - old
	@RequestMapping(value={"/infoRegist"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> deviceInfoRegist(Device device, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: API - infoRegist");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "00";
		try{
			// uuid 또는 notifiction이 신규/ 변경 된 경우만 호출되어야함, 
			// user id 매핑은 로그인 시점에서 처리 (기등록된 사용자 전화등)
			device.setUserId("-1");
			userService.setDeviceInfo(device, req);
			resultMap.put("android", CoCodeManager.getCodes(CoConstDef.CD_DEVICE_VER_ANDROID).firstElement());
			resultMap.put("ios", CoCodeManager.getCodes(CoConstDef.CD_DEVICE_VER_IOS).firstElement());
		}catch(Exception e){
			e.printStackTrace();
			resultCode = "99";
		}
		resultMap.put("code", resultCode);
		
		return makeJsonResponseHeader(resultMap);  
	}
	
	//매매단지 리스트 조회 - new
	@RequestMapping(value={"/infoRegistNew"}, method = RequestMethod.POST, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> deviceInfoRegistNew(@RequestBody Device device, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: API - infoRegist");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resultCode = "00";
		try{
			// uuid 또는 notifiction이 신규/ 변경 된 경우만 호출되어야함, 
			// user id 매핑은 로그인 시점에서 처리 (기등록된 사용자 전화등)
			device.setUserId("-1");
			userService.setDeviceInfo(device, req);
			resultMap.put("android", CoCodeManager.getCodes(CoConstDef.CD_DEVICE_VER_ANDROID).firstElement());
			resultMap.put("ios", CoCodeManager.getCodes(CoConstDef.CD_DEVICE_VER_IOS).firstElement());
		}catch(Exception e){
			e.printStackTrace();
			resultCode = "99";
		}
		resultMap.put("code", resultCode);
		
		return makeJsonResponseHeader(resultMap);  
	}
	
}
