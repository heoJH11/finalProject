package kr.or.ddit.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class UsersVO {
	
	private String userId; 				// 아이디
	private String userNm; 				// 이름
	private String userPassword; 		// 비밀번호
	private String emplyrTy; 			// 사용자 유형
	private int secsnAt; 				// 탈퇴여부
	private String userNcnm; 			// 닉네임
	private String changePwCk;			//임시비번 확인여부
	
	private String mberProflPhoto;
	private String proProflPhoto;

	// 별도로 쓰기 위해 생성
	private String proflPhoto;
	
	private int cnt; 					// 로그인 확인용
	private int declCount; 				// 신고횟수
	
}