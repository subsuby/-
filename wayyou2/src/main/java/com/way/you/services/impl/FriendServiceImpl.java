package com.way.you.services.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.way.you.bean.Friend;
import com.way.you.bean.User;
import com.way.you.entity.FriendMapper;
import com.way.you.services.FriendService;

@Service("FriendService")
public class FriendServiceImpl implements FriendService {

	@Autowired FriendMapper friendMapper;

	@Override
	@Transactional
	public User getFriendList(User user) {
		String schKey = user.getSearchKey();
		try {
			user = friendMapper.getUserInfo(user);
			user.setSearchKey(schKey);
			List<Friend> friend = friendMapper.getFriendList(user);
			for(int i = 0; i < friend.size(); i++) {
				friend.get(i).setFriend(friendMapper.getFriendInfo(friend.get(i)));
			}
			user.setFriend(friend);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

	@Override
	@Transactional
	public User findFriendById(User user) {
		try {
			user = friendMapper.findFriendById(user);
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return user;
	}

	@Override
	@Transactional
	public String addFriend(Friend friend) {
		String result = "false";
		try {
			int insert = friendMapper.addFriend(friend);
			String userId = friend.getUserId();
			String userFriendId = friend.getUserFriendId();
			friend.setUserId(userFriendId);
			friend.setUserFriendId(userId);
			friendMapper.addFriend(friend);
			if(insert == 1) {
				result = "true";
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
