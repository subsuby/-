package com.way.you.config;

import java.util.ArrayList;
import java.util.List;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ReloadableResourceBundleMessageSource;
import org.springframework.http.MediaType;
import org.springframework.web.accept.ContentNegotiationManager;
import org.springframework.web.servlet.LocaleResolver;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.ContentNegotiationConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
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
 * servlet-context.xml�� ��ü
 * @author ������
 *
 */

@Configuration
@EnableWebMvc
@ComponentScan(value=WayYouConstBean.WAY_YOU_COMPONENT_PACKAGE)
public class WebConfig extends WebMvcConfigurerAdapter{
	@Override
    public void addResourceHandlers(final ResourceHandlerRegistry registry) {
		registry.addResourceHandler(AppConstBean.RESOURCE_HANDLER).addResourceLocations(AppConstBean.RESOURCE_LOCATIONS);
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
		/*
		 * Controller�� @RequestMapping���� 
		 * "{pathA}/{pathB}"�� ���� �� 
		 * @PathVariable("pathB") final String pathB
		 * �� �� �������Ҷ� Ȯ���ڴ� �Ѿ���� �ʴ´�.
		 * UseSuffixPatternMatch�� false�� �����ϸ� Ȯ���ڵ� ���� �Ѿ�´�.
		 */
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
	
//	@Bean // 2016.4.19. ks-choi. ExcelDownloadView.java �ּ��� ����ó�� �����Ͽ� ������ ��� ����
//	public ViewResolver excelViewResolver(){
//		return new ExcelViewResolver();
//	}
	
	/**
	 * <pre>
	 * 1. ���� : �ٱ��� ������ ���� messageSource
	 * 2. ���� : 
	 *    ��� ���
	 *     JAVA
	 *      @Autowired MessageSource;
	 *      messageSource.getMessage("code", {"args"}, "defaultMessage", Locale);
	 *     JSP (Taglib)
	 *      <spring:message code="code" text="defaultMessage"/>
	 * 3. Input : 
	 * 4. Output : 
	 * 5. ��������
	 * ----------------------------------------------------------------
	 * ������                 �ۼ���                                            ���泻��
	 * ----------------------------------------------------------------
	 * 2016. 4. 8.     ks-choi                                      �����ۼ�
	 * ----------------------------------------------------------------
	 * </pre>
	 *
	 * @return
	 */
	@Bean
	public MessageSource messageSource() {

		ReloadableResourceBundleMessageSource messageSource = new ReloadableResourceBundleMessageSource();
		messageSource.setBasenames(
				"classpath:messages/message"
				, "classpath:messages/validation");
		// if true, the key of the message will be displayed if the key is not
		// found, instead of throwing a NoSuchMessageException
		messageSource.setUseCodeAsDefaultMessage(true);
		messageSource.setFallbackToSystemLocale(true);
		messageSource.setDefaultEncoding("UTF-8");
		// # -1 : never reload, 0 always reload
		messageSource.setCacheSeconds(60);
		return messageSource;
	}
	
	/**
	 * <pre>
	 * 1. ���� : �ٱ��� ������ ���� ������
	 * 2. ���� : 
	 *     ���������� SessionLocaleResolver, AcceptHeaderLocaleResolver, CookieLocaleResolver, FixedLocaleResolver 4������ �ִ�.
	 *     > SessionLocaleResolver
	 *      ���� �������� Locale�� ����ϰ� LocaleChangeInterceptor�� �߰��� ����Ͽ� �Ķ���ͷ� ������ �� �ִ�.
	 *      ���� ���� ������ RequestContextUtils.getLocale(httpRequest)�� Ȯ���� �� �ִ�.
	 *     > AcceptHeaderLocaleResolver
	 *      request�� �ش� ���� �� "accept-language" ���� ����Ѵ�.
	 *     > CookieLocaleResolver
	 *      ��Ű�� ����ϸ� setLocale()�� ��Ű�� ����, resolveLocale()�� ��Ű�� Locale�� �����´�.
	 *      ���� ���� ��� defaultLocale�� ����ϰ�, defaultLocale�� ���� ��� �ش��� "Accept-Language"�� ����Ѵ�.
	 *      Property : "cookieName, cookieDomain, cookiePath, cookieMaxAge, cookieSecure"
	 *     > FixedLocaleResolver
	 *      ��û�� ������� Ư�� Locale(defaultLocale)�� �����ϸ�, setLocale()�� �������� �ʴ´�.
	 * 3. Input : 
	 * 4. Output : 
	 * 5. ��������
	 * ----------------------------------------------------------------
	 * ������                 �ۼ���                                            ���泻��
	 * ----------------------------------------------------------------
	 * 2016. 4. 8.     ks-choi                                      �����ۼ�
	 * ----------------------------------------------------------------
	 * </pre>
	 *
	 * @return
	 */
	@Bean
	public LocaleResolver localeResolver() {
		
		// ���� Ÿ�� 1. ���� �������� Locale ���
		//SessionLocaleResolver sessionlocaleresolver = new SessionLocaleResolver();
		//sessionlocaleresolver.setDefaultLocale(StringUtils.parseLocaleString(AppConstBean.MESSAGE_SOURCE_DEFAULT_LOCALE));	// �⺻ ������
		
		// ���� Ÿ�� 2. request�� Header�� "accept-language" ���
		//AcceptHeaderLocaleResolver acceptHeaderLocaleResolver = new AcceptHeaderLocaleResolver();
		
		// ���� Ÿ�� 3. ��Ű�� �����Ǿ��ִ� Locale ���
		CookieLocaleResolver cookieLocaleResolver = new CookieLocaleResolver();
		
		return cookieLocaleResolver;
	}
	@Bean
	public LocaleChangeInterceptor localeChangeInterceptor() {
		LocaleChangeInterceptor localeChangeInterceptor = new LocaleChangeInterceptor();
		// request�� �Ѿ���� language parameter�� �޾Ƽ� locale�� ���� �Ѵ�.
		localeChangeInterceptor.setParamName(AppConstBean.MESSAGE_SOURCE_DEFAULT_LOCALE_PARAM_NAME);
		return localeChangeInterceptor;
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
}
