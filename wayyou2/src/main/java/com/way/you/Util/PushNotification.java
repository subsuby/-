package com.way.you.Util;

import java.sql.ResultSet;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.apache.http.HttpRequest;

import com.mysql.jdbc.Connection;
import com.mysql.jdbc.Statement;

public class PushNotification {

	public PushNotification(HttpServletRequest req) {
//		ArrayList<String> token = new ArrayList<String>();			//token값을 ArrayList에 저장
//		String MESSAGE_ID = String.valueOf(Math.random() % 100 + 1);//메시지 고유 ID
//		boolean SHOW_ON_IDLE = true;								//옙 활성화 상태일때 보여줄것인지
//		int LIVE_TIME = 1;											//옙 비활성화 상태일때 FCM가 메시지를 유효화하는 시간
//		int RETRY = 2;												//메시지 전송실패시 재시도 횟수
//		
//		String simpleApiKey = "AIzaSyCi1BAWAX-wNDenwEnv1KpcKOUit6fG0gI";
//		String gcmURL = "https://android.googleapis.com/fcm/send";    
//		Connection conn = null; 
//		Statement stmt = null; 
//		ResultSet rs = null;
//	    
//	    String msg = req.getParameter("message");;
//	    
//	    if(msg==null || msg.equals("")){
//	        msg="";
//	    }
//	    
//	    msg = new String(msg.getBytes("UTF-8"), "UTF-8");	//메시지 한글깨짐 처리
//	    
//	    try {
//	        String url = "jdbc:sqlserver://localhost:1433;databaseName=사용 할 DB명;user=계정명;password=패스워드;";
//	        conn = DriverManager.getConnection(url);
//	        stmt = conn.createStatement();            
//	        String sql = "select token from users";
//	        rs = stmt.executeQuery(sql);
//	        
//	        //모든 등록ID를 리스트로 묶음
//	        while(rs.next()){
//	            token.add(rs.getString("Token"));
//	        }
//	        conn.close();
//	        
//	        Sender sender = new Sender(simpleApiKey);
//	        Message message = new Message.Builder()
//	        .collapseKey(MESSAGE_ID)
//	        .delayWhileIdle(SHOW_ON_IDLE)
//	        .timeToLive(LIVE_TIME)
//	        .addData("message",msg)
//	        .build();
//	        MulticastResult result1 = sender.send(message,token,RETRY);
//	        if (result1 != null) {
//	            List<Result> resultList = result1.getResults();
//	            for (Result result : resultList) {
//	                System.out.println(result.getErrorCodeName()); 
//	            }
//	        }
//	    }catch (Exception e) {
//	        e.printStackTrace();
//	    }
	}
}
