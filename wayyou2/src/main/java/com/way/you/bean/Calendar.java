package com.way.you.bean;

import java.util.List;

public class Calendar extends Combean{
	
	private String year;		//검색 년
	private String month;		//검색 월
	private String dates;		//검색 일
	private String userId;		//검색 사용자
	private List<Appt> appt;	//해당 일의 약속 리스트
	private String ymd;			//검색 년월일
	
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public String getDates() {
		return dates;
	}
	public void setDates(String dates) {
		this.dates = dates;
	}
	public List<Appt> getAppt() {
		return appt;
	}
	public void setAppt(List<Appt> appt) {
		this.appt = appt;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getYmd() {
		return ymd;
	}
	public void setYmd(String ymd) {
		this.ymd = ymd;
	}
}
