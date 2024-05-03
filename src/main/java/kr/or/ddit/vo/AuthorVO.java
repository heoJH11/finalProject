package kr.or.ddit.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class AuthorVO {
									// 권한테이블
	private String author;			// 권한(관리자/일반회원/프로)
	private String userId;			// 아이디
	
}
