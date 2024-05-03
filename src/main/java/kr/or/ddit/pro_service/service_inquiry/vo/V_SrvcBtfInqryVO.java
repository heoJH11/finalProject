package kr.or.ddit.pro_service.service_inquiry.vo;

import java.util.Date;

import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.ddit.vo.SprviseAtchmnflVO;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class V_SrvcBtfInqryVO {
	
	private int num; // rownum 번
	private int btfInqryNo;
	private String btfInqrySj;
	private String btfInqryCn;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date btfInqryWrDt;
	private String mberId;
	private String proId;
	private int sprviseAtchmnflNo;
	private String btfInqryAnswerCn;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date btfInqryAnswerWrDt;
	private String userId;
	private String userNcnm;
	private String emplyrTy;

	private List<SprviseAtchmnflVO> sprviseAtchmnflVOList;

}
