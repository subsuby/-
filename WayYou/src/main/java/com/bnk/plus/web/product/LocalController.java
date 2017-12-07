package com.bnk.plus.web.product;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnk.plus.commons.components.CoTopComponent;

/**
 * Controller
 * 컨트롤러 템플릿
 *
 * @author hk-lee
 */
@Controller
@RequestMapping(value = {"/product/local"})
public class LocalController extends CoTopComponent{
	private final String tilesPrefix = "tiles.product.local.";

	//페이지 이동
	@RequestMapping(value={"/index"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String pageMoveToIndex(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page.");
		return tilesPrefix+"index";
	}
	//페이지 이동
	@RequestMapping(value={"/detail"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String pageMoveToDetail(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Load Page.");
		return tilesPrefix+"detail";
	}
}
