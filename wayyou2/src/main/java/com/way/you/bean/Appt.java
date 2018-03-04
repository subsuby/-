package com.way.you.bean;

import java.util.List;

public class Appt extends Combean{
	
	private String apptId;					//약속 시퀀스
	private String apptHostId;				//약속 호스트 아이디
	private String apptTime;				//약속 시간
	private String apptPlace;				//약속 장소
	private String apptGuest;				//약속 인원
	private String apptPurpose;				//약속 목적
	private String apptAlarm;				//약속 알람 시간
	private String apptCondition;			//약속 상태 코드
	private String apptLat;
	private String apptLng;
	private User host;						//유저
	private List<ApptGuest> apptGuestList;	//약속 게스트
	
	public String getApptId() {
		return apptId;
	}
	public void setApptId(String apptId) {
		this.apptId = apptId;
	}
	public String getApptHostId() {
		return apptHostId;
	}
	public void setApptHostId(String apptHostId) {
		this.apptHostId = apptHostId;
	}
	public String getApptTime() {
		return apptTime;
	}
	public void setApptTime(String apptTime) {
		this.apptTime = apptTime;
	}
	public String getApptPlace() {
		return apptPlace;
	}
	public void setApptPlace(String apptPlace) {
		this.apptPlace = apptPlace;
	}
	public String getApptGuest() {
		return apptGuest;
	}
	public void setApptGuest(String apptGuest) {
		this.apptGuest = apptGuest;
	}
	public String getApptPurpose() {
		return apptPurpose;
	}
	public void setApptPurpose(String apptPurpose) {
		this.apptPurpose = apptPurpose;
	}
	public String getApptAlarm() {
		return apptAlarm;
	}
	public void setApptAlarm(String apptAlarm) {
		this.apptAlarm = apptAlarm;
	}
	public String getApptCondition() {
		return apptCondition;
	}
	public void setApptCondition(String apptCondition) {
		this.apptCondition = apptCondition;
	}
	public List<ApptGuest> getApptGuestList() {
		return apptGuestList;
	}
	public void setApptGuestList(List<ApptGuest> apptGuestList) {
		this.apptGuestList = apptGuestList;
	}
	public User getHost() {
		return host;
	}
	public void setHost(User host) {
		this.host = host;
	}
	public String getApptLat() {
		return apptLat;
	}
	public void setApptLat(String apptLat) {
		this.apptLat = apptLat;
	}
	public String getApptLng() {
		return apptLng;
	}
	public void setApptLng(String apptLng) {
		this.apptLng = apptLng;
	}
	@Override
	public String toString() {
		return "Appt [apptId=" + apptId + ", apptHostId=" + apptHostId + ", apptTime=" + apptTime + ", apptPlace="
				+ apptPlace + ", apptGuest=" + apptGuest + ", apptPurpose=" + apptPurpose + ", apptAlarm=" + apptAlarm
				+ ", apptCondition=" + apptCondition + ", apptLat=" + apptLat + ", apptLng=" + apptLng + ", host="
				+ host + ", apptGuestList=" + apptGuestList
				+ "]";
	}
	
}
