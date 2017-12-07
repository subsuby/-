package com.bnk.plus.web.product;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnk.plus.commons.CoConstDef;
import com.bnk.plus.commons.cdManager.CoCodeManager;
import com.bnk.plus.commons.components.CoTopComponent;

/**
 * Controller
 * 컨트롤러 템플릿
 *
 * @author hk-lee
 */
@Controller
@RequestMapping(value = {"/product/premium"})
public class PremiumController extends CoTopComponent{
	private final String tilesPrefix = "tiles.product.premium.";

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
	//페이지 이동
	@RequestMapping(value={"/detail"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String pageMoveToDetail(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page.");
		return tilesPrefix+"detail";
	}
}
