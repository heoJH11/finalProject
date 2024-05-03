package kr.or.ddit.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class BrtcVO {
									// 지역(구) 테이블
	private String brtcCode;		// 지역(구) 코드
	private String bcityCode;		// 지역(시) 코드
	private String brtcNm;			// 지역(구) 명

}
