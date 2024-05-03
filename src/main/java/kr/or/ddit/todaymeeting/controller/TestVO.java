package kr.or.ddit.todaymeeting.controller;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class TestVO {

	private int currentPage;
	private int tdmtngNo;
	private int endPage;

	public TestVO(int currentPage , int tdmtngNo , int endPage ) {
		
		this.currentPage = currentPage;
		this.tdmtngNo = tdmtngNo;
		this.endPage = endPage;
	}
}
