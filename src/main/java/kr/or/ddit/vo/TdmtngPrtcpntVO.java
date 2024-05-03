package kr.or.ddit.vo;


import java.util.List;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class TdmtngPrtcpntVO {
	
	private String userId;
	private int tdmtngNo;
	private String mberProflPhoto;
	private String proProflPhoto;
	
	List<UsersVO> usersVOList;

	
	
	public TdmtngPrtcpntVO(String userId , int tdmtngNo){
		this.tdmtngNo = tdmtngNo;
		this.userId = userId;
	}
}
