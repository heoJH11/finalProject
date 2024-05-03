package kr.or.ddit.alarm.vo;

import java.util.Date;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;
@Getter
@Setter
@ToString
@NoArgsConstructor
public class NtchVO {
	
	private int ntchNo;									// 알림 번호
	private String ntchCn;								// 알림 내용
	private Date ntchDt;								// 알림 일시
	private String ntchMvmnUrl;							// URL
	private String urlMvmnTagetNm;						//
	private String userId;								// 알림 대상자 아이디
}
