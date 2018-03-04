package com.way.you.services.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.way.you.bean.User;
import com.way.you.entity.LoginMapper;
import com.way.you.services.LoginService;

@Service("LoginService")
public class LoginServiceImpl implements LoginService {
	
	@Autowired LoginMapper loginMapper;

	@Override
	@Transactional
	public int signUp(User user) {
		//DB insert
		int signYn = loginMapper.signUp(user);
		
		return signYn;
	}

	@Override
	@Transactional
	public User userConfirm(User user) {
		try {
			//DB select
			user = loginMapper.selectByUserConfirmCode(user);
			//DB update
			int result = loginMapper.userConfirm(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

	@Override
	@Transactional
	public User findId(User user) {
		try {
			//DB select
			user = loginMapper.findUserId(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

	@Override
	@Transactional
	public int findPwd(User user) {
		int result = 0;
		try {
			//DB update
			result = loginMapper.updatePwdFindCode(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	@Transactional
	public int pwdFindCode(User user) {
		int result = 0;
		try {
			//DB update
			result = loginMapper.pwdFindCode(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	@Transactional
	public int resetPassword(User user) {
		int result = 0;
		try {
			//DB update
			result = loginMapper.resetPassword(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	@Transactional
	public int login(User user) {
		int result = 0;
		try {
			//DB select
			result = loginMapper.login(user);
			loginMapper.setToken(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public int duplicate(User user) {
		int result = 0;
		try {
			//DB select
			result = loginMapper.duplicate(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public User getMyInfo(User user) {
		try {
			//DB select
			user = loginMapper.getMyInfo(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public User changeMyInfo(User user) {
		try {
			//DB update
			loginMapper.changeMyInfo(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

	@Override
	public String getNewInfo(User param) {
		String result = "false";
		try {
			//DB update
			int i = loginMapper.getnewInfo(param);
			if(i >= 1) {
				result = "true";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
}
