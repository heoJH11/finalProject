package kr.or.ddit.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class OneInqryAnswerVO {

	private int oneInqryAnswerNo;
	private String oneInqryAnswerCn;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date oneInqryAnswerWrDt;
	private int oneInqryNo;
	private String userId;
	private String mngrId;
	
}

