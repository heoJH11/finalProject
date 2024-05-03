package kr.or.ddit.vo;

import java.util.List;

import lombok.Data;

@Data
public class ProBkmkVO {

	private int proBkmkNo;
	private String proId;
	private String mberId;
	
	//중첩된 자바빈-프로즐겨찾기
	private List<ProVO> BkmkVOList;
	
	//중첩된자바빈-프로즐겨찾기
	private List<UsersVO> userBkVOList;
	
}

