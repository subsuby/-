package com.way.you.controllers;
 
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.way.you.services.ExampleService;
 
/**
 * Handles requests for the application home page.
 */
@Controller
@RequestMapping(value = "/example")
public class ExampleController {
	
	@Autowired
	ExampleService exampleService;
	
	@RequestMapping(value = "/example", method = RequestMethod.GET)
	public String example(Model model) {
		String name = "Psyken";
		System.out.println("example called()");
		String date;
		date = exampleService.curDate();
		System.out.println("date is "+date);
		model.addAttribute("name", name );
	return "/example/example";
	}
}