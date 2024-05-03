package kr.or.ddit.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class ProCprtnBbscttVO {

	private int proCprtnBbscttNo;
	private String proCprtnBbscttSj;
	private String proCprtnBbscttCn;
	private Date proCprtnBbscttWrDt;
	private int proCprtnBbscttRdcnt;
	private int sprviseAtchmnflNo; 
	
}

