package kr.or.ddit.board.pro_story.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@ToString
public class GoodPointVO {

	private int goodNo;						// good번호
	private int proStoryBbscttNo;			// 
	private String userId;					// 
	
	public GoodPointVO(int proStoryBbscttNo , String userId) {
		this.proStoryBbscttNo = proStoryBbscttNo;
		this.userId = userId;
	}
	
}
