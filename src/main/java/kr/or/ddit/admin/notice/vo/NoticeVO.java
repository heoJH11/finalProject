package kr.or.ddit.admin.notice.vo;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.SprviseAtchmnflVO;
import lombok.Data;

@Data
public class NoticeVO {
	private int rnum;
	private int noticeNo;
	private String noticeSj;
	private String noticeCn;
	@DateTimeFormat(pattern="YYYY-MM-dd")
	private Date noticeWritngDt;
	private int noticeRdcnt;
	private int sprviseAtchmnflNo;
	private String mngrId;
	
	private MultipartFile[] uploadFile;
	
	//NOTICE : SPRVISE_ATCHMNFL = 1 : N
	private List<SprviseAtchmnflVO> spAtVOList;
}
