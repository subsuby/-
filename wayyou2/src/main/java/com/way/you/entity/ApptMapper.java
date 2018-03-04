package com.way.you.entity;

import java.util.List;

import com.way.you.bean.Appt;
import com.way.you.bean.ApptGuest;
import com.way.you.bean.Calendar;
import com.way.you.bean.User;
import com.way.you.config.Mapper;

@Mapper
public interface ApptMapper {

	List<Appt> getList(Appt appt);

	List<ApptGuest> getListGuest(Appt appt);

	User getHostInfo(Appt appt);

	User getGuestInfo(ApptGuest apptGuest);

	List<Appt> getCalendarInfo(Calendar calendar);

	Appt getMainInfo(Appt param);

	int registAppt(Appt param);

	String getLastApptId(Appt param);

	int registApptGuest(ApptGuest guest);

	Appt getApptDetail(Appt appt);

	int modifiedAppt(Appt param);

	void truncateGuest(Appt param);

	int attendAppt(ApptGuest param);

	int selectWaitCount(ApptGuest param);

	void changeApptCondition(Appt appt);

	int cancelAppt(Appt param);

}