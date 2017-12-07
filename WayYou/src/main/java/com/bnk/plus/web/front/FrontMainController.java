package com.bnk.plus.web.front;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import com.bnk.plus.commons.components.CoTopComponent;

@Controller
@RequestMapping(value = {"/front"})
public class FrontMainController extends CoTopComponent{
	private final String tilesPrefix = "tiles.front.main.";
	
	@RequestMapping(value={"/main"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public ModelAndView main(HttpServletRequest req, HttpServletResponse res, Model model){
		ModelAndView mav = new ModelAndView();

		RedirectView redirectView = new RedirectView(); // redirect url 설정
		redirectView.setUrl(req.getContextPath() + "/front/index");
		redirectView.setExposeModelAttributes(false);

		mav.setView(redirectView);

		return mav;
	}
	
	@RequestMapping(value={"/index"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String index(HttpServletRequest req, HttpServletResponse res, Model model){
		mlog_usual.debug(" :: Start main");
		
		return tilesPrefix+"main";
	}
}
