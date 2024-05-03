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
public class SrvcBtfInqryVO {
	private int num; //rownum 번호
	private int btfInqryNo;
	private String mberId;
	private String btfInqrySj;
	private String btfInqryCn;
	private Date btfInqryWrDt;
	private String btfInqryAnswerCn;
	private Date btfInqryAnswerWrDt;
	private int sprviseAtchmnflNo;
	private String proId;
}
