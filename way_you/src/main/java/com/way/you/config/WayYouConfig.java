package com.way.you.config;

import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;


/**
 * root-context.xml�� ��ü
 * @author ������
 *
 */
@Configuration
@ComponentScan(value=WayYouConstBean.WAY_YOU_COMPONENT_PACKAGE)
public class WayYouConfig {

}
