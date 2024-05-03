package kr.or.ddit.admin.usersSearch.controller;

import org.springframework.beans.factory.annotation.Autowired;

public class UserServiceImpl implements UserService {

	@Autowired
	UserMapper userMapper;
	
	@Override
	public String userType(String userId) {
		return this.userMapper.userType(userId);
	}

}
