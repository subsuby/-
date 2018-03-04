package com.way.you.bean;


public class ApptGuest extends Combean{
	
	private String apptId;					//약속 시퀀스
	private String apptGuestId;				//약속 게스트 ID
	private String apptGuestCondition;		//약속 게스트 상태
	private User guest;
	
	public String getApptId() {
		return apptId;
	}
	public void setApptId(String apptId) {
		this.apptId = apptId;
	}
	public String getApptGuestId() {
		return apptGuestId;
	}
	public void setApptGuestId(String apptGuestId) {
		this.apptGuestId = apptGuestId;
	}
	public String getApptGuestCondition() {
		return apptGuestCondition;
	}
	public void setApptGuestCondition(String apptGuestCondition) {
		this.apptGuestCondition = apptGuestCondition;
	}
	public User getGuest() {
		return guest;
	}
	public void setGuest(User guest) {
		this.guest = guest;
	}
	@Override
	public String toString() {
		return "ApptGuest [apptId=" + apptId + ", apptGuestId=" + apptGuestId + ", apptGuestCondition="
				+ apptGuestCondition + ", guest=" + guest + "]";
	}
	
}
