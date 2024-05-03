package kr.or.ddit.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class AftusBbscttAnswerVO {
	
	private int aftusBbscttAnswerNo;			// 댓글번호
	private String aftusBbscttAnswerCn;			// 댓글내용
	private String aftusBbscttAnswerWrDt;		// 댓글작성일
	private String userId;						// 댓글작성자아이디
	private int aftusBbscttNo;					// 게시글번호
	private int ptAftusBbscttNo;				// 댓글 게시글 번호
	private int ptAftusBbscttAnswerNo;			// 부모 댓글 번호
	private String UserNcnm;					// 닉네임
	private String mberProflPhoto;				// 회원 프로필 사진
	private String proProflPhoto;				// 프로 프로필 사진
}
