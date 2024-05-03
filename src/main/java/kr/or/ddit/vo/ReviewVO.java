package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;

import kr.or.ddit.pro_service.service_request.vo.V_SrvcRequstVO;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class ReviewVO {
	private int reNo;
	private String reTy;
	private String reCn;
	@JsonFormat(shape=JsonFormat.Shape.STRING, pattern="yyyy-MM-dd HH:mm:ss", timezone="Asia/Seoul")
	private Date reWrDt;
	private int reScore;
	private int srvcRequstNo;
	
	private List<V_SrvcRequstVO> vSrvcRequstVOList;
	private List<SrvcRequstVO> srvcReVOList;
	private List<MberVO> mberReviewVOList;
	private List<UsersVO> userReviewVOList;
	private List<CommonCdDetailVO> comReviewVOList;
	
}
