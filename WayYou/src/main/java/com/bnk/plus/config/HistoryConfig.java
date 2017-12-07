package com.bnk.plus.config;

import java.util.HashMap;

import com.bnk.plus.entity.commons.History;

public interface HistoryConfig {
	public static final String INSERT_ACTION = "INSERT";
	public static final String DELETE_ACTION = "DELETE";
	public static final String UPDATE_ACTION = "UPDATE";
	/**
	 * <pre>
	 * 함수명칭: work
	 * 기 능: 등록,수정,삭제된 마스터 데이터 키를 입력받아 데이터를 조회한 후 이력 데이터를 생성하여 출력한다.
	 * 출 력: 이력 데이터
	 * 입 력: 데이터 키
	 * 작성자: jy-seo
	 * 작성일자: 2016-10-12
	 * 수정이력: 없음 	
	 * 
	 * #이력 등록 방법
	 * 1. HistoryConfig.work 메서드를 재정의 한다.
	 * 2. 이력 관리 테이블에 저잘할 데이터는 history.data에 HashMap 형태로 넣어 반환한다.
	 * </pre>
	 */
	public History work(Object param);
	
	/*
	public History work(Object param){
		History h = new History();
		Object data = projectService.selectProject(param);
	
		h.key = "";
		h.title = "";
		h.type = AppConstBean.EVENT_CODE_PROJECT;
		h.modifier = "";
		h.modifiedDate = "";
		h.comment = "";
		h.data = data;
		return h;
	}
	*/
}
