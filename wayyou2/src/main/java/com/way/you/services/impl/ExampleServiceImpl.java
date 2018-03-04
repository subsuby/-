package com.way.you.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.way.you.entity.ExampleMapper;
import com.way.you.services.ExampleService;

@Service("ExampleService")
public class ExampleServiceImpl implements ExampleService {
	
	@Autowired ExampleMapper exampleMapper;
	
	@Override
	public String curDate() {
//		System.out.println("12312313");
		String date = exampleMapper.curDate();
		return date;
//		return "1234";
	}
}
