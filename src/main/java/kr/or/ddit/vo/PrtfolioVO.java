package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class PrtfolioVO {
	private int prtfolioNo;
	private String prtfolioSj;
	private Date prtfolioWrDt;
	private int sprviseAtchmnflNo;
	private String proId;
	
	private MultipartFile[] uploadFile;

	//중첩된 자바빈
	//PRTFOLIO : SPRVISE_ATCHMNFL = 1 : N
	private List<SprviseAtchmnflVO> SpAtVOList;
}
