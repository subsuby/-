package com.way.you.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.PropertySourcesPlaceholderConfigurer;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.MediaType;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.PathMatchConfigurer;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.i18n.CookieLocaleResolver;
import org.springframework.web.servlet.i18n.LocaleChangeInterceptor;
import org.springframework.web.servlet.view.ContentNegotiatingViewResolver;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import org.springframework.web.servlet.view.UrlBasedViewResolver;
import org.springframework.web.servlet.view.tiles3.TilesConfigurer;
import org.springframework.web.servlet.view.tiles3.TilesView;


/**
 * servlet-context.xml
 * @author 김정섭
 *
 */

@Configuration
@EnableWebMvc
@ComponentScan(value="com.way.you")
public class WebConfig extends WebMvcConfigurerAdapter{
	
	@Override
    public void addResourceHandlers(final ResourceHandlerRegistry registry) {
		registry
//		.addResourceHandler(AppConstBean.RESOURCE_HANDLER)
//		.addResourceLocations(AppConstBean.RESOURCE_LOCATIONS);
		.addResourceHandler("/resources/**")
		.addResourceLocations("/resources/");
    }
	
//	// Validator - BeanValidation
//    @Override
//    public Validator getValidator() {
//        final LocalValidatorFactoryBean validator = new LocalValidatorFactoryBean();
//        return validator;
//    }
	
	@Override
	public void configureContentNegotiation(ContentNegotiationConfigurer configurer) {
		configurer.favorPathExtension(true)
				.useJaf(false)
				.ignoreAcceptHeader(true)
				.mediaType("html", MediaType.TEXT_HTML)
				//.mediaType("json", MediaType.APPLICATION_JSON)
				.defaultContentType(MediaType.TEXT_HTML);
	}
	
	@Override
	public void configurePathMatch(PathMatchConfigurer configurer) {
		configurer.setUseSuffixPatternMatch(false); 
	}
	
	@Bean
    public ViewResolver contentNegotiatingViewResolver(ContentNegotiationManager manager) {
         
        List<ViewResolver> resolvers = new ArrayList< ViewResolver >();
        
        // Excel File Download View Resolver
//        resolvers.add(excelViewResolver());
        
        // URL Base View Resolver
        UrlBasedViewResolver viewResolver0 = new UrlBasedViewResolver();
        viewResolver0.setViewClass(TilesView.class);
        viewResolver0.setOrder(0);
        resolvers.add(viewResolver0);
        
//        resolvers.add(jsonViewResolver());
        
        // Internal Resource View Resolver
        InternalResourceViewResolver viewResolver1 = new InternalResourceViewResolver();
        viewResolver1.setOrder(1);
        viewResolver1.setViewClass(JstlView.class);
        viewResolver1.setPrefix(AppConstBean.VIEW_PREFIX);
        viewResolver1.setSuffix(AppConstBean.VIEW_SUFFIX);
        resolvers.add(viewResolver1);
        
         /*
        JsonViewResolver viewResolver2 = new JsonViewResolver();
        resolvers.add(viewResolver2);
         */
        
        ContentNegotiatingViewResolver resolver = new ContentNegotiatingViewResolver();
        resolver.setViewResolvers(resolvers);
        resolver.setContentNegotiationManager(manager);
        return resolver;
    }
	
	@Bean
    public TilesConfigurer tilesConfigurer() {
        TilesConfigurer tilesConfigurer = new TilesConfigurer();
        tilesConfigurer.setDefinitions(AppConstBean.TILES_LAYOUT_XML_PATH_PATTERN);
        tilesConfigurer.setCheckRefresh(true);
        return tilesConfigurer;
    }
	
//	/**
//     * View resolver for returning JSON in a view-based system. Always returns a
//     * {@link MappingJacksonJsonView}.
//     */
//    public class JsonViewResolver implements ViewResolver {
//        public View resolveViewName(String viewName, Locale locale) throws Exception {
//                MappingJackson2JsonView view = new MappingJackson2JsonView();
//                view.setPrettyPrint(true);
//                return view;
//        }
//    }
	
	@Bean
	public MessageSource messageSource() {

		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasenames(
				"/resources/messages/message");
		messageSource.setUseCodeAsDefaultMessage(true);
		messageSource.setFallbackToSystemLocale(true);
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setCacheSeconds(60);
		return messageSource;
	}
	
	@Bean
	public LocaleResolver localeResolver() {
		
		CookieLocaleResolver cookieLocaleResolver = new CookieLocaleResolver();
//		cookieLocaleResolver.setCookieName("lang");
		return cookieLocaleResolver;
	}
	@Bean
	public LocaleChangeInterceptor localeChangeInterceptor() {
		LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
		localeChangeInterceptor.setParamName("lang");
		return localeChangeInterceptor;
	}
	
	/**
	 * 인터셉터 추가
	 */
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		// Interceptor를 추가 한다.
		registry.addInterceptor(localeChangeInterceptor());
	}
	
	
//	/** 161212 jy-seo ���� �޽����� �����ʾ� �ӽ��ּ�ó��
//	 * Exception �� Error Page Mapping
//	 * @return
//	 */
//	@Bean
//	public SimpleMappingExceptionResolver simpleMappingExceptionResolver() {
//	    SimpleMappingExceptionResolver b = new SimpleMappingExceptionResolver();
//
//	    b.setOrder(1);
//	    b.setDefaultErrorView(AppConstBean.ERROR_PAGES_DEFAULT);
//
//	    Properties mappings = new Properties();
//	    mappings.putAll(AppConstBean.ERROR_PAGES_MAPPING_TO_EXCEPTION);;
//
//	    b.setExceptionMappings(mappings);
//	    return b;
//	}
	
//	@Bean
//	public StandardServletMultipartResolver multipartResolver() {
//		/*
//		CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
//		multipartResolver.setMaxUploadSize(5 * 1024 * 1024);
//		return multipartResolver;
//		*/
//		return new StandardServletMultipartResolver();
//	}
//	
//	@Bean
//	public CacheManager getEhCacheManager(){
//	        return  new EhCacheCacheManager(getEhCacheFactory().getObject());
//	}
//	@Bean
//	public EhCacheManagerFactoryBean getEhCacheFactory(){
//		EhCacheManagerFactoryBean factoryBean = new EhCacheManagerFactoryBean();
//		factoryBean.setConfigLocation(new ClassPathResource("ehcache.xml"));
//		factoryBean.setShared(true);
//		return factoryBean;
//	}
	/**
	* {@link org.springframework.core.env.Environment}를 사용해 빈 주입 값을 치환
	*/
	@Bean
	public static PropertySourcesPlaceholderConfigurer propertySourcesPlaceholderConfigurer() {
		return new PropertySourcesPlaceholderConfigurer();
	}
}
