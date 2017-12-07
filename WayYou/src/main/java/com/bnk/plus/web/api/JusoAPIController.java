package com.bnk.plus.web.api;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Device;
import com.bnk.plus.service.session.service.T2UserService;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

@Controller
@RequestMapping(value = {"/api/juso"})
public class JusoAPIController extends CoTopComponent {

	@Autowired T2UserService userService;

	//매매단지 리스트 조회
	@RequestMapping(value={"/addrlink"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public @ResponseBody ResponseEntity<Object> addrlink(Device device, HttpServletRequest req, HttpServletResponse res){
		mlog_usual.debug(" :: API - addrlink");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		String resCd = "00";
		String data = "";
		try{
			OkHttpClient client = new OkHttpClient();
			String params = "?"+req.getQueryString();
			Request request = new Request.Builder().url("http://www.juso.go.kr/addrlink/addrLinkApiJsonp.do" + params).build();
			Response response = client.newCall(request).execute();
			data = response.body().string();
		}catch(IOException e){
			e.printStackTrace();
			resCd = "99";
		}

		resultMap.put("code", resCd);
		resultMap.put("data", data);
		return makeJsonResponseHeader(resultMap);
	}

}
