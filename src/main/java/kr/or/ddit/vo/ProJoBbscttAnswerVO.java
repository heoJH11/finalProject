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
public class ProJoBbscttAnswerVO {
	private int proJoAnswerNo;
	private int proJoBbscttNo;
	private String proJoAnswerCn;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy.MM.dd HH:mm:ss", timezone="Asia/Seoul")
	private Date proJoAnswerWrDt;
	private String proId;
	private String proNcnm;
	private String proProflPhoto;
}
