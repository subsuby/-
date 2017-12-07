package com.bnk.plus.web.product;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnk.plus.commons.components.CoTopComponent;
import com.bnk.plus.entity.Car;
import com.bnk.plus.service.car.service.CarMstService;

/**
 * Controller
 * 컨트롤러 템플릿
 *
 * @author hk-lee
 */
@Controller
@RequestMapping(value = {"/product"})
public class MainController extends CoTopComponent{
	
	@Autowired
	CarMstService carMstService;
	
	private final String tilesPrefix = "tiles.product.main.";

	//페이지 이동
	@RequestMapping(value={"/index"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String pageMove(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page.");
		return tilesPrefix+"index";
	}
	
	//이용약관
	@RequestMapping(value={"/terms"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String terms(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: terms Page.");
		return tilesPrefix+"terms";
	}
	
	//개인정보 취급방침
	@RequestMapping(value={"/privacy"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String privacy(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: privacy Page.");
		return tilesPrefix+"privacy";
	}
	
	//책임한계
	@RequestMapping(value={"/indemnity"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String indemnity(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: indemnity Page.");
		return tilesPrefix+"indemnity";
	}

	//메인 인증중고차 리스트
	@RequestMapping(value={"/mainCertify/AJAX"}, produces = "text/html; charset=utf-8")
	public String mainCertify(Car car,HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load mainCertify Page.");

		Map<String, Object> resMap = new HashMap<>();
		try {
			car.setSchType(CarMstService.SELECT_TYPE_CERTIFYCATE);
			resMap.put("data", carMstService.selectCarModel(car));
			model.addAttribute("certify", resMap);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return tilesAjaxPrefix+"main.AJAX.index_list_ajax";
	}

	//사이트맵
	@RequestMapping(value={"/sitemap"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String sitemap(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: sitemap Page.");
		return tilesPrefix+"sitemap";
	}
}
