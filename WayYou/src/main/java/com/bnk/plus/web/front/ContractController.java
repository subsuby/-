package com.bnk.plus.web.front;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bnk.plus.commons.components.CoTopComponent;

/**
 * ContractController
 * 계약서 화면 컨트롤러
 * 
 * @author hk-cho
 */
@Controller
@RequestMapping(value = {"/front/contract"})
public class ContractController extends CoTopComponent{
	private static final Logger log = LoggerFactory.getLogger("ADMIN-USUAL");
	private final String tilesPrefix = "tiles.front.contract.";
	
	/*
	 * 계약서 화면
	 */
	@RequestMapping(value={"/form"}, method = RequestMethod.GET, produces = "text/html; charset=utf-8")
	public String appendTab(HttpServletRequest req, HttpServletResponse res, Model model){
		log.debug(" :: Load Contract Page.");
		return tilesPrefix+"contract";
	}
}
