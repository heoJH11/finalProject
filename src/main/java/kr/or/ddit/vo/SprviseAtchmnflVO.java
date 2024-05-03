package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class SprviseAtchmnflVO {
	private int sprviseAtchmnflNo;	//통합 첨부 파일 게시글 번호
	private int atchmnflNo;	//첨부파일 순번
	private String atchmnflCours;	//파일 경로
	private String atchmnflNm;	//원본 파일명
	private String storeAtchmnflNm;	//저장파일 명
	private String atchmnflTy;	//파일유혈
	private Date registDt;	//등록일자
	private String userId;	//등록 아이디
	private Date updtDt;	//수정일자
}
