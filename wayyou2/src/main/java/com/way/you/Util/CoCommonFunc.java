package com.way.you.Util;

import org.springframework.stereotype.Component;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.way.you.bean.Combean;

/**
 * 시스템 공통 함수 클래스
 *
 * @author sw-yun
 */
@Component
public class CoCommonFunc extends CoTopComponent {
	/**
	 * 패키지 내 Gson 사용을 위한 serializer bulder 한 gson 오프젝트를 반환한다.
	 * json 형태의 반환을 위해 GridBean 사용시 comBean을 extends한 하위 VO 객체의 serializer 적용
	 * <pre>
	 * 1. 설명 :
	 * 2. 동작 :
	 * 3. Input :
	 * 4. Output :
	 * 5. 수정내역
	 * ----------------------------------------------------------------
	 * 변경일                 작성자                                            변경내용
	 * ----------------------------------------------------------------
	 * 2016. 5. 2.     sw-yun         최초작성
	 * ----------------------------------------------------------------
	 * </pre>
	 *
	 * @return
	 */
	public static Gson getGsonBuiler() {
		GsonBuilder gbuilder = new GsonBuilder();
		gbuilder.registerTypeAdapter(Combean.class, new ComBeanSerializer());
		return gbuilder.create();
	}
}
