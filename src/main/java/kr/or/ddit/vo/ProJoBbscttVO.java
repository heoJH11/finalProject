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
public class ProJoBbscttVO {
	int num;
	private int proJoBbscttNo;
	private String proJoBbscttSj;
	private String proJoBbscttCn;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy.MM.dd HH:mm:ss", timezone="Asia/Seoul")
	private Date proJoBbscttWrDt;
	private int proJoBbscttRdcnt;
	private String mberId;
	private int sprviseAtchmnflNo;
	
	private List<ProJoBbscttAnswerVO> proJoBbscttAnswerVOList;
	
	private List<MberVO> mberVOList;
	
	private List<ProVO> proVOList;
	
	private List<SprviseAtchmnflVO> sprviseAtchmnflVOList;
}
