package kr.or.ddit.admin.usersSearch.vo;

import lombok.Data;

@Data
public class UsersVO {
	private int rnum;
	private String userId;
	private String userNcnm;
	private String userNm;
	private String userPassword;
	private String emplyrTy;
	private int secsnAt;
}
