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
public class SrvcRequstVO {
	private int srvcRequstNo;
	private String srvcRequstSj;
	private String srvcRequstCn;
	private Date srvcRequstWrDt;
	private String mberId;
	private String proId;
	private String srvcRequstProcessAt;
	private String srvcRequstProcessMber;
	private String srvcRequstProcessPro;
	private String srvcRequstItyy;
	private Date srvcRequstComptDt;
	private int srvcRequstLastPc;
	private int sprviseAtchmnflNo;
}
