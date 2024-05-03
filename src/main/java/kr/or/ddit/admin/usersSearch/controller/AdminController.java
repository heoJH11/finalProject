package kr.or.ddit.admin.usersSearch.controller;

import org.springframework.beans.factory.annotation.Autowired;

public class AdminController {
	
	@Autowired
	UserService userService;
	
	public String adminLogin(String userId) {
		
		String userType = this.userService.userType(userId);

		if(userType.equals("ET03")) {
			
		} else if(userType.equals("ET02")) {
			
		} else if(userType.equals("ET01")) {
		
		}
		
		return "";
	}

}
