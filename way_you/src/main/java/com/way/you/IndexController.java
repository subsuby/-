package com.way.you;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("index")
public class IndexController {
	
	@RequestMapping("foo")
	String foo() {
		System.out.println("foo() called");
		return "hi foo~";
	}
}
