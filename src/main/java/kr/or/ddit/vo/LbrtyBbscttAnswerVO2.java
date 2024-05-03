package kr.or.ddit.vo;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class LbrtyBbscttAnswerVO2 {
	private int lbrtyBbscttAnswerNo;
	private int lbrtyBbscttNo;
	private String lbrtyBbscttAnswerCn;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy.MM.dd HH:mm")
	private Date lbrtyBbscttAnswerWrDt;
	private int ptLbrtyBbscttAnswerNo;
	private int ptLbrtyBbscttNo;
	private String userId;
	private String userNcnm;
}
