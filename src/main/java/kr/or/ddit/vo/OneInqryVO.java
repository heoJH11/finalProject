package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class OneInqryVO {

	private int num;
	private int oneInqryNo;
	private String userId;
	private String oneInqrySj;
	private String oneInqryCn;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date oneInqryWritngDt;
	private int sprviseAtchmnflNo;
	
	List<OneInqryAnswerVO> oneInqryAnswerVOList;
	
	List<SprviseAtchmnflVO> sprviseAtchmnflVOList;
}

