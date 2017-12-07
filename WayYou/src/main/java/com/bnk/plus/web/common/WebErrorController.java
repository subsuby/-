package com.bnk.plus.web.common;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/error")
public class WebErrorController {
	
	private static final Logger logger = LoggerFactory.getLogger(WebErrorController.class);
	
	private final String jspPrefix = "/error/";
	
	@Autowired MessageSource messageSource;
	
	@RequestMapping(value = "/{errorCode}", method = RequestMethod.GET, produces = "text/html; charset=utf8")
	public String accessDenied(Locale locale, Model model, @PathVariable("errorCode")  String errorCode, HttpServletRequest req) {
		logger.error(
				"Request URL is Access Denied", new Object[]{}
			);
		return jspPrefix+errorCode;
	}
}