package kr.or.ddit.pro_service.service_request.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.ddit.vo.SprviseAtchmnflVO;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class V_SrvcRequstVO {

	private int num; //rownum 번호
	private int srvcRequstNo;
	private String srvcRequstSj;
	private String srvcRequstCn;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date srvcRequstWrDt;
	private String mberId;
	private String proId;
	private String srvcRequstProcessAt;
	private String srvcRequstProcessMber;
	private String srvcRequstProcessPro;
	private String srvcRequstItyy;
	private Date srvcRequstComptDt;
	private int sprviseAtchmnflNo;
	private String userId;
	private String userNcnm;
	private String emplyrTy;
	private String proProflPhoto;
	
	private List<SprviseAtchmnflVO> sprviseAtchmnflVOList;
	
}
