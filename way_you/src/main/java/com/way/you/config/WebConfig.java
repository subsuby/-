package com.way.you.config;

import org.springframework.context.annotation.ComponentScan;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

/**
 * servlet-context.xml�� ��ü
 * @author ������
 *
 */

@Configuration
@EnableWebMvc
@ComponentScan(value=WayYouConstBean.WAY_YOU_COMPONENT_PACKAGE)
public class WebConfig extends WebMvcConfigurerAdapter{

}
