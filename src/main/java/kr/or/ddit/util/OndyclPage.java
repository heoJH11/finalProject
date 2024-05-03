package kr.or.ddit.util;

import java.util.List;

public class OndyclPage<T> {
	//전체글 수
	private int total;
	//현재 페이지 번호
	private int currentPage;
	//전체 페이지수
	private int totalPages;
	//블록의 시작 페이지 번호
	private int startPage;
	//블록의 종료 페이지 번호
	private int endPage;
	//검색어
	private String keyword = "";
	//요청URL
	private String url ="";
	//select 결과 데이터
	private List<T> content;
	//페이징 처리
	private String pagingArea = "";
	//블록 크기 - 페이징 번호표가 출력될 갯수
	private int blockSize = 3;
	
	//생성자(Construtor) : 페이징 정보 생성
	public OndyclPage(int total, int currentPage, int size, List<T> content, String keyword) {
		//size : 한 화면에 보여징 목록의 행 수
		this.total = total;
		this.currentPage = currentPage;
		this.content = content;
		this.keyword = keyword;
		
		//전체 글 수가 0이면?
		if(total == 0) {
			totalPages = 0; //전체 페이지 수
			startPage = 0; //블록 시작번호
			endPage = 0; //블록 끝 번호
		}else { //글이 존재한다면
			//전체 페이지 수 = 전체 글수 / 한 화면에 보여질 목록의 행 수
			totalPages = total / size;
			
			//나머지가 있다면, 페이지를 + 1
			if(total % size > 0) {
				totalPages++;
			}
			
			//페이지 블록 시작번호를 구하는 공식
			// 블록 시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = currentPage / blockSize * blockSize + 1;
			
			//현재페이지 % 페이지 크기 => 0일때 보정
			if(currentPage % blockSize == 0) {
				startPage -= blockSize;
			}
			
			//블록 종료번호 = 시작번호 + (페이지크기 - 1)
			endPage = startPage + (5 - 1);
			
			//종료페이지번호가 전체페이지수 보다 클 경우
			if(endPage > totalPages) {
				endPage = totalPages;
			}
		}
		
		pagingArea += "<div class='col-sm-12 col-md-7'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers'";
		pagingArea += "id='example2_paginate'>";
		pagingArea += "<ul class='pagination'>";
		pagingArea += "<li class='paginate_button page-item previous ";
		if(this.startPage < blockSize+1) {
			pagingArea += "disabled";
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='"+this.url+"?currentPage="+(this.startPage-blockSize)+"&keyword="+this.keyword+"'";
		pagingArea += "aria-controls='example2' data-dt-idx='0'";
		pagingArea += "tabindex='0' class='page-link'>Previous</a></li>";
		for(int pNo=this.startPage; pNo<=this.endPage; pNo++) {
			pagingArea += "<li class='paginate_button page-item ";
			if(this.currentPage == pNo) {
				pagingArea += "active";
			}
			pagingArea += "'>";
			pagingArea += "<a href='"+this.url+"?currentPage="+pNo+"&keyword="+this.keyword+"'";
			pagingArea += "aria-controls='example2' data-dt-idx='1' tabindex='0'";
			pagingArea += "class='page-link'>"+pNo+"</a></li>";
		}
		pagingArea += "<li class='paginate_button page-item next ";
		if(this.endPage >= this.totalPages) {
			pagingArea += "disabled";
		}
		pagingArea += "' id='example2_next'>";
		pagingArea += "<a href='"+this.url+"?currentPage="+(this.startPage+blockSize)+"&keyword="+this.keyword+"' aria-controls='example2' data-dt-idx='7'";
		pagingArea += "tabindex='0' class='page-link'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";
	} //생성자 끝
	
	//생성자(Construtor) : 페이징 정보 생성
	public OndyclPage(int total, int currentPage, int size, List<T> content) {
		//size : 한 화면에 보여징 목록의 행 수
		this.total = total;
		this.currentPage = currentPage;
		this.content = content;
		
		//전체 글 수가 0이면?
		if(total == 0) {
			totalPages = 0; //전체 페이지 수
			startPage = 0; //블록 시작번호
			endPage = 0; //블록 끝 번호
		}else { //글이 존재한다면
			//전체 페이지 수 = 전체 글수 / 한 화면에 보여질 목록의 행 수
			totalPages = total / size;
			
			//나머지가 있다면, 페이지를 + 1
			if(total % size > 0) {
				totalPages++;
			}
			
			//페이지 블록 시작번호를 구하는 공식
			// 블록 시작번호 = 현재페이지 / 페이지크기 * 페이지크기 + 1
			startPage = currentPage / 5 * 5 + 1;
			
			//현재페이지 % 페이지 크기 => 0일때 보정
			if(currentPage % 5 == 0) {
				startPage -= 5;
			}
			
			//블록 종료번호 = 시작번호 + (페이지크기 - 1)
			endPage = startPage + (5 - 1);
			
			//종료페이지번호가 전체페이지수 보다 클 경우
			if(endPage > totalPages) {
				endPage = totalPages;
			}
		}
		
		pagingArea += "<div class='col-sm-12 col-md-7'>";
		pagingArea += "<div class='dataTables_paginate paging_simple_numbers'";
		pagingArea += "id='example2_paginate'>";
		pagingArea += "<ul class='pagination'>";
		pagingArea += "<li class='paginate_button page-item previous ";
		if(this.startPage < blockSize+1) {
			pagingArea += "disabled";
		}
		pagingArea += "'";
		pagingArea += "id='example2_previous'>";
		pagingArea += "<a href='"+this.url+"?currentPage="+(this.startPage-blockSize)+"&keyword="+this.keyword+"'";
		pagingArea += "aria-controls='example2' data-dt-idx='0'";
		pagingArea += "tabindex='0' class='page-link'>Previous</a></li>";
		for(int pNo=this.startPage; pNo<=this.endPage; pNo++) {
			pagingArea += "<li class='paginate_button page-item ";
			if(this.currentPage == pNo) {
				pagingArea += "active";
			}
			pagingArea += "'>";
			pagingArea += "<a href='"+this.url+"?currentPage="+pNo+"&keyword="+this.keyword+"'";
			pagingArea += "aria-controls='example2' data-dt-idx='1' tabindex='0'";
			pagingArea += "class='page-link'>"+pNo+"</a></li>";
		}
		pagingArea += "<li class='paginate_button page-item next ";
		if(this.endPage >= this.totalPages) {
			pagingArea += "disabled";
		}
		pagingArea += "' id='example2_next'>";
		pagingArea += "<a href='"+this.url+"?currentPage="+(this.startPage+blockSize)+"&keyword="+this.keyword+"' aria-controls='example2' data-dt-idx='7'";
		pagingArea += "tabindex='0' class='page-link'>Next</a></li>";
		pagingArea += "</ul>";
		pagingArea += "</div>";
		pagingArea += "</div>";
	} //생성자 끝

	public int getTotal() {
		return total;
	}

	public void setTotal(int total) {
		this.total = total;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getTotalPages() {
		return totalPages;
	}

	public void setTotalPages(int totalPages) {
		this.totalPages = totalPages;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public List<T> getContent() {
		return content;
	}

	public void setContent(List<T> content) {
		this.content = content;
	}

	//전체 글의 수가 0인가?
	public boolean hasNoArtivles() {
		return this.total == 0;
	}
	
	//데이터가 있나?
	public boolean hasArticles() {
		return this.total > 0;
	}
	
	//페이징 블록 자동화
	public String getPagingArea() {
		return this.pagingArea;
	}

	public void setPagingArea(String pagingArea) {
		this.pagingArea = pagingArea;
	}

	public int getBlockSize() {
		return blockSize;
	}

	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}

	@Override
	public String toString() {
		return "ArticlePage [total=" + total + ", currentPage=" + currentPage + ", totalPages=" + totalPages
				+ ", startPage=" + startPage + ", endPage=" + endPage + ", keyword=" + keyword + ", url=" + url
				+ ", content=" + content + ", pagingArea=" + pagingArea + ", blockSize=" + blockSize + "]";
	}
}
