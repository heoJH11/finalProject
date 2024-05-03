package kr.or.ddit.board.pro_story.vo;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class ProStoryBbscttVO {
/*
게시글 번호(자동증가 , sequence)		proStoryBbscttNo	           
게시글 제목(직접입력)					proStoryBbscttSj           
게시글 내용(직접입력)					proStoryBbscttCn           
게시글 작성일자(sysdate)				proStoryBbscttWrDt         
게시글 추천수(별도)					proStoryBbscttRecommend        
게시글 조회수(별도)					proStoryBbscttRdcnt            
프로이야기게시글썸네일사진(직접입력)		proStoryBbscttThumbPhoto           
통합첨부파일(사진, 직접등록)			sprviceAtchmnflNo              
프로아이디							proId
*/                                                         
	private int    proStoryBbscttNo;			// 게시글 번호
	private String proStoryBbscttSj;			// 게시글 제목
	private String proStoryBbscttCn;			// 게시글 내용
	
	private String proStoryBbscttWrDt;			// 게시글 작성일
	
	private int    proStoryBbscttRecommend;		// 게시글 추천수
	private int    proStoryBbscttRdcnt;			// 게시글 조회수
	private String proStoryBbscttThumbPhoto;	// 게시글 썸네일
	private int    sprviseAtchmnflNo;			// 통합첨부파일번호
	private String proId;						// 프로아이디(=userId)
	
	private String userId;						// 유저 아이디
	private String userNm;						// 유저 이름
	private int    secsnAt;						// 탈퇴여부
	private String emplyrTy;					// 사용자 유형
	private String userNcnm;					// 유저 닉네임
	
	private String proMbtlnum; 					// 전화번호       
	private String sexdstnTy; 					// 성별          
	private String email; 						// 이메일             
	private String proProflPhoto; 				// 프로필사진   
	private String spcltyRealmCode; 			// 전문분야코드
	private String spcltyRealmNm; 				// 전문분야코드
	private String spcltyRealmCodeBase; 		// 전문분야코드(하위)

	private MultipartFile uploadFile;
	
}
