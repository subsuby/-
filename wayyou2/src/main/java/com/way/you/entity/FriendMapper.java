package com.way.you.entity;

import java.util.List;

import com.way.you.bean.Friend;
import com.way.you.bean.User;
import com.way.you.config.Mapper;

@Mapper
public interface FriendMapper {

	List<Friend> getFriendList(User user);

	User getFriendInfo(Friend friend);

	User getUserInfo(User user);

	User findFriendById(User user);

	int addFriend(Friend friend);

}