package com.way.you.services;

import java.util.List;

import com.way.you.bean.Appt;
import com.way.you.bean.ApptGuest;
import com.way.you.bean.Calendar;

public interface ApptService {

	//호스트명 및 게스트에 이름이 있을때의 리스트 찾기
	List<Appt> getList(Appt appt);

	List<Calendar> getCalendarInfo(Calendar param);

	//메인 정보가져오기
	Appt getMainInfo(Appt param);

	//약속 등록
	String registAppt(Appt param);

	Appt getApptDetail(Appt appt);

	String modifiedAppt(Appt param);

	String deleteAppt(Appt param);

	String attendAppt(ApptGuest param);
	
}
