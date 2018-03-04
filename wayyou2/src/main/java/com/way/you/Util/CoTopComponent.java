package com.way.you.Util;

import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Type;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.annotation.PropertySources;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.StandardPasswordEncoder;
import org.springframework.stereotype.Component;
import org.springframework.web.context.WebApplicationContext;

import com.google.common.reflect.TypeToken;
import com.google.gson.Gson;
import com.way.you.config.AppConstBean;

import atg.taglib.json.util.JSONObject;


// TODO: Auto-generated Javadoc
/**
 * 각 Controller 의 상위 Component 클래스.
 *
 * @author sw-yun
 */
@Component
@PropertySources(value = {@PropertySource(value=AppConstBean.APP_CONFIG_PROPERTIES_PATH)})
public class CoTopComponent {

	protected final String tilesAjaxPrefix = "tiles.ajax.product.";

	/**  Spring Security Password Encoder. */
	@Autowired protected static StandardPasswordEncoder passwordEncoder;

	/**  WebApplicationContext. */
	protected static WebApplicationContext applicationContext;

	/**
	 * Sets the web application context.
	 *
	 * @param applicationContext the new web application context
	 */
	@SuppressWarnings("static-access")
	@Autowired
	public void setWebApplicationContext(WebApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
	}

	/** The message source. */
	protected static MessageSource messageSource;

	/**
	 * Sets the message source.
	 *
	 * @param messageSource the new message source
	 */
	@SuppressWarnings("static-access")
	@Autowired
	public void setMessageSource(MessageSource messageSource) {
		this.messageSource = messageSource;
	}

	/** The Constant log_usual. */
	protected static final Logger log_usual = LoggerFactory.getLogger("ADMIN-USUAL");

	/** The Constant log. */
	protected static final Logger log = LoggerFactory.getLogger("DEFAULT");

	/** The Constant log_update. */
	protected static final Logger log_update = LoggerFactory.getLogger("ADMIN-UPDATE");

	/** The Constant log_error. */
	protected static final Logger log_error = LoggerFactory.getLogger("ADMIN-ERROR");

	/** The Constant mlog_usual. */
	protected static final Logger mlog_usual = LoggerFactory.getLogger("MOBILE-USUAL");

	/** The Constant mlog_update. */
	protected static final Logger mlog_update = LoggerFactory.getLogger("MOBILE-UPDATE");

	/** The Constant mlog_error. */
	protected static final Logger mlog_error = LoggerFactory.getLogger("MOBILE-ERROR");

	protected static final Logger schLog = LoggerFactory.getLogger("SYSTEM-SCHEDULE");


    /**
     * <pre>
     * 1. 설명 : 2진 비트 연산(And)을 통해 메뉴나 체크박스 등의 선택 여부를 간략히 확인할 수 있다.
     * 2. 동작 : A, B 두 값의 Bit 연산(And)을 수행하여 Boolean형 결과를 리턴한다.
     * 	         ex 1) 15 (1111) & 8 (1000) = 8 (1000) : true
     *          ex 2) 11 (0111) & 2 (0010) = 8 (0010) : true
     *          ex 3) 4 (0100) & 8 (1000) = 0 (0000) : false
     *          ex 4) jsp taglib
     *              <c:choose>
     *                  <c:when test="${ct:bitOperAnd(5,4)}">true</c:when>
     *                  <c:otherwise>false</c:otherwise>
     *              </c:choose>
     * 3. Input : int A, int B
     * 4. Output : boolean(true, false)
     * 5. 수정내역
     * ----------------------------------------------------------------
     * 변경일                 작성자                                            변경내용
     * ----------------------------------------------------------------
     * 2015. 8. 17.     ks-choi         최초작성
     * ----------------------------------------------------------------
     * </pre>
     *
     * @param a the a
     * @param b the b
     * @return boolean (true: 가능, false: 불가능)
     */
    public static boolean bitOperAnd(int a, int b) {
		return (a & b) > 0;
	}




	/**
	 * Send json object.
	 *
	 * @param response the response
	 * @param json the json
	 * @throws IOException Signals that an I/O exception has occurred.
	 */
	protected void sendJsonObject(HttpServletResponse response, JSONObject json) throws IOException {
		response.setCharacterEncoding(AppConstBean.APP_ENCODING);
		PrintWriter out = response.getWriter();
		out.print(json);
		out.flush();
		out.close();
	}

	/**
	 * To json.
	 *
	 * @param obj the obj
	 * @return the string
	 */
	protected static String toJson(Object obj) {
		Gson gson = CoCommonFunc.getGsonBuiler();
		return gson.toJson(obj);
	}

	/**
	 * From json.
	 *
	 * @param jsonString the json string
	 * @param collectionType the collection type
	 * @return the object
	 */
	protected static Object fromJson(String jsonString, Type collectionType) {
		Gson gson = CoCommonFunc.getGsonBuiler();
		return gson.fromJson(jsonString, collectionType);
	}
	/**
	 * From json.
	 *
	 * @param jsonString the json string
	 * @param collectionType the collection type
	 * @return the object
	 */
	protected static Map<String, Object> fromJsonToMap(String jsonString) {
		Gson gson = CoCommonFunc.getGsonBuiler();
		Type mapType = new TypeToken<Map<String, Object>>(){}.getType();
		return (Map<String, Object>) fromJson(jsonString, mapType);
	}

	/**
	 * Make json response header.
	 *
	 * @param obj the obj
	 * @return the response entity
	 */
	protected static ResponseEntity<Object> makeJsonResponseHeader(Object obj) {
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.set("Content-Type", MediaType.APPLICATION_JSON_VALUE + "; charset=utf-8");
		return new ResponseEntity<Object>(toJson(obj), responseHeaders, HttpStatus.OK);
	}

}
