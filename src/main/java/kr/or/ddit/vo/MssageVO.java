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
public class MssageVO {
	
	private int mssageNo;
	private Date mssageTrnsmisDt;
	private String mssageCn;
	private int mssageCnfirmAt;
	private int chttSpceNo;
	private String userId;
	
}
