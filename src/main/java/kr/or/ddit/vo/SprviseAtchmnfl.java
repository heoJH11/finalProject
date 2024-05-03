package kr.or.ddit.vo;

import java.util.Date;

import lombok.Data;

@Data
public class SprviseAtchmnfl {
	private int sprviseAtchmnflNo;
	private int atchmnflNo;
	private String atchmnflCours;
	private String atchmnflNm;
	private String storeAtchmnflNm;
	private String atchmnflTy;
	private Date registDt;
	private String userId;
	private Date updtDt;
}
