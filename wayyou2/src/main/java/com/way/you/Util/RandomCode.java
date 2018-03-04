package com.way.you.Util;

import java.util.Random;

public class RandomCode {

	//사용자 인증코드 만들기
	public static String makeUserRandomCode() {
		Random rnd =new Random();
		StringBuffer buf =new StringBuffer();
		for(int i=0;i<10;i++){
			if(rnd.nextBoolean()){
				buf.append((char)((int)(rnd.nextInt(26))+97));
			}else{
				buf.append((rnd.nextInt(10))); 
			}
		}
		return buf.toString();
	}
}
