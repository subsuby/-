package com.way.you.services;

import com.way.you.bean.Friend;
import com.way.you.bean.User;

public interface FriendService {

	User getFriendList(User user);

	User findFriendById(User user);

	String addFriend(Friend friend);

	
}
