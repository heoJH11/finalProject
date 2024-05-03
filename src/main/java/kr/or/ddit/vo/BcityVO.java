package kr.or.ddit.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class BcityVO {
									// 지역(시) 테이블
	private String bcityCode;		// 지역(시) 코드
	private String bcityNm;			// 지역(시) 명
}
