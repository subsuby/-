package com.bnk.plus.web.product;


import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
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
@RequestMapping(value = {"/product/market"})
public class MarketController extends CoTopComponent{
	private final String tilesPrefix = "tiles.product.market.";
	@Autowired CarMstService carMstService;


	//페이지 이동
	@RequestMapping(value={"/index"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String pageMoveToIndex(HttpServletRequest req, HttpServletResponse res, Model model) throws IOException{
		mlog_usual.debug(" :: Load Page.");
		if( "ROLE_DEALER".equals(loginUserRole()) ){
			if(isLogin()) {
				res.sendRedirect(req.getContextPath() + "/product/mypage/mycarDealerForwarding");
			}
			return tilesPrefix+"dealer.index";
		}else{
			return tilesPrefix+"person.index";
		}
	}
	//페이지 이동
	@RequestMapping(value={"/detail"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String pageMoveToDetail(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page.");
		return tilesPrefix+"detail";
	}
	//방문견적 팝업 AJAX
		@RequestMapping(value={"/visitPop/AJAX"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
		public String visitPop(@RequestBody Map<String, Object> params, HttpServletRequest req, HttpServletResponse res, Model model){
			//Car myCar = carMstService.selectMyCarMstInfo(mycarSeq);
			Car myCar = new Car();
			try {
				BeanUtils.populate(myCar, params);
			} catch (IllegalAccessException e) {
			} catch (InvocationTargetException e) {
			}

			model.addAttribute("myCar", myCar);
			return tilesAjaxPrefix+"market.person.AJAX.estimate_visit_pop_ajax";
		}
	//페이지 컴포넌트 AJAX
	@RequestMapping(value={"/component/AJAX"}, method = {RequestMethod.GET,RequestMethod.POST}, produces = "text/html; charset=utf-8")
	public String getComponent(String json, HttpServletRequest req, HttpServletResponse res, Model model){
		model.addAllAttributes(fromJsonToMap(json));
		return tilesPrefix+"component.component";
	}

}
