package com.bnk.plus.web.forward;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.service.car.service.CarMstService;

@Controller
@RequestMapping(value = {"/front/forward"})
public class ForwardController extends CoTopComponent {
	
	@Autowired
	CarMstService carMstService;
		
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
		return "tiles.layout.front.forward.bnkcapital";
	}
	
	
	
}
