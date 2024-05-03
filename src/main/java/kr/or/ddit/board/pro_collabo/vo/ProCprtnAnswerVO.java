package kr.or.ddit.board.pro_collabo.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class ProCprtnAnswerVO {

	private int proCprtnAnswerNo;
	private int proCprtnBbscttNo;
	private String proCprtnAnswerCn;
	private Date proCprtnAnswerWrDt;
	private String proId;
	
}

