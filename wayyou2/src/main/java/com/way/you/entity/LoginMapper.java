package com.way.you.entity;

import com.way.you.bean.User;
import com.way.you.config.Mapper;

/**
 * {@link Member} 모델의 Data Access를 담당하는 마이바티스 매퍼 인터페이스
 *
 * 마이바티스 매퍼 XML[src/main/resources/META-INF/mybatis/mappers/MemberMapper.xml]과 연결된다.
 *
 * @author arawn.kr@gmail.com
 */
@Mapper
public interface LoginMapper {

	int signUp(User user);

	User selectByUserConfirmCode(User user);

	int userConfirm(User user);

	User findUserId(User user);

	int updatePwdFindCode(User user);

	int pwdFindCode(User user);

	int resetPassword(User user);

	int login(User user);

	int duplicate(User user);

	User getMyInfo(User user);

	void changeMyInfo(User user);

	int getnewInfo(User param);

	void setToken(User user);
}