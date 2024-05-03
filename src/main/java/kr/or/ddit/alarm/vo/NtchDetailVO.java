package kr.or.ddit.alarm.vo;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class NtchDetailVO {
	
	private int ntchDetailSn;					// 알림일련번호
	private int ntchNo;							// 알림번호
	private int ntchDetailCnfirm;				// 확인여부
	private String userId;						// 알림 대상자 아이디
	private String ntMsg;

}
