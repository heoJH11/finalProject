package kr.or.ddit.board.pro_collabo.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import kr.or.ddit.vo.ProProflVO;
import kr.or.ddit.vo.ProVO;
import kr.or.ddit.vo.SprviseAtchmnflVO;
import lombok.Data;

@Data
public class ProCprtnBbscttVO {

	private int rnum;
	private int proCprtnBbscttNo;
	private String proCprtnBbscttSj;
	private String proCprtnBbscttCn;
	@DateTimeFormat(pattern="YYYY-MM-dd HH:mm:ss")
	private Date proCprtnBbscttWrDt;
	private int proCprtnBbscttRdcnt;
	private int sprviseAtchmnflNo;
	private String proId;
	
	private List<SprviseAtchmnflVO> spAtVOList;
	
	private List<ProVO> proList;
	private List<ProProflVO> proProflList;
	
	private String userNcnm;
	private String proProflPhoto;
}
