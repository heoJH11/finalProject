package kr.or.ddit.chatting.vo;

import java.util.List;

public class MsgPaging<T> {
	
	private int total;
	
	private int currentPage;
	
	private int totalPages;
	
	private int startPage;
	
	private int endPage;
	
	private List<T> content;
	
	public MsgPaging(int total , int currentPage , int size , List<T> content) {
		
		this.total = total;
		this.currentPage = currentPage;
		this.content = content;
		
		if(total == 0) {
			totalPages = 0;
			startPage = 0;
			endPage = 0;
		} else {
			
			totalPages = total / size;
			
			if(total % size > 0) {
				totalPages ++;
			}
			
		}
		
		
	}

}
