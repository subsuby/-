package com.way.you.services.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.way.you.bean.Appt;
import com.way.you.bean.ApptGuest;
import com.way.you.bean.Calendar;
import com.way.you.entity.ApptMapper;
import com.way.you.services.ApptService;

@Service("ApptService")
public class ApptServiceImpl implements ApptService {

	@Autowired ApptMapper apptMapper;
	
	@Override
	@Transactional
	public List<Appt> getList(Appt appt) {
		
		List<Appt> result = new ArrayList<Appt>();
		//DB select
		result = apptMapper.getList(appt);
		for(int i = 0; i < result.size(); i++) {
			//호스트 유저 정보 조회
			result.get(i).setHost(apptMapper.getHostInfo(result.get(i)));
			//게스트 정보 조회
			List<ApptGuest> guest = new ArrayList<ApptGuest>();
			guest = apptMapper.getListGuest(result.get(i));
			//게스트 유저 정보 조회
			for(int j = 0; j < guest.size(); j++) {
				guest.get(j).setGuest(apptMapper.getGuestInfo(guest.get(j)));
			}
			result.get(i).setApptGuestList(guest);
		}
		return result;
	}

	@Override
	@Transactional
	public List<Calendar> getCalendarInfo(Calendar param) {
		List<Calendar> calendar = new ArrayList<Calendar>();
		//해당 월의 마지막 날짜 구하기
		int year = Integer.parseInt(param.getYear());
		int month = Integer.parseInt(param.getMonth());
		int day = 1;
		java.util.Calendar cal = java.util.Calendar.getInstance();
		cal.set(year, month-1, day); //월은 -1해줘야 해당월로 인식
		int lastDay = cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH);
		for(int i = 1 ; i < lastDay; i++) {
			String dates = String.valueOf(i);
			if(i < 10) {
				dates = "0"+dates;
			}
			Calendar list = new Calendar();
			param.setYmd(param.getYear()+"-"+param.getMonth()+"-"+dates);
			List<Appt> appt = apptMapper.getCalendarInfo(param);
			if(appt.size() != 0){
				list.setYear(param.getYear());
				list.setMonth(param.getMonth());
				list.setDates(dates);
				list.setAppt(appt);
				calendar.add(list);
			}
		}
		
		return calendar;
	}

	@Override
	public Appt getMainInfo(Appt param) {
		Appt result = new Appt();
		//DB select
		result = apptMapper.getMainInfo(param);
		if(result != null) {
			//호스트 유저 정보 조회
			result.setHost(apptMapper.getHostInfo(result));
			//게스트 정보 조회
			List<ApptGuest> guest = new ArrayList<ApptGuest>();
			guest = apptMapper.getListGuest(result);
			//게스트 유저 정보 조회
			for(int i = 0; i < guest.size(); i++) {
				guest.get(i).setGuest(apptMapper.getGuestInfo(guest.get(i)));
			}
			result.setApptGuestList(guest);
		}
		
		return result;
	}

	@Override
	public String registAppt(Appt param) {
		String result = "";
		int insert = 0;
		try {
			param.setApptGuest(String.valueOf(param.getApptGuestList().size()));
			insert = apptMapper.registAppt(param);
			param.setApptId(apptMapper.getLastApptId(param));
			for(int i = 0; i < param.getApptGuestList().size(); i++) {
				ApptGuest guest = new ApptGuest();
				guest.setApptGuestId(param.getApptGuestList().get(i).getApptGuestId());
				guest.setApptGuestCondition("W");
				guest.setApptId(param.getApptId());
				int insertG = apptMapper.registApptGuest(guest);
				if(insertG == 0) {
					insert = 0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		if(insert == 0) {
			result = "false";
		}else {
			result = "true";
		}
		
		return result;
	}

	@Override
	public Appt getApptDetail(Appt appt) {
		//약속정보 가져오기
		appt = apptMapper.getApptDetail(appt);
		//호스트 정보 가져오기
		appt.setHost(apptMapper.getHostInfo(appt));
		//게스트 정보 가져오기
		List<ApptGuest> guestList = apptMapper.getListGuest(appt);
		for(int i = 0; i < guestList.size(); i++) {
			guestList.get(i).setGuest(apptMapper.getGuestInfo(guestList.get(i)));
		}
		appt.setApptGuestList(guestList);
		System.out.println(appt);
		return appt;
	}
	
	@Override
	public String modifiedAppt(Appt param) {
		String result = "";
		int update = 0;
		try {
			param.setApptGuest(String.valueOf(param.getApptGuestList().size()));
			update = apptMapper.modifiedAppt(param);
			//게스트 전체 삭제
			apptMapper.truncateGuest(param);
			//게스트 업데이트
			for(int i = 0; i < param.getApptGuestList().size(); i++) {
				ApptGuest guest = new ApptGuest();
				guest.setApptGuestId(param.getApptGuestList().get(i).getApptGuestId());
				guest.setApptGuestCondition("W");
				guest.setApptId(param.getApptId());
				int insertG = apptMapper.registApptGuest(guest);
				if(insertG == 0) {
					update = 0;
				}
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		if(update == 0) {
			result = "false";
		}else {
			result = "true";
		}
		
		return result;
	}

	@Override
	public String deleteAppt(Appt param) {
		String result = "";
		int delete = 0;
		try {
			//게스트 전체 삭제
//			apptMapper.truncateGuest(param);
			//약속 삭제
			delete = apptMapper.cancelAppt(param);
		}catch(Exception e) {
			e.printStackTrace();
		}
		if(delete == 0) {
			result = "false";
		}else {
			result = "true";
		}
		
		return result;
	}

	@Override
	public String attendAppt(ApptGuest param) {
		String result = "";
		int update = 0;
		try {
			//약속 참석하기
			update = apptMapper.attendAppt(param);
			//약속 상태 바꾸기
			int waitCount = apptMapper.selectWaitCount(param);
			if(waitCount == 0) {
				Appt appt = new Appt();
				appt.setApptCondition("P");
				appt.setApptId(param.getApptId());
				apptMapper.changeApptCondition(appt);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		if(update == 0) {
			result = "false";
		}else {
			result = "true";
		}
		
		return result;
	}
}
